#! /usr/bin/perl
use v5.30;
use lib "$ENV{HOME}/lib/perl"; # unshift @INC
use Opendata::API;

my $opendata = Opendata::API -> new();

say $opendata -> meaning_of_name('yusif'); # url: https://en.wikipedia.org/wiki/Azerbaijani_name#Given_names
say $opendata -> short_number_info('108'); # url: https://asan.gov.az/en/call-center
