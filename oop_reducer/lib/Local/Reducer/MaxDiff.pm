package Local::Reducer::MaxDiff;

use strict;
use warnings;
use parent 'Local::Reducer';

sub makereduce {
	my ($self, $row) = @_;
	my $top = $row -> get($self -> {top});
	my $bottom = $row -> get($self -> {bottom});	
	return if !defined $top or !defined $bottom;
	my $differ = abs($bottom - $top);
	return $differ > $self -> reduced ? $self -> {reduced} = $differ : $self -> reduced;
}

1;
