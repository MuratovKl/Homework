package Local::Row;

	use strict;
	use warnings;
	
	sub new {
		my ($class, %args) = @_;
		my %struct = (struct => $class -> parse($args{str}));
		my $obj = bless \%struct, $class;
		return $obj;
	}
	
	sub get {
		my ($self, $name, $default) = @_;
    	exists $self -> {struct} -> {$name} ? return $self -> {struct} -> {$name} : return $default;
	}

1;