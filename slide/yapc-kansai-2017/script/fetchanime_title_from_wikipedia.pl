use strict;
use warnings;
use utf8;
use feature 'say';
use Encode;
use Furl;
use Web::Query qw(wq);

my $urls = [
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%82%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%8B%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%95%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%9F%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%AA%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%AF%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%81%BE%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%82%84%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%82%89%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%82%8F%E3%83%BB%E3%82%92%E3%83%BB%E3%82%93%E8%A1%8C',
    'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1%E4%BD%9C%E5%93%81%E4%B8%80%E8%A6%A7_%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%99%E3%83%83%E3%83%88',
];

for my $url (@$urls) {
    my $q = wq($url);
    my $list = $q->find('#mw-content-text > ul li');
    $list->find('i')->remove;
    $list->each(sub {
        say encode_utf8 +$_->text;
    });
}
