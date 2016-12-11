package Local::MusicParser v0.0.1;
use base qw(Exporter);
our @EXPORT_OK = qw( music_parse );
our @EXPORT = qw( music_parse );
use strict;
use warnings;

my $i = 0;

sub music_parse {
    my ($data, $string) = @_;
    if ($$string =~ /\G^\.\/
        (?<band>[\w\s\'\"\(\)\-]+)\/
        (?<year>\d+)
        \s+\-\s+
        (?<album>[\w\s\'\"\(\)\-]+)
        \/(?<song>[\w\s\'\"\(\)\-]+)
        \.(?<format>\w+)
        /xgc) {
        $$data[$i++] = {"band" => $+{band},
                        "year" => $+{year},
                        "album" => $+{album},
                        "song" => $+{song},
                        "format" => $+{format}
        };
    }
    else {
        say "Wrong format! Skipped.";
    }
}
1;