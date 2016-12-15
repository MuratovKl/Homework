package Local::Reducer::Sum;

use strict;
use warnings;
use parent 'Local::Reducer';

sub makereduce {
	my $self = shift;
	my $item = $self->{source}->next or return;
	my $row = $self->{row_class}->new(str => $item)->get($self->{field},"Don't have this!");
	return if $row eq "Don't have this!";		
	return $self->{reduced} += $row ;
	}


1;