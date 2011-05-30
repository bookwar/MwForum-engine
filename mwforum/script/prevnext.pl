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

# Get CGI parameters
my $srcBoardId = $m->paramInt('bid');
my $srcTopicId = $m->paramInt('tid');
my $direction = $m->paramStr('dir');
$direction or $m->error('errParamMiss');

if ($srcBoardId) {
	# Get source board
	my $board = $m->fetchHash("
		SELECT boards.*, categories.pos AS categPos
		FROM boards AS boards
			INNER JOIN categories AS categories
				ON categories.id = boards.categoryId
		WHERE boards.id = ?", $srcBoardId);
	$board or $m->error('errBrdNotFnd');

	# Query direction
	my $rel;
	my $order;
	if ($direction eq 'prev') {
		$rel = "<";
		$order = "DESC";
	}
	else {
		$rel = ">";
		$order = "ASC";
	}

	# Get destination board id
	my $dstBoardId = $m->fetchArray("
		SELECT boards.id 
		FROM boards AS boards
			INNER JOIN categories	AS categories
				ON categories.id = boards.categoryId
			LEFT JOIN boardHiddenFlags AS boardHiddenFlags
				ON boardHiddenFlags.userId = :userId
				AND boardHiddenFlags.boardId = boards.id
		WHERE (categories.pos $rel :categPos
				OR (categories.pos = :categPos
					AND boards.pos $rel :pos))
			AND boardHiddenFlags.boardId IS NULL
			AND boards.private = 0
		ORDER BY categories.pos $order, boards.pos $order
		LIMIT 1",
		{ userId => $userId, categPos => $board->{categPos}, pos => $board->{pos} });

	# If at end of board list, wrap around	
	if (!$dstBoardId) {
		$dstBoardId = $m->fetchArray("
			SELECT boards.id 
			FROM boards AS boards
				INNER JOIN categories	AS categories
					ON categories.id = boards.categoryId
				LEFT JOIN boardHiddenFlags AS boardHiddenFlags
					ON boardHiddenFlags.userId = :userId
					AND boardHiddenFlags.boardId = boards.id
			WHERE boardHiddenFlags.boardId IS NULL
				AND boards.private = 0
			ORDER BY categories.pos $order, boards.pos $order
			LIMIT 1",
			{ userId => $userId });
	}

	# Redirect to board
	$m->redirect('board_show', bid => $dstBoardId);
}
elsif ($srcTopicId) {
	# Get source topic
	my $topic = $m->fetchHash("
		SELECT boardId, lastPostTime FROM topics WHERE id = ?", $srcTopicId);
	$topic or $m->error('errTpcNotFnd');

	# Query direction
	my $rel;
	my $order;
	if ($direction eq 'prev') {
		$rel = ">";
		$order = "ASC";
	}
	else {
		$rel = "<";
		$order = "DESC";
	}

	# Get destination topic id
	my $dstTopicId = $m->fetchArray("
		SELECT id 
		FROM topics 
		WHERE boardId = :boardId
			AND lastPostTime $rel :lastPostTime
		ORDER BY lastPostTime $order
		LIMIT 1",
		{ boardId => $topic->{boardId}, lastPostTime => $topic->{lastPostTime} });

	if ($dstTopicId) {
		# Redirect to topic
		$m->redirect('topic_show', tid => $dstTopicId);
	}
	else {
		# Redirect to board
		$m->redirect('board_show', tid => $srcTopicId, msg => 'EolTpc');
	}
}

# Redirect to forum page in case of missing params
$m->redirect('forum_show');
