#! /usr/bin/env perl

use v5.30;
# use utf8;

use HTTP::Tiny;
use Data::Dumper;
use Encode ();
use Getopt::Std 'getopts';

use URI;
use JSON;
use Tk;

use constant path => qw(v1 json home MeaningOfName);

getopts('g', \ our %options);

my $uri = URI -> new('https://api.opendata.az');
my $http = HTTP::Tiny -> new();
my $json = JSON -> new();

if (defined($options{g})) # tk
{
	my $mainwindow = MainWindow -> new(-title => 'meaning of name', -background => 'black');
	# $mainwindow -> geometry('400x150');
	my $font = $mainwindow -> fontCreate('code', -family => 'helvetica', -size => 12);

	my $text = $mainwindow -> Text( -width => 20, -height => 1, -background => 'black', -foreground => 'grey', -selectbackground => 'black', -selectforeground => 'green' );
	# $text -> bind( '<Return>', sub { output($text -> get('1.0', 'end-1c')); } ); # FIXME: doesn't trigger event
	$text -> pack();

	my $message = $mainwindow -> Message(-font => 'code', -background => 'black', -foreground => 'white');
	$message -> pack();

	my $button = $mainwindow -> Button( -text => 'query', -background => 'black', -foreground => 'cyan', -activebackground => 'black', -activeforeground => 'green', -command =># \&output
    # [ \&output, $text -> get('1.0', 'end-1c') ] # BUG: doesn't pass argument
    sub { output($text -> get('1.0', 'end-1c')); }
		);
	$button -> pack();

  if (defined $ARGV[0]) {
		output($ARGV[0]);
	}

MainLoop();

	sub output {
		$uri -> path_segments(path, $_[0]);
		# $uri -> path_segments(path, $text -> get('1.0', 'end-1c'));
		my $get = $http -> get($uri); # return value: hashref
		my $hashref = $json -> decode($get -> {content});
		$mainwindow -> title(sprintf("%s (%s)", $hashref -> {Response} {Name}, $hashref -> {Response} {Gender}));
		$message -> configure(-text => Encode::decode('utf8', $hashref -> {Response} {Meaning}));
}

}
else # output to terminal
{
	$uri -> path_segments(path, Encode::decode('utf8', $ARGV[0]));
	my $get = $http -> get($uri); # %
	my $hashref = $json -> decode($get -> {content});
  say $hashref -> {Response} {Meaning}; # eq. ${%$hashref{Response}}{Meaning};
}

