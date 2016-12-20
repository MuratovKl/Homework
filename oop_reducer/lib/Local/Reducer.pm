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
    for (my $i = 0; $i < $n; $i++) {
        my $item = $self -> {source}->next or return $self -> reduced;
        my $row = $self -> {row_class} -> new(str => $item);
        $self -> makereduce($row)
    }
    return $self -> reduced;
}

sub reduced {
    my $self = shift;
    return $self -> {reduced};
}

sub reduce_all {
    my $self = shift;
    while (1) {
        my $item = $self -> {source}->next or return $self -> reduced;
        my $row = $self -> {row_class} -> new(str => $item);
        $self -> makereduce($row);
    }
}

1;
