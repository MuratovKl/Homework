package Local::Source::Array; {
	use strict;
	use warnings;
	use parent 'Local::Source';
	
	sub next {
		my ($self) = @_;
		return $self -> {array}[$self -> next_iter()];
	}
}

1;