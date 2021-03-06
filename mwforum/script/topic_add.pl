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

# Load additional modules
require MwfCaptcha if $cfg->{captcha};

# Get CGI parameters
my $boardId = $m->paramInt('bid');
my $unregName = $cfg->{allowUnregName} ? $m->paramStr('name') : undef;
my $subject = $m->paramStr('subject');
my $body = $m->paramStr('body');
my $rawBody = $m->paramStr('raw', 0);
my $add = $m->paramBool('add');
my $preview = $m->paramBool('preview');
my $submitted = $m->paramBool('subm');
$boardId or $m->error('errParamMiss');

# Get board
my $board = $m->fetchHash("
	SELECT * FROM boards WHERE id = ?", $boardId);
$board or $m->error('errBrdNotFnd');

# Check if user is registered
$userId || $board->{unregistered} or $m->error('errNoAccess');

# Check if user has been registered for long enough
$m->{now} > $user->{regTime} + $cfg->{minRegTime}
	or $m->error($m->formatStr($lng->{errMinRegTim}, { hours => $cfg->{minRegTime} / 3600 }))
	if $cfg->{minRegTime} && $userId;

# Check authorization
$m->checkAuthz($user, 'newTopic');

# Check if user can see and write to board
my $boardAdmin = $user->{admin} || $m->boardAdmin($userId, $boardId);
my $boardMember = $m->boardMember($userId, $boardId);
$boardAdmin || $boardMember || $m->boardVisible($board) or $m->error('errNoAccess');
$boardAdmin || $boardMember || $m->boardWritable($board) or $m->error('errNoAccess');

# Process form
if ($add) {
	# Check request source authentication
	$m->checkSourceAuth() or $m->formError('errSrcAuth');

	# Flood control
	if ($cfg->{repostTime} && !$boardAdmin) {
		my $lastPostTime = $m->fetchArray("
			SELECT MAX(postTime) FROM posts WHERE userId = ?", $userId);
		my $waitTime = $cfg->{repostTime} - ($m->{now} - $lastPostTime);
		my $errStr = $m->formatStr($lng->{errRepostTim}, { seconds => $waitTime });
		$waitTime < 1 or $m->formError($errStr);
	}

	# Check subject/body length
	length($subject) or $m->formError('errSubEmpty');
	length($subject) <= $cfg->{maxSubjectLen} or $m->formError('errSubLen');
	$subject =~ /\S/ or $m->formError('errSubNoText') if length($subject);
	length($body) <= $cfg->{maxBodyLen} or $m->formError('errBdyLen');
	length($rawBody) <= $cfg->{maxBodyLen} or $m->formError('errBdyLen');

	# Check unregistered name
	if ($unregName && $unregName ne $cfg->{anonName}) {
		length($unregName) <= $cfg->{maxUserNameLen} or $m->formError('errNamSize');
		!$m->fetchArray("
			SELECT 1 FROM users WHERE userName = ?", $unregName)
			or $m->formError('errNamGone');
	}
	
	# Determine misc values
	my $approved = !$board->{approve} || $boardAdmin || ($boardMember && $board->{private} != 1)
		? 1 : 0;
	my $postUserId = $userId ? $userId : -1;
	my $anonUserName = $cfg->{anonName} eq 'ip' ? "$m->{env}{userIp}"
		: $m->escHtml($unregName) || $cfg->{anonName} || "?";
	my $postUserName = $userId ? $user->{userName} : $anonUserName;
	my $ip = $cfg->{recordIp} ? $m->{env}{userIp} : "";
	
	# Process text
	my $post = { subject => $subject, body => $body, rawBody => $rawBody };
	$m->editToDb($board, $post);
	length($post->{body}) or $m->formError('errBdyEmpty');

	# Check captcha
	MwfCaptcha::checkCaptcha($m, 'pstCpt')
		if $cfg->{captcha} >= 3 || $cfg->{captcha} >= 2 && !$m->{user}{id};

	# If there's no error, finish action
	if (!@{$m->{formErrors}}) {
		# Check for dupe
		!$m->fetchArray("
			SELECT 1 
			FROM posts 
			WHERE boardId = :boardId 
				AND userId = :userId
				AND parentId = 0
				AND postTime > :now - 1000
				AND body = :body
			LIMIT 1",
			{ boardId => $boardId, userId => $userId, now => $m->{now}, body => $post->{body} })
			or $m->error('errDupe');
		
		# Insert topic
		my $topicId = 0;
		my $postId = 0;
		$m->dbDo("
			INSERT INTO topics (subject, boardId, hitNum, postNum, lastPostTime) 
			VALUES (?, ?, ?, ?, ?)",
			$post->{subject}, $boardId, 1, 1, $m->{now});
		$topicId = $m->dbInsertId("topics");
		
		# Insert post
		$m->dbDo("
			INSERT INTO posts (
				userId, userNameBak, boardId, topicId, parentId, approved, ip, postTime, body, rawBody) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
			$postUserId, $postUserName, $boardId, $topicId, 0, $approved, $ip, $m->{now},
			$post->{body}, $post->{rawBody});
		$postId = $m->dbInsertId("posts");
	
		# Update topic's basePostId
		$m->dbDo("
			UPDATE topics SET basePostId = ? WHERE id = ?", $postId, $topicId);
		
		# Update board stats
		$m->dbDo("
			UPDATE boards SET postNum = postNum + 1, lastPostTime = ? WHERE id = ?", 
			$m->{now}, $boardId);
	
		# Update user stats
		$m->{userUpdates}{postNum} = $user->{postNum} + 1 if $userId;

		# Notify word watchers
		my %visibleCache = ();
		if ($cfg->{watchWords}) {
			my $bodyLc = lc($body);
			my $watchWords = $m->fetchAllArray("
				SELECT userId, word FROM watchWords WHERE userId <> ?", $userId);
			for my $watch (@$watchWords) {
				if (index($bodyLc, $watch->[1]) > -1
					&& ($visibleCache{$watch->[0]} || $m->boardVisible($board, $m->getUser($watch->[0])))) {
					$visibleCache{$watch->[0]} = 1;
					my $url = "topic_show$m->{ext}?pid=$postId";
					$m->addNote('watWrd', $watch->[0], 'notWatWrd', watWrd => $watch->[1], pstUrl => $url);
				}
			}
		}

		# Notify user watchers
		if ($cfg->{watchUsers}) {
			my $watchUsers = $m->fetchAllArray("
				SELECT userId FROM watchUsers WHERE watchedId = ?", $userId);
			for my $watch (@$watchUsers) {
				if ($visibleCache{$watch->[0]} || $m->boardVisible($board, $m->getUser($watch->[0]))) {
					$visibleCache{$watch->[0]} = 1;
					my $url = "topic_show$m->{ext}?pid=$postId";
					$m->addNote('watUsr', $watch->[0], 'notWatUsr', watUsr => $user->{userName}, 
						pstUrl => $url);
				}
			}
		}

		# Send instant subscriptions
		if ($cfg->{subsInstant}) {
			my $subscribers = $m->fetchArray("
				SELECT 1 FROM boardSubscriptions WHERE instant = 1 AND boardId = ? LIMIT 1", $boardId);
			$subscribers = $m->fetchArray("
				SELECT 1 FROM topicSubscriptions WHERE instant = 1 AND topicId = ? LIMIT 1", $topicId)
				if !$subscribers;
			$m->spawnScript('spawn_subscriptions', "-p", $postId) if $subscribers;
		}
		
		# Log action and finish
		$m->logAction(1, 'topic', 'add', $userId, $boardId, $topicId, $postId);
		$m->redirect('topic_show', tid => $topicId, msg => 'NewPost');
	}
}

# Print form
if (!$add || @{$m->{formErrors}}) {
	# Print header
	$m->printHeader(undef, { tagButtons => 1, lng_tbbInsSnip => $lng->{tbbInsSnip} });

	# Print page bar
	my @navLinks = ({ url => $m->url('board_show', bid => $boardId), txt => 'comUp', ico => 'up' });
	$m->printPageBar(mainTitle => $lng->{ntpTitle}, subTitle => $board->{title}, navLinks => \@navLinks);

	# Prepare preview body
	if ($preview) {
		$preview = { body => $body, rawBody => $rawBody };
		$m->editToDb($board, $preview);
		$m->dbToDisplay($board, $preview);
	}

	# Prepare misc values
	my $unregNameEsc = $m->escHtml($unregName) || $cfg->{anonName};
	my $subjectEsc = $m->escHtml($subject);
	my $bodyEsc = $m->escHtml($body, 1);
	my $rawBodyEsc = $m->escHtml($rawBody, 1);

	# Print hints and form errors
	$m->printFormErrors();
	
	# Print new topic form
	print
		"<form action='topic_add$m->{ext}' method='post'>\n",
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>$lng->{ntpTpcTtl}</span></div>\n",
		"<div class='ccl'>\n",
		"<fieldset>\n";

	# Print username input for guests
	print
		"<label class='lbw'>$lng->{ntpTpcName}\n",
		"<input type='text' name='name' size='40' maxlength='$cfg->{maxUserNameLen}'",
		" value='$unregNameEsc'/></label>\n"
		if $cfg->{allowUnregName} && $board->{unregistered} && !$userId;

	# Print subject input
	print
		"<label class='lbw'>$lng->{ntpTpcSbj}\n",
		"<input type='text' class='fcs' name='subject' size='80' maxlength='$cfg->{maxSubjectLen}'",
		" autofocus='autofocus' required='required' value='$subjectEsc'/></label>\n",
		"</fieldset>\n";

	# Print body textarea
	print
		"<fieldset>\n",
		$m->tagButtons($board),
		"<textarea class='tgi' name='body' rows='14' required='required'>$bodyEsc</textarea>\n",
		"</fieldset>\n";

	# Print raw body textarea
	print
		$rawBodyEsc ? "<fieldset>\n" : 
			"<div><a class='clk' id='rawlnk'>$lng->{eptEditIRaw} &#187;</a></div>" .
			"<fieldset id='rawfld' style='display: none'>\n",
		"<label class='lbw'>$lng->{eptEditRaw}\n",
		"<textarea class='raw' name='raw' rows='14' spellcheck='false'>$rawBodyEsc",
		"</textarea></label>\n",
		"</fieldset>\n"
		if $cfg->{rawBody};

	# Print captcha
	print MwfCaptcha::captchaInputs($m, 'pstCpt')
		if $cfg->{captcha} >= 3 || $cfg->{captcha} >= 2 && !$m->{user}{id};

	# Print rest of form
	print
		$m->submitButton('ntpTpcB', 'write', 'add'),
		$m->submitButton('ntpTpcPrvB', 'preview', 'preview'),
		"<input type='hidden' name='bid' value='$boardId'/>\n",
		$m->stdFormFields(),
		"</div>\n",
		"</div>\n",
		"</form>\n\n";

	# Print preview
	print
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>$lng->{ntpPrvTtl}</span></div>\n",
		"<div class='ccl'>\n",
		$preview->{body}, "\n",
		"</div>\n",
		"</div>\n\n"
		if $preview;
	
	# Log action and finish
	$m->logAction(3, 'topic', 'add', $userId, $boardId);
	$m->printFooter();
}
$m->finish();
