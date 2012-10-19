#!/usr/bin/env perl

use strict;
use warnings;
use OreZen;
use OreZen::Util;
use OreZen::Flavor;
use Text::MicroTemplate qw(encoded_string);
use Text::MicroTemplate::File;
use Getopt::Compact::WithCmd;

my $go = Getopt::Compact::WithCmd->new(
    args          => 'orezen.txt',
    global_struct => {
        regen => {
            alias => [qw/r/],
            type  => '!',
            desc  => 'regenerate Flavors',
        },
        flavor => {
            alias => [qw/f/],
            type  => '=s',
            desc  => 'sets Flavor',
            opts  => { default => 'Default' },
        },
    }
);

my $opts = $go->opts;
my $file = shift || 'orezen.txt';

my $title;
my $data = do {
    open my $fh, '<', $file or die "$file: $!";
    $title = <$fh>;
    $title ||= '';
    chomp($title);
    local $/;
    <$fh>;
};
my $content = OreZen->format($data);

my $html = Text::MicroTemplate::File->new(
    include_path => 'tmpl',
)->render_file('index.mt', $title, encoded_string $content);

if ($opts->{regen}) {
    my $flavor = OreZen::Flavor->load($opts->{flavor});
    print "regen from $flavor\n";
    $flavor->gen();
}

OreZen::Util->write('index.html', $html);

print "done.\n";
