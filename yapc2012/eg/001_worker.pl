#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.1;
use DBI;
use Parallel::Prefork;
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
        my $q4m = DBI->connect(@$connect_info);
        my $index = $q4m->selectrow_array(
            'SELECT queue_wait(?)',
            undef,
            $queue_table,
        );
        return unless $index; # queue not found

        my $queue = $q4m->selectrow_hashref(
            'SELECT * FROM ' . $queue_table,
        );

        # do something
        warn Dumper [ $$, $queue ];

        $q4m->do('SELECT queue_end()');
    });
}

$pm->wait_all_children;
