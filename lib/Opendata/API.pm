package Opendata::API; # package: Opendata::API, module: API.pm, file: Opendata/API.pm
use v5.30;
use HTTP::Tiny;
use Data::Dumper;
# use Encode ();
use URI; # cpan: URI (distribution)
use JSON; # cpan: JSON (distribution)
# use utf8;
use experimental qw(signatures);

my $uri = URI -> new('https://api.opendata.az');
my $http = HTTP::Tiny -> new();
my $json = JSON -> new();

sub new($class)
{
  return bless({}, $class);
}

sub meaning_of_name($object, $name) { # path: home meaningofname
  use constant PATH => qw(v1 json home MeaningOfName);
	# $uri -> path_segments(PATH, Encode::decode('utf8', $name));
	$uri -> path_segments(PATH, $name);
  my $get = $http -> get($uri); # %
	my $content = $json -> decode($get -> {content});
  return $content -> {Response} -> {Meaning}; # eq. ${%$content{Response}}{Meaning};
}

sub short_number_info($object, $number) { # path: nrytn shortnumberinfo
  use constant PATH => qw(v1 json nrytn ShortNumberInfo);
  # $uri -> path_segments((qw(v1 json nrytn ShortNumberInfo), Encode::decode('utf8', $number)));
  $uri -> path_segments((PATH, $number));
  my $get = $http -> get($uri); # %
  my $content = $json -> decode($get -> {content});
  return $content -> {Response} -> [0] -> {Name};
}

1;

=pod

tested under xterm with LC_ALL=UTF-8 environment variable set

=cut
