package Local::Row;

use strict;
use warnings;
	
sub new {
    my ($class, %args) = @_;
    my $line = $class -> parse($args{str});
    return bless \$line, $class;
	}
	
sub get {
    my ($self, $name, $default) = @_;
    exists $$self -> {$name} ? return $$self -> {$name} : return $default;
}

1;
