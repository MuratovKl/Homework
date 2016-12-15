package Local::Reducer::MaxDiff;

use strict;
use warnings;
use parent 'Local::Reducer';

sub makereduce { 
	my $self = shift;
	my $item = $self -> {source} -> next or return;
	my $row = $self -> {row_class} -> new(str => $item);
	my $top = $row -> get($self -> {top},"Don't have this!");
	my $bottom = $row -> get($self -> {bottom},"Don't have this!");	
	return if ($top or $bottom) eq "Don't have this!";
	my $differ = abs($bottom - $top);
	return $differ > $self -> reduced ? $self -> {reduced} = $differ : $self -> reduced;
}

1;
