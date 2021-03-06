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
use Getopt::Std ();
use MwfMain;

#------------------------------------------------------------------------------

# Get arguments
my %opts = ();
Getopt::Std::getopts('f:', \%opts);
my $forumId = $opts{f};

# Init
my ($m, $cfg, $lng) = MwfMain->newShell(forumId => $forumId);
exit if !$cfg->{subsDigest};
$m->dbBegin();

# Get last sent time	
my $lastSentTime = $m->max($m->getVar('crnSubLst') || 0, $m->{now} - 86400 * 5);

# Get boards
my $boards = $m->fetchAllHash("
	SELECT * FROM boards WHERE lastPostTime > ?", $lastSentTime);

# Board subscriptions
for my $board (@$boards) {
	# Get posts
	my $posts = $m->fetchAllHash("
		SELECT posts.postTime, posts.body, posts.rawBody, posts.userNameBak, 
			topics.subject
		FROM posts AS posts
			INNER JOIN topics AS topics
				ON topics.id = posts.topicId
		WHERE posts.postTime > :lastSentTime
			AND posts.boardId = :boardId
			AND posts.approved = 1
		ORDER BY posts.topicId, posts.postTime",
		{ lastSentTime => $lastSentTime, boardId => $board->{id} });
	next if !@$posts;

	# Concatenate all posts
	my $subject = "$cfg->{forumName} - \"$board->{title}\" $lng->{subSubjBrdDg}";
	my $body = $lng->{subNoReply} . "\n\n" . "-" x 70 . "\n\n";
	for my $post (@$posts) {
		$m->dbToEmail($board, $post);
		my $timeStr = $m->formatTime($post->{postTime});
		$body = $body
			. $lng->{subTopic} . $post->{subject} . "\n"
			. $lng->{subBy} . $post->{userNameBak} . "\n"
			. $lng->{subOn} . $timeStr . "\n\n"
			. $post->{body} . "\n\n" 
			. ($post->{rawBody} ? $post->{rawBody} . "\n\n" : "")
			. "-" x 70 . "\n\n";
	}

	# Get subscribers
	my $subscribers = $m->fetchAllHash("
		SELECT users.*
		FROM boardSubscriptions AS boardSubscriptions
			INNER JOIN users AS users
				ON users.id = boardSubscriptions.userId
		WHERE boardSubscriptions.boardId = :boardId
			AND boardSubscriptions.instant = 0
			AND users.email <> ''
			AND users.dontEmail = 0",
		{ boardId => $board->{id} });
	next if !@$subscribers;

	# Send to subscribers if they still have board access
	for my $subscriber (@$subscribers) { 
		next if !$m->boardVisible($board, $subscriber);
		$m->sendEmail(user => $subscriber, subject => $subject, body => $body);
	}
}

# Topic subscriptions
for my $board (@$boards) {
	# Get topics
	my $topics = $m->fetchAllHash("
		SELECT id, subject FROM topics WHERE lastPostTime > ? AND boardId = ?",
		$lastSentTime, $board->{id});
	
	# For each topic
	for my $topic (@$topics) {
		# Get posts
		my $posts = $m->fetchAllHash("
			SELECT posts.postTime, posts.body, posts.rawBody, posts.userNameBak
			FROM posts AS posts
			WHERE posts.postTime > :lastSentTime
				AND posts.topicId = :topicId
				AND posts.approved = 1
			ORDER BY posts.postTime",
			{ lastSentTime => $lastSentTime, topicId => $topic->{id} });
		next if !@$posts;
	
		# Concatenate all posts
		my $subject = "$cfg->{forumName} - \"$topic->{subject}\" $lng->{subSubjTpcDg}";
		my $body = $subject . "\n\n"
			. $lng->{subNoReply} . "\n\n" 
			. "-" x 70 . "\n\n";
		for my $post (@$posts) {
			$m->dbToEmail($board, $post);
			my $timeStr = $m->formatTime($post->{postTime});
			$body = $body
				. $lng->{subBy} . $post->{userNameBak} . "\n"
				. $lng->{subOn} . $timeStr . "\n\n"
				. $post->{body} . "\n\n" 
				. ($post->{rawBody} ? $post->{rawBody} . "\n\n" : "")
				. "-" x 70 . "\n\n";
		}
	
		# Get recipients
		my $subscribers = $m->fetchAllHash("
			SELECT users.*
			FROM topicSubscriptions AS topicSubscriptions
				INNER JOIN users AS users
					ON users.id = topicSubscriptions.userId
			WHERE topicSubscriptions.topicId = :topicId
				AND topicSubscriptions.instant = 0
				AND users.email <> ''
				AND users.dontEmail = 0",
			{ topicId => $topic->{id} });
		next if !@$subscribers;
	
		# Send to subscribers if they still have board access	
		for my $subscriber (@$subscribers) { 
			next if !$m->boardVisible($board, $subscriber);
			$m->sendEmail(user => $subscriber, subject => $subject, body => $body);
		}
	}
}

# Set last sent time
$m->setVar('crnSubLst', $m->{now}, 0);

# Log action and commit
$m->logAction(1, 'cron', 'subscr');
$m->dbCommit();
