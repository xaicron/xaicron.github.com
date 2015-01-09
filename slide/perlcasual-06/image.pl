#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Imager;
use Image::Info qw(image_type); # 画像の種類を取得する奴
use LWP::Simple;

my $data = get('https://secure.gravatar.com/avatar/e766b4961b8ebdd7ef86244e74cead9e?s=130&d=http%3A%2F%2Fwww.gravatar.com%2Favatar%2F70f90c6a0bcd84348b02309babc98684%3Fs%3D130%26d%3Didenticon');

# callback を使えばファイルからでなくても読み込み可能
my $img = Imager->new(callback => sub {
    my $length = shift;
    substr($data, 0, $length);
});

my $file_type = lc(image_type(\$data)->{file_type} || '');
my $height    = $img->getheight;
my $width     = $img->getwidth;
my $bits      = $img->bits;
my $colors    = $img->getcolorcount;
my $channels  = $img->getchannels;
my $file_size = length $data;

say "file_type: $file_type";
say "height   : $height";
say "width    : $width";
say "bits     : $bits";
say "colors   : $colors";
say "channels : $channels";
say "file_size: $file_size";
