package Local::Source::Text; {
	use strict;
	use warnings;
	use parent 'Local::Source::Array';
	
	sub new {
		my ($class, %params) = @_;
		my $delimiter = defined $params{delimiter} ? $params{delimiter} : "\n";
		return $class -> SUPER::new(array => [split $delimiter, $params{text}]);
	}
}

1;