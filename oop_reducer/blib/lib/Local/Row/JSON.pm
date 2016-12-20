package Local::Row::JSON;

use strict;
use warnings;
use JSON::XS;
use parent 'Local::Row';

my $json = JSON::XS -> new -> utf8;

sub parse {
	my ($self, $str) = @_;
	return $json -> decode($str);
}
	
1;