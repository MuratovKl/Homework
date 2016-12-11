package Local::Row::Simple; {
	use strict;
	use warnings;
	use parent 'Local::Row';
	
	sub parse {
		my ($self, $str) = @_; 
		my %struct;
		for (split /,/, $str) {
			if (/^\s*(\w+)\s*:\s*(.*)\s*$/) {
				$struct{$1} = $2;
			} else {
				die "Invalid string format!";
			}
		}
		return {%struct};
	}
}

1;