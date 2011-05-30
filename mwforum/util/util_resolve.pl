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

# This script resolves user IP addresses to hostnames.
# See below or execute script with -h parameter for usage instructions.

use strict;
use warnings;
no warnings qw(uninitialized);

# Imports
use Getopt::Std ();
use Time::HiRes ();
use POSIX ();
use Socket;
require MwfMain;

# Get arguments
my %opts = ();
Getopt::Std::getopts('?hxrf:t:c:d:s:', \%opts);
my $help = $opts{'?'} || $opts{h};
my $reresolve = $opts{r};
my $forumId = $opts{f};
my $timeout = $opts{t} || 1;
my $column = $opts{c} || 'extra3';
my $dnsbl = $opts{d} || undef;
my $sleep = $opts{s} || 0;
usage() if $help;

# Init
my ($m, $cfg, $lng) = MwfMain->newShell(forumId => $forumId);
$cfg->{recordIp} or die "Not recording IPs.";

# Shortcuts
my $dbh = $m->{dbh};

# Autoflush
$| = 1;

# Get users
my $where = $reresolve ? "" : "WHERE $column = ''";
my $selSth = $m->fetchSth("
	SELECT id, lastIp FROM users $where ORDER BY id");
my ($id, $ip);
$selSth->bind_columns(\($id, $ip));
my $updSth = $m->dbPrepare("
	UPDATE users SET $column = ? WHERE id = ?");

# Resolve IPs
while ($selSth->fetch) {
	print "\nResolving $ip -> ";
	my $host = undef;
	my $dnsblIp = undef;
	my $revIp = join('.', reverse(split('\.', $ip)));
	my $time = [Time::HiRes::gettimeofday()];

	POSIX::sigaction(POSIX::SIGALRM(), POSIX::SigAction->new(sub { die "alarm\n" }))
		or die "No POSIX sigaction, exiting\n";

	eval {
		alarm $timeout;
		$host = gethostbyaddr(inet_aton($ip), 2) || "";
		$dnsblIp = gethostbyname("$revIp.$dnsbl.") if $dnsbl;
		alarm 0;
	};

	$time = Time::HiRes::tv_interval($time);

	# Print and store result
	if ($@) {
		die "Unexpected exception" if $@ ne "alarm\n";
		print "timeout (${time}s)";
	}
	elsif ($host) {
		$host .=  " (dnsbl: " . inet_ntoa($dnsblIp) . ")" if $dnsblIp;
		$m->dbExecute($updSth, $host, $id);
		print "$host (${time}s)";
	}
	else {
		$m->dbExecute($updSth, "nxdomain", $id);
		print "nxdomain (${time}s)";
	}
	sleep $sleep if $sleep;
}
print "\n\n";

#------------------------------------------------------------------------------

sub usage
{
	print
		"\nResolve user IP addresses to hostnames.\n\n",
		"Usage: util_resolve.pl [-r] [-f forum] [-t timeout] [-c column] [-d dnsbl]\n",
		"  -r   Resolve IPs that have been resolved before.\n",
		"  -f   Forum hostname or URL path when using a multi-forum installation.\n",
		"  -t   DNS resolver timeout in seconds, default is 1.\n",
		"  -c   User table column where to store result, default is 'extra3'.\n",
		"  -d   Check IP against specified DNSBL, e.g. 'bl.example.org'.\n",
		"  -s   Seconds to sleep after every user, to lessen strain on DNS(BL).\n",
	;
	
	exit 1;
}
