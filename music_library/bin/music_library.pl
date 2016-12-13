use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Local::MusicParser v1.0.0;
use Local::MusicArgs v1.0.0;
use Local::MusicLibrary v1.0.0;
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