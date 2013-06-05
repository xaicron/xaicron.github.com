#!/usr/bin/env perl

use strict;
use warnings;
use RedisDB;
use 5.12.1;
use Data::Dumper;

my $redis = RedisDB->new(host => 'localhost', port => 6379);
say $redis->set(foo => 'bar'); # 1
say $redis->get('foo');        # 'bar'

say '-'x80;

say $redis->send_command('SET', foo => 'hoge'); # 1
say $redis->send_command('GET', 'foo');        # 1

my @results = $redis->get_all_replies;
warn Dumper \@results; # [ 'OK', 'hoge' ]

