package Local::Row::JSON;

use strict;
use warnings;
use JSON::XS;
use parent 'Local::Row';

	sub parse {
		my ($self, $str) = @_;
		return JSON::XS -> new -> utf8 -> decode($str);
	}

1;