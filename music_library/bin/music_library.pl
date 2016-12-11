use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Local::MusicParser v0.0.1;
use Local::MusicArgs v0.0.1;
use Local::MusicLibrary v0.0.1;
use Getopt::Long;

my %args;
my @data;
my @template;

GetOptions (\%args,'band=s',
                   'year=s',
                   'album=s',
                   'track=s',
                   'sort=s',
                   'columns=s'
            );

while (<>) {music_parse (\@data, \$_);}

@data = music_args (\@data, \%args, \@template);

music_library (\@data, \@template);

#p @data;