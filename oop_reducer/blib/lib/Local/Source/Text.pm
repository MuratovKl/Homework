package Local::Source::Text;

use strict;
use warnings;
use parent 'Local::Source::Array';

sub new {
    my ($class, %args) = @_;
    my $delim = defined $args{delimiter} ? $args{delimiter} : "\n"; 
    return $class -> SUPER::new(array => [split $delim, $args{text}]);
}

1;