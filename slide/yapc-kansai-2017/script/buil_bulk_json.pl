use strict;
use warnings;
use utf8;
use feature 'say';
use autodie;
use JSON;
use File::Slurp qw(read_file);

my $json = JSON->new->utf8->canonical;

my $file = shift;
my $list = [ read_file $file, binmode => ':utf8', chomp => 1 ];

my $i = 1;
for my $row (@$list) {
    $row =~ s/ - $//;
    $row =~ s/\s+$//;
    say $json->encode({ index => {} });
    say $json->encode({ id => $i++, title => $row });
}
