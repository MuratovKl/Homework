package Local::Reducer; {
use strict;
use utf8;
use warnings;
our $VERSION = '1.00';

	sub new {
		my ($class, %params) = @_;
		$params{reduced} = $params{initial_value};
		return bless \%params, $class;
	}

	sub reduced {
		my $self = shift;
		return $self -> {reduced};
	}
	
	sub reduce {}

	sub reduce_all {
		my $self = shift;
		$self -> {reduced} = $self -> {initial_value};
		$self -> {source}->start_again;
		while (defined $self -> reduce()) {}
		return $self -> reduced();
	}
	
	sub reduce_n {
		my ($self, $n) = @_;
		$self -> {reduced} = $self -> {initial_value};
		for (my $i = 0; $i < $n && defined $self -> reduce(); $i++) {}
		return $self->reduced();
	}
}

1;