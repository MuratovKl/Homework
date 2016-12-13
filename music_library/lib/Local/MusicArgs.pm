package Local::MusicArgs v1.0.0;
use base qw(Exporter);
our @EXPORT_OK = qw( music_args );
our @EXPORT = qw( music_args );
use strict;
use warnings;
use Scalar::Util qw( looks_like_number );

sub music_args {
    my ($data, $args, $template) = @_;
    if (!$args) {return;};
    my $sortarg =  delete $$args{'sort'};
    
    if (defined $$args{'columns'}) {@$template = split /,/, delete $$args{'columns'};}
    else {@$template = qw(band year album track format)}
    my @new = grep {
        my $flag = 1;
        foreach my $key (keys %$args) {
            if (looks_like_number ($$args{$key})) {$flag = 0 if $_ -> {$key} != $$args{$key};}
            else {$flag = 0 if $_ -> {$key} ne $$args{$key};}
        }
        $flag;
    } @$data;

    if (defined $sortarg) {
        if (looks_like_number ($new[0] -> {$sortarg})) {@new = sort {$a -> {$sortarg} <=> $b -> {$sortarg}} @new;}
        else {@new = sort {$a -> {$sortarg} cmp $b -> {$sortarg}} @new;};      
    }
   return @new;
}
1;