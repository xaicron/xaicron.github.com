#!/usr/bin/env perl

use strict;
use warnings;
use RedisDB;
use 5.12.1;
use Data::Dumper;

my $score_key = 'score';

my $redis = RedisDB->new(host => 'localhost', port => 6379);

$redis->send_command('MULTI');
for my $data (@{ [
    { score => 100, user_id => 12345 },
    { score => 101, user_id => 12346 },
    { score => 102, user_id => 12347 },
    { score => 103, user_id => 12348 },
] }) {
    $redis->send_command('ZADD', $score_key, $data->{score}, $data->{user_id});
}
$redis->send_command('EXEC');

my @results = $redis->get_all_replies;
warn Dumper $results[-1];

# score が高い人が 1位の場合
my $start = 1;
my $end   = 100;
$redis->send_command('MULTI');
    $redis->send_command('ZCOUNT', $score_key, '-inf', '+inf');
    $redis->send_command('ZREVRANGE', $score_key, $start, $end, 'WITHSCORES');
$redis->send_command('EXEC');

@results = $redis->get_all_replies;
warn Dumper \@results;

my $total = $results[-1][0];
my $data  = $results[-1][1];

my $rs   = [];
my $rank = $start;
for (my $i = 0; $i < @$data; $i += 2) {
    push @$rs, {
        rank    => $rank++,
        user_id => $data->[$i],
        score   => $data->[$i+1],
    };
}

say Dumper [ $total, $rs ];
