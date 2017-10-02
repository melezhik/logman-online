use File::Basename;
use File::Copy;
use strict;

my $example = story_var("example");
my $url = story_var("url");
my $fbname = basename($url);
my $word = config()->{word};

s/\W/ /g for $example;

my $in = "/home/$ENV{USER}/longman-online/$word/mp3/$fbname";
my $out = "/home/$ENV{USER}/longman-online/.ready/$word/$example.mp3";

copy ($in, $out) or die "can't copy file $in -> $out : $!";
