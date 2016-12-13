package Local::MusicParser v1.0.0;
use base qw(Exporter);
our @EXPORT_OK = qw( music_parse );
our @EXPORT = qw( music_parse );
use strict;
use warnings;
use feature 'say';

sub music_parse {
    my ($data, $string) = @_;
    if ($$string =~ /\G^\.\/
        (?<band>[\w\s\'\"\(\)\-]+)\/
        (?<year>\d+)
        \s+\-\s+
        (?<album>[\w\s\'\"\(\)\-]+)
        \/(?<track>[\w\s\'\"\(\)\-]+)
        \.(?<format>\w+)
        /xgc) {
        $$data[$#$data + 1] = {"band" => $+{band},
                               "year" => $+{year},
                               "album" => $+{album},
                               "track" => $+{track},
                               "format" => $+{format}};
    }
    else {
        say "Wrong format! Skipped.";
    }
}
1;