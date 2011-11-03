#!perl
use strict;
use warnings;
use utf8;

package MyApp::I18N;
use FindBin qw($Bin);
use parent 'Locale::Maketext';
use Locale::Maketext::Lexicon {
    '*' => [Gettext => "$Bin/locale/*.po"],
    _auto => 1,
    _decode => 1,
    _style => 'gettext',
};

package main;
use Encode ();
use Text::Xslate;

my $i18n = MyApp::I18N->get_handle('ja');
my $xslate = Text::Xslate->new(
    syntax   => 'TTerse',
    function => {
        l => sub {
            return $i18n->maketext(@_);
        },
    },
);

binmode STDOUT, ':utf8';
print $xslate->render_string(<<'TEMPLATE');
[% l('Hello!') %]
[% l('Hello! %1.', '太郎') %]
[% l('tokyo') %]
TEMPLATE

