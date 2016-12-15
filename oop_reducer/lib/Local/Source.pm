package Local::Source;

use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    $args{iter} = 0;
    return bless \%args, $class;
}

1;