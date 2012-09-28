#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.1;
use DBI;
use SQL::Format;
use DBIx::QueryLog;

DBIx::QueryLog->color('green');

my $insert_num = shift || 1;

my $connect_info = do 'eg/assets/connect_info.pl';

my ($stmt, @bind) = SQL::Format->new->insert_multi(
    'neko_queue',
    [qw/id user_id is_dis_like published_on/],
    [
        map {
            [$_, 1000 + $_, 1, \'UNIX_TIMESTAMP()'],
        } 1..$insert_num,
    ],
);

my $dbh = DBI->connect(@$connect_info);
$dbh->do($stmt, undef, @bind);
