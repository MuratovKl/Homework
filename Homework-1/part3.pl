use strict;
use warnings;
use Data::Dumper;

my @structure;
my $i=0;
open(my $myfile, "<", "out.txt" )
or die "Can't open file! $!";
while(<$myfile>){
my @unit= ();
chomp;
@unit= split(/;/,$_);
@structure[$i++]= \@unit;
}
print Dumper(@structure);
