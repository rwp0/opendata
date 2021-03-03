#! /usr/bin/env perl

use v5.30;

use HTTP::Tiny;
use Data::Dumper;

use URI;
use JSON;

my($http) = HTTP::Tiny -> new();
my($uri) = URI -> new("https://api.opendata.az/");
$uri -> path_segments((qw(v1 json nrytn ShortNumberInfo), $ARGV[0]));
# die $uri;
my($json) = JSON -> new();

my($get) = $http -> get($uri); # %
my($hashref) = $json -> decode($get -> {content});
say $hashref -> {Response} -> [0] -> {Name};
