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

# Check if user is admin
$user->{admin} or $m->error('errNoAccess');

# Get CGI parameters
my $userIp = lc($m->paramStr('userIp'));
my $userName = $m->paramStr('userName');
my $userAgent = $m->paramStr('userAgent');
my $postIp = lc($m->paramStr('postIp'));
my $postBody = $m->paramStr('postBody');
my $maxAge = $m->paramInt('maxAge') || 1;
my $deleteBranches = $m->paramBool('deleteBranches');
my $deleteTopics = $m->paramBool('deleteTopics');
my $action = $m->paramStrId('act');
my $delete = $m->paramBool('delete');
my $preview = $m->paramBool('preview');
my $submitted = $m->paramBool('subm');

# Preview data
my $users = [];
my $posts = [];

# Process form
if ($submitted) {
	# Check request source authentication
	$m->checkSourceAuth() or $m->formError('errSrcAuth');

	# Process delete users and their posts form
	if ($action eq 'users') {
		# Check criteria
		$userIp || $userName || $userAgent or $m->formError("All criteria are empty.");
		
		# If there's no error, finish action
		if (!@{$m->{formErrors}}) {
			# Search spammers
			my $userIpLike = $m->dbEscLike($userIp) . "%";
			my $userNameLike = "%" . $m->dbEscLike($userName) . "%";
			my $userAgentLike = "%" . $m->dbEscLike($userAgent) . "%";
			my $userIpStr = $userIp ? "lastIp LIKE :userIp" : "";
			my $userNameStr = $userName ? "userName LIKE :userName" : "";
			my $userAgentStr = $userAgent ? "userAgent LIKE :userAgent" : "";
			my $searchStr = join(" OR ", grep($_, $userIpStr, $userNameStr, $userAgentStr));
			$users = $m->fetchAllArray("
				SELECT id, userName 
				FROM users 
				WHERE regTime > :now - :maxAge * 86400
					AND ($searchStr)
				ORDER BY id",
				{ now => $m->{now}, maxAge => $maxAge, userIp => $userIpLike, 
					userName => $userNameLike, userAgent => $userAgentLike });
			my @userIds = map($_->[0], @$users);

			if (!$preview) {
				# Delete topics started by spammers
				if ($deleteTopics) {
					my $topics = $m->fetchAllArray("
						SELECT topics.id 
						FROM topics AS topics
							INNER JOIN posts AS posts
								ON posts.topicId = topics.id
						WHERE posts.userId IN (:userIds)",
						{ userIds => \@userIds });
					$m->deleteTopic($_->[0]) for @$topics;
				}

				# Delete posts
				my $posts = $m->fetchAllArray("
					SELECT id, topicId FROM posts WHERE userId IN (:userIds)",
					{ userIds => \@userIds });
				my @postIds = map($_->[0], @$posts);
				my $children = $m->fetchAllArray("
					SELECT parentId FROM posts WHERE parentId IN (:postIds)",
					{ postIds => \@postIds });
				my %children = ();
				$children{$_->[0]} = 1 for @$children;
				$m->deletePost($_->[0], 0, $children{$_->[0]}, 0) for @$posts;

				# Update all board and affected topic stats
				my $boards = $m->fetchAllArray("
					SELECT id FROM boards");
				$m->recalcStats($_->[0]) for @$boards;
				my %topics = ();
				$topics{$_->[1]} = 1 for @$posts;
				$m->recalcStats(undef, $_) for keys(%topics);
				
				# Delete users
				$m->deleteUser($_) for @userIds;
			}
	
			# Log action
			$m->logAction(1, 'forum', 'purge', $userId);
		}
	}
	# Process delete posts form
	elsif ($action eq 'posts') {
		# Check criteria
		$postIp || $postBody or $m->formError("All criteria are empty.");

		# If there's no error, finish action
		if (!@{$m->{formErrors}}) {
			# Search posts
			my $postIpEsc = $m->dbEscLike($postIp) . "%";
			my $postBodyEsc = "%" . $m->dbEscLike($postBody) . "%";
			my $postIpStr = $postIp ? "ip LIKE :postIp" : "";
			my $postBodyStr = $postBody ? "body LIKE :postBody" : "";
			my $searchStr = join(" OR ", grep($_, $postIpStr, $postBodyStr));
			$posts = $m->fetchAllArray("
				SELECT id, topicId 
				FROM posts 
				WHERE postTime > :now - :maxAge * 86400
					AND ($searchStr)
				ORDER BY id",
				{ now => $m->{now}, maxAge => $maxAge, postIp => $postIpEsc, 
					postBody => $postBodyEsc });
			my @postIds = map($_->[0], @$posts);

			if (!$preview) {
				# Delete topics started by spam posts
				if ($deleteTopics) {
					my $topics = $m->fetchAllArray("
						SELECT topics.id 
						FROM topics AS topics
							INNER JOIN posts AS posts
								ON posts.topicId = topics.id
						WHERE posts.id IN (:postIds)",
						{ postIds => \@postIds });
					$m->deleteTopic($_->[0]) for @$topics;
				}

				# Delete posts
				my $children = $m->fetchAllArray("
					SELECT parentId FROM posts WHERE parentId IN (:postIds)",
					{ postIds => \@postIds });
				my %children = ();
				$children{$_->[0]} = 1 for @$children;
				$m->deletePost($_->[0], 0, $children{$_->[0]}, 0) for @$posts;

				# Update all board and affected topic stats
				my $boards = $m->fetchAllArray("
					SELECT id FROM boards");
				$m->recalcStats($_->[0]) for @$boards;
				my %topics = ();
				$topics{$_->[1]} = 1 for @$posts;
				$m->recalcStats(undef, $_) for keys(%topics);
			}
	
			# Log action
			$m->logAction(1, 'forum', 'purge', $userId);
		}
	}
}

# Print header
$m->printHeader();

# Print page bar
my @navLinks = ({ url => $m->url('forum_show'), txt => 'comUp', ico => 'up' });
$m->printPageBar(mainTitle => "Forum Purge", navLinks => \@navLinks);

# Escape submitted values
my $userIpEsc = $m->escHtml($userIp);
my $userNameEsc = $m->escHtml($userName);
my $userAgentEsc = $m->escHtml($userAgent);
my $postIpEsc = $m->escHtml($postIp);
my $postBodyEsc = $m->escHtml($postBody);
my $deleteTopicsSel = $deleteTopics ? "checked='checked'" : "";

# Print hints and form errors
$m->printHints([
	"This feature is meant to be used for mass-deleting spam and troll accounts and posts.".
	" Since it's easy to accidentally delete too much, it should only be used by experienced admins".
	" who know what they're doing. Make a database backup and use the preview feature before".
	" deleting."]);
$m->printFormErrors();

# Print user/post purge form
print
	"<form class='prg' action='forum_purge$m->{ext}' method='post'>\n",
	"<div class='frm'>\n",
	"<div class='hcl'><span class='htt'>Purge Users and their Posts</span></div>\n",
	"<div class='ccl'>\n",
	"<p>Delete all user accounts matching any of the following criteria, as well as their posts:</p>",
	"<fieldset>\n",
	"<label class='lbw'>IP starting with\n",
	"<input class='fcs' type='text' name='userIp' size='20'",
	" autofocus='autofocus' value='$userIpEsc'/></label>\n",
	"<label class='lbw'>Username containing\n",
	"<input type='text' name='userName' size='20' value='$userNameEsc'/></label>\n",
	"<label class='lbw'>User agent containing\n",
	"<input type='text' name='userAgent' size='40' value='$userAgentEsc'/></label>\n",
	"<label class='lbw'>Registered during the last x days\n",
	"<input type='text' name='maxAge' size='4' value='$maxAge'/></label>\n",
	"</fieldset>\n",
	"<fieldset>\n",
	"<label><input type='checkbox' name='deleteTopics' $deleteTopicsSel/>",
	"Delete complete topics started by matching users</label>\n",
	"</fieldset>\n",
	$m->submitButton("Delete", 'delete', 'delete'),
	$m->submitButton("Preview", 'preview', 'preview'),
	"<input type='hidden' name='act' value='users'/>\n",
	$m->stdFormFields(),
	"</div>\n",
	"</div>\n",
	"</form>\n\n";
	
if ($submitted && $action eq 'users') {
	print
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>Affected Users</span></div>\n",
		"<div class='ccl'>\n",
		join(",\n", map("<a href='" . $m->url('user_info', uid => $_->[0]) . "'>$_->[1]</a>", 
			@$users)) || " - ", "\n",
		"</div>\n",
		"</div>\n\n";
}

# Print posts purge form
print
	"<form class='prg' action='forum_purge$m->{ext}' method='post'>\n",
	"<div class='frm'>\n",
	"<div class='hcl'><span class='htt'>Purge Posts</span></div>\n",
	"<div class='ccl'>\n",
	"<p>Delete all posts matching any of the following criteria:</p>",
	"<fieldset>\n",
	"<label class='lbw'>IP starting with\n",
	"<input type='text' name='postIp' size='20' value='$postIpEsc'/></label>\n",
	"<label class='lbw'>Post body containing\n",
	"<input type='text' name='postBody' size='40' value='$postBodyEsc'/></label>\n",
	"<label class='lbw'>Posted during the last x days\n",
	"<input type='text' name='maxAge' size='4' value='$maxAge'/></label>\n",
	"</fieldset>\n",
	"<fieldset>\n",
	"<label><input type='checkbox' name='deleteTopics' $deleteTopicsSel/>",
	"Delete complete topics started by matching posts</label>\n",
	"</fieldset>\n",
	$m->submitButton("Delete", 'delete', 'delete'),
	$m->submitButton("Preview", 'preview', 'preview'),
	"<input type='hidden' name='act' value='posts'/>\n",
	$m->stdFormFields(),
	"</div>\n",
	"</div>\n",
	"</form>\n\n";

if ($submitted && $action eq 'posts') {
	print
		"<div class='frm'>\n",
		"<div class='hcl'><span class='htt'>Affected Posts</span></div>\n",
		"<div class='ccl'>\n",
		join(",\n", map("<a href='" . $m->url('topic_show', pid => $_->[0]) . "'>$_->[0]</a>", 
			@$posts)) || " - ", "\n",
		"</div>\n",
		"</div>\n\n";
}

# Log action and finish
$m->logAction(3, 'forum', 'purge', $userId);
$m->printFooter();
$m->finish();
