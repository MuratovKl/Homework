package Local::Reducer::Sum;

use strict;
use warnings;
use parent 'Local::Reducer';

sub makereduce {
	my ($self, $row) = @_;
	$row = $row -> get($self -> {field});
	return if !defined $row;
	return $self -> {reduced} += $row ;
	}

1;