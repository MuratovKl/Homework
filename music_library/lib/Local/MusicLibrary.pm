package Local::MusicLibrary v0.0.1;
use base qw(Exporter);
our @EXPORT_OK = qw( music_library );
our @EXPORT = qw( music_library );
use strict;
use warnings;

my $i = 0;

sub music_library {
    my ($data, $template) = @_;
    my %maxlen;
    my $maxstring = 1;
    if (!@$data) {return;};
    if (~~@$template == 0) {return '';};
    foreach (@$data) {
        foreach my $key (keys %$_) {
            my $itemlen = length ($$_{$key}) + 2;
            if (!exists $maxlen{$key}) {$maxlen{$key} = 0;};
            if ($itemlen > $maxlen{$key}) {$maxlen{$key} = $itemlen;};
        }
    }
    
    foreach my $item (@$template) {
        $maxstring += $maxlen{$item} + 1;
    }
    
    printf ("/%s\\\n",'-' x ($maxstring - 2));
    foreach (@$data) {
        print '|';
        foreach my $item (@$template) {
            printf (" %s%s |",' ' x ($maxlen{$item} - (length ($$_{$item}) + 2)),$$_{$item});
        }
        print "\n";
        if (++$i != ~~@$data) {
            my $j = 0;
            print '|';
            foreach my $item (@$template) {
                print '-' x $maxlen{$item};
                ++$j == ~~@$template ? print "|\n" : print '+';
            }
            
        }
       
       
    }
    printf ("\\%s/\n",'-' x ($maxstring - 2)); 
}
1;
