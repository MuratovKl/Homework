package Local::MusicLibrary v1.0.0;
use base qw(Exporter);
our @EXPORT_OK = qw( music_library );
our @EXPORT = qw( music_library );
use strict;
use warnings;
use feature 'say';

sub music_library {
    my ($data, $template) = @_;
    my %maxlen;
    my @out;
    my $maxstring = 1;
    my $sep = '|';
    my $i = 1;
    if (!@$data) {return;};
    if (@$template == 0) {return '';};
    
    foreach (@$data) {
        foreach my $key (keys %$_) {
            my $itemlen = length ($$_{$key}) + 2;
            if (!exists $maxlen{$key}) {$maxlen{$key} = 0;};
            if ($itemlen > $maxlen{$key}) {$maxlen{$key} = $itemlen;};
        }
    }
    
    foreach my $item (@$template) {
        $maxstring += $maxlen{$item} + 1;
        $sep = $sep . '-' x $maxlen{$item};
        if ($i++ == @$template) {$sep = $sep . '|';}
        else{$sep = $sep . '+';};
    }
    
    printf ("/%s\\\n",'-' x ($maxstring - 2));
    foreach my $song (@$data) {
        my $line = '|' . join '|', map {sprintf ("%*s ",$maxlen{$_} - 1,$$song{$_});} @$template;
        $out[$#out + 1] = $line . '|';
    }
    say join "\n$sep\n", @out;
    printf ("\\%s/\n",'-' x ($maxstring - 2)); 
}
1;
