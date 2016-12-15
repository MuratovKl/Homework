package Local::Source::Array;

use strict;
use warnings;
use parent 'Local::Source';

sub next {
    my $self = shift;
    return $self -> {array}[$self -> {iter}++];
}

1;