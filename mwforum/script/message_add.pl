#!/usr/bin/perl
#------------------------------------------------------------------------------
#    mwForum - Web-based discussion forum
#    Copyright (c) 1999-2011 Markus Wichitill
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#------------------------------------------------------------------------------

use strict;
use warnings;
no warnings qw(uninitialized redefine);

# Imports
use MwfMain;

#------------------------------------------------------------------------------

# Init
my ($m, $cfg, $lng, $user, $userId) = MwfMain->new(@_);

# Check if access should be denied
$cfg->{messages} or $m->error('errNoAccess');
$userId or $m->error('errNoAccess');

# Load additional modules
require MwfCaptcha if $cfg->{captcha};

# Check if user has been registered for long enough
$m->{now} > $user->{regTime} + $cfg->{minRegTime}
	or $m->error($m->formatStr($lng->{errMinRegTim}, { hours => $cfg->{minRegTime} / 3600 }))
	if $cfg->{minRegTime};

# Get CGI parameters
my $recvId = $m->paramInt('uid');
my $recvNames = $m->paramStr('recvNames');
my $refMsgId = $m->paramInt('mid');
my $subject = $m->paramStr('subject');
my $body = $m->paramStr('body');
my $wantQuote = $m->paramBool('quote');
my $add = $m->paramBool('add');
my $preview = $m->paramBool('preview');

# Get referenced message
my $refMsg = undef;
my $refSubject = undef;
if ($refMsgId) {
	$refMsg = $m->fetchHash("
		SELECT messages.*, senders.userName
		FROM messages AS messages
			INNER JOIN users AS senders
				ON senders.id = messages.senderId
		WHERE messages.id = ?", $refMsgId);
	$refMsg or $m->error('errMsgNotFnd');
	$refMsg->{receiverId} == $userId or $m->error('errNoAccess');
	$recvId ||= $refMsg->{senderId};
	$refSubject = $refMsg->{subject} =~ /Re:/ ? $refMsg->{subject} : "Re: $refMsg->{subject}";
	$refSubject = substr($refSubject, 0, $cfg->{maxSubjectLen});
}

# Get recipient ids and names
my @recvIds = ();
if ($recvNames) {
	if ($cfg->{maxMsgRecv} == 1) {
		# Username from form when only one recipient is allowed
		$recvId = $m->fetchArray("
			SELECT id FROM users WHERE userName = ?", $recvNames);
		$recvId or $m->formError('errUsrNotFnd');
		push @recvIds, $recvId;
	}
	else {
		# User/group names from form when multiple recipients are allowed
		my @recvNames = split(/\s*;\s*/, $recvNames);
		@recvNames or $m->formError('errUsrNotFnd');
		for my $name (@recvNames) {
			if (substr($name, 0, 1) eq '!') {
				# Expand group
				my @ids = $m->getMemberIds($name);
				@ids or $m->formError(substr($name, 1) . ": $lng->{errGrpNotFnd}");
				push @recvIds, @ids;
			}
			else {
				# Individual user
				my $id = $m->fetchArray("
					SELECT id FROM users WHERE userName = ?", $name);
				if ($id) { push @recvIds, $id }
				else { $m->formError("$name: $lng->{errUsrNotFnd}") }
			}
		}
		
		# Remove dupes
		my %h = ();
		@recvIds = map($h{$_}++ == 0 ? $_ : (), @recvIds);
		%h = ();
		@recvNames = map($h{$_}++ == 0 ? $_ : (), @recvNames);
		
		# Limit number of recipients
		if (@recvNames > $cfg->{maxMsgRecv}) {
			@recvNames = @recvNames[0 .. $cfg->{maxMsgRecv} - 1];
			$m->formError('errRecvNum');
		}

		$recvId = @recvIds == 1 ? $recvIds[0] : -1;
		$recvNames = join("; ", @recvNames);
	}
}
elsif ($recvId) {
	# User id passed from user_info page etc.
	$recvNames = $m->fetchArray("
		SELECT userName FROM users WHERE id = ?", $recvId);
	$recvNames or $m->formError('errUsrNotFnd');
	push @recvIds, $recvId;
}

# Process form
if ($add) {
	# Check request source authentication
	$m->checkSourceAuth() or $m->formError('errSrcAuth');

	# Flood control
	if ($cfg->{repostTime} && !$user->{admin}) {
		my $lastPostTime = $m->fetchArray("
			SELECT MAX(sendTime) FROM messages WHERE senderId = ?", $userId);
		my $waitTime = $cfg->{repostTime} - ($m->{now} - $lastPostTime);
		my $errStr = $m->formatStr($lng->{errRepostTim}, { seconds => $waitTime });
		$waitTime < 1 or $m->formError($errStr);
	}
	
	# Check subject/body length
	length($subject) or $m->formError('errSubEmpty');
	length($subject) <= $cfg->{maxSubjectLen} or $m->formError('errSubLen');
	$subject =~ /\S/ or $m->formError('errSubNoText') if length($subject);
	length($body) <= $cfg->{maxBodyLen} or $m->formError('errBdyLen');
	
	# Translate text
	my $msg = { isMessage => 1, subject => $subject, body => $body };
	$m->editToDb({}, $msg);
	length($body) or $m->formError('errBdyEmpty');

	# Check recipient and captcha
	@recvIds or $m->formError('errNamEmpty');
	MwfCaptcha::checkCaptcha($m, 'msgCpt') if $cfg->{captcha} >= 3;

	# If there's no error, finish action
	if (!@{$m->{formErrors}}) {
		my $msgId = undef;
		for my $id (@recvIds) {
			# Check if recipient ignores sender
			my $ignored = $m->fetchArray("
				SELECT 1 FROM userIgnores WHERE userId = ? AND ignoredId = ?", $id, $userId);
	
			# Insert message
			my $inbox = $ignored ? 0 : 1;
			$m->dbDo("
				INSERT INTO messages (senderId, receiverId, sendTime, inbox, sentbox, subject, body) 
				VALUES (?, ?, ?, ?, ?, ?, ?)",
				$userId, $id, $m->{now}, $inbox, 1, $msg->{subject}, $msg->{body});
			$msgId = $m->dbInsertId("messages");
			next if $ignored;
	
			# Add notification message
			my $url = "message_show$m->{ext}?mid=$msgId";
			$m->addNote('msgAdd', $id, 'notMsgAdd', usrNam => $user->{userName}, msgUrl => $url);
			
			# Send notification email
			my $recvUser = $m->getUser($id);
			if ($recvUser->{msgNotify} && $recvUser->{email} && !$recvUser->{dontEmail}) {
				$m->sendEmail($m->createEmail(
					type     => 'msgNtf',
					user     => $recvUser,
					sendUser => $user,
					board    => {},
					msg      => $msg,
					url      => "$cfg->{baseUrl}$m->{env}{scriptUrlPath}/$url",
				));
			}
		}
		
		# Update referenced message status
		$m->dbDo("
			UPDATE messages SET hasRead = 2 WHERE id = ?", $refMsgId) 
			if $refMsgId && $refMsg->{hasRead} < 2;

		# Log action and finish
		$m->logAction(1, 'msg', 'add', $userId, 0, 0, 0, $msgId);
		$m->redirect('message_list', msg => 'MsgAdd');
	}
}

# Print form
if (!$add || @{$m->{formErrors}}) {
	# Print header
	$m->printHeader(undef, { tagButtons => 1, lng_tbbInsSnip => $lng->{tbbInsSnip} });

	# Print page bar
	my @navLinks = ({ url => $m->url('message_list'), txt => 'comUp', ico => 'up' });
	$m->printPageBar(mainTitle => $lng->{msaTitle}, navLinks => \@navLinks);
	
	# Quote message body
	my $quote = undef;
	if ($refMsg && $wantQuote && $cfg->{quote}) {
		eval { require Text::Flowed } or $m->error("Text::Flowed module not available.");
		$quote = $refMsg->{body};
		$quote =~ s!<br/>!\n!g;  # Preserve linebreaks before removing tags
		$quote =~ s!<.+?>!!g;  # Remove tags before quoting
		$quote = $m->deescHtml($quote);
		$quote = Text::Flowed::reformat($quote, { quote => 1, fixed => 1,
			max_length => $cfg->{quoteCols}, opt_length => $cfg->{quoteCols} - 6 });
	}

	# Prepare preview body
	if ($preview) {
		$preview = { isMessage => 1, body => $body };
		$m->editToDb({}, $preview);
		$m->dbToDisplay({}, $preview);
	}

	# Prepare other values
	my $subjectEsc = $m->escHtml($subject);
	$subjectEsc ||= $refSubject;
	$body ||= $quote;
	my $bodyEsc = $m->escHtml($body, 1);
	$m->dbToDisplay({}, $refMsg) if $refMsg;
	my $recptLabel = $cfg->{maxMsgRecv} > 1 
		? $m->formatStr($lng->{msaSendRecvM}, { maxRcv => $cfg->{maxMsgRecv} }) 
		: $lng->{msaSendRecv};

	# Print hints and form errors
	$m->printFormErrors();
	
	# Print message form
	print
		"<form action='message_add$m->{ext}' method='post'>\n",
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>$lng->{msaSendTtl}</span></div>\n",
		"<div class='ccl'>\n",
		"<fieldset>\n",
		"<label class='lbw'>$recptLabel\n";

	my $userNum = $m->fetchArray("
		SELECT COUNT(*) FROM users");
	if ($userNum > $cfg->{maxListUsers} || $cfg->{maxMsgRecv} > 1) {
		my $size = $cfg->{maxMsgRecv} > 1 ? 80 : 20;
		my $recvNamesEsc = $m->escHtml($recvNames);
		print 
			"<input type='text' class='fcs' name='recvNames' size='$size'",
			" autofocus='autofocus' required='required' value='$recvNamesEsc'/></label>\n";
	}
	else {
		my $users = $m->fetchAllArray("
			SELECT id, userName FROM users ORDER BY userName");
		my %sel = ( $recvNames => "selected='selected'" );
		print 
			"<select class='fcs' name='uid' size='1' autofocus='autofocus'>\n",
			map("<option value='$_->[0]' $sel{$_->[1]}>$_->[1]</option>\n", @$users),
			"</select></label>\n";
	}
	
	print
		"<label class='lbw'>$lng->{msaSendSbj}\n",
		"<input type='text' name='subject' size='80' maxlength='$cfg->{maxSubjectLen}'",
		" required='required' value='$subjectEsc'/></label>\n",
		"</fieldset>\n",
		"<fieldset>\n",
		$m->tagButtons({ id => 0 }),
		"<textarea class='tgi' name='body' rows='14' required='required'>$bodyEsc</textarea>\n",
		$cfg->{captcha} >= 3 ? MwfCaptcha::captchaInputs($m, 'msgCpt') : "",
		"</fieldset>\n",
		$m->submitButton('msaSendB', 'write', 'add'),
		$m->submitButton('msaSendPrvB', 'preview', 'preview'),
		"<input type='hidden' name='mid' value='$refMsgId'/>\n",
		$m->stdFormFields(),
		"</div>\n",
		"</div>\n",
		"</form>\n\n";

	# Print preview
	print
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>$lng->{msaPrvTtl}</span></div>\n",
		"<div class='ccl'>\n",
		$preview->{body}, "\n",
		"</div>\n",
		"</div>\n\n"
		if $preview;
	
	# Print referenced message
	print
		"<div class='frm msg'>\n",
		"<div class='hcl'><span class='htt'>$lng->{msaRefTtl}</span> $refMsg->{userName}</div>\n",
		"<div class='ccl'>\n",
		"$refMsg->{body}\n",
		"</div>\n",
		"</div>\n\n"
		if $refMsgId;
	
	# Log action and finish
	$m->logAction(3, 'msg', 'add', $userId, 0, 0, 0, $recvId);
	$m->printFooter();
}
$m->finish();
