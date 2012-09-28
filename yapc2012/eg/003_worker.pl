#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.1;
use DBI;
use Parallel::Prefork;
use POSIX qw(:signal_h);                                                           
use Sys::SigAction qw(set_sig_handler);                                            
use Data::Dumper;

my $queue_table  = 'neko_queue';
my $connect_info = do 'eg/assets/connect_info.pl';

say "parent pid: $$";

my $pm = Parallel::Prefork->new({
    max_workers  => 10,
    trap_signals => {
        TERM => 'TERM',
        HUP  => 'TERM',
    },
});

while ($pm->signal_received ne 'TERM') {
    $pm->start(sub {
        my $signal_received = 0;

        # Sys::SigAction を使う
        my $h = set_sig_handler(
            'TERM',
            sub {
                say "$$: received";
                $signal_received = 1;
            },
            { flags => SA_RESTART },
        );

        my $q4m = DBI->connect(@$connect_info);
        my $index = $q4m->selectrow_array(
            'SELECT queue_wait(?)',
            undef,
            $queue_table,
        );
        return unless $index; # queue not found

        # シグナルを受け取っていたら終了する
        return if $signal_received;

        my $queue = $q4m->selectrow_hashref(
            'SELECT * FROM ' . $queue_table,
        );

        # do something
        warn Dumper [ $$, $queue ];

        $q4m->do('SELECT queue_end()');
    });
}

$pm->wait_all_children;
