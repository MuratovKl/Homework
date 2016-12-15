package Local::Reducer;

use strict;
use warnings;
use utf8;
our $VERSION = '1.0.0';

sub new {
    my ($class, %args) = @_;
    $args{reduced} = $args{initial_value};
    return bless \%args, $class;
}

sub reduce_n {
		my ($self, $n) = @_;
		#$self -> {reduced} = $self -> {initial_value};
		for (my $i = 0; $i < $n && defined $self -> makereduce; $i++) {};
		return $self->reduced;
	}

sub reduced {
    my $self = shift;
    return $self -> {reduced};
}

sub reduce_all {
    my $self = shift;
   # $self -> {reduced} = $self -> {initial_value};
	#$self -> {source} -> {iter} = 0;
	while (defined $self -> makereduce) {};
	return $self -> reduced();
}

1;
