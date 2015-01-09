#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Web::Query;
use WWW::Mechanize;
use HTML::Entities;
use HTML::Filter::Callbacks;
use Encode;

my $url = 'http://yusuke.be/post/99629134344';

my $mech   = WWW::Mechanize->new;
my $filter = HTML::Filter::Callbacks->new;
$filter->handler(comment => []);
$filter->add_callbacks(
    br => {
        start => sub {
            my $tag = shift;
            $tag->remove_tag;
            $tag->text($tag->text =~ s/^\s+|\s+$//mgr);
            $tag->append("\n");
        },
    },
    p => {
        start => sub {
            my $tag = shift;
            $tag->append("\n");
        },
        end => sub {
            my $tag = shift;
            $tag->append("\n");
        },
    },
    a => {
        start => sub {
            my $tag = shift;
            $tag->remove_tag;
        },
        end => sub {
            my $tag = shift;
            $tag->remove_tag;
        },
    },
    li => {
        end => sub {
            my $tag = shift;
            $tag->append("\n");
        },
    },
    ul => {
        start => sub {
            my $tag = shift;
            $tag->append("\n");
        },
        end => sub {
            my $tag = shift;
            $tag->append("\n");
        },
    },
    blockquote => {
        start => sub {
            my $tag = shift;
            $tag->append("\n");
        },
        end => sub {
            my $tag = shift;
            $tag->append("\n");
        },
    },
    '*' => {
        start => sub {
            my $tag = shift;
            $tag->remove_tag;
        },
        end => sub {
            my $tag = shift;
            $tag->remove_tag;
        },
    },
);

my $res = $mech->get($url);
my $q = wq(decode_entities +$res->decoded_content)->find('div.body');

say "[title]\n", encode_utf8 +$q->find('h2')->text;
$q->find('h2')->remove;

say "[content]\n";
say encode_utf8 +$filter->process($q->html);
