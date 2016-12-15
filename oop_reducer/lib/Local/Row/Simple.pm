package Local::Row::Simple;

use strict;
use warnings;
use parent 'Local::Row';

sub parse {
	my ($self, $str) = @_; 
	my %string;
	for (split /,/, $str) {
        	/^\s*(\w+)\s*:\s*(.*)\s*$/ ? $string{$1} = $2 : die "Invalid string format!";
	}
	return \%string;
}

1;
