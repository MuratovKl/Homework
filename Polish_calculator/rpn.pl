=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, содержащий обратную польскую нотацию
Один элемент массива - это число или арифметическая операция
В случае ошибки функция должна вызывать die с сообщением об ошибке

=cut

use 5.010;
use strict;
use warnings;
use diagnostics;
my %ops=(
    '(' => 0,
    ')' => 0,
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2,
    '^' => 3,
    'U-' => 4,
    'U+' => 4,
);
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';
use FindBin;
require "$FindBin::Bin/../lib/tokenize.pl";

sub rpn {
	my $expr = shift;
	my $source = tokenize($expr);
	my @rpn;
	my @stack;
	my $brcount=0;
	
push @$source,'|';

sub compare{
    my $cur=shift;
    my $prev=shift;
    if($ops{$cur} == $ops{$prev}){return 0;}
    if($ops{$cur} < $ops{$prev}){return -1;}
    if($ops{$cur} > $ops{$prev}){return 1;}
    return 1;
}

for my $c (@$source) {
next if $c =~ /^\s*$/;
given ($c) {
    when (/\d/) {push @rpn,$c;}
    
    when (/\(/){push @stack,$c;$brcount++;}
    
    when (/\)/){
        $brcount--;
        while($stack[$#stack] ne '('){push @rpn,pop @stack;}
        pop @stack;
        }
    
    when(/\^|U[-+]/){push @stack,$c;}
    
    when (/[-+*\/]/){
        if(scalar @stack==0 || compare($c,$stack[$#stack])==1){push @stack,$c;}
        else{
        while(scalar @stack!=0 and compare($c,$stack[$#stack])!=1){push @rpn,pop @stack;}
        push @stack,$c;
        }
    }

    when (/\|/ and $brcount==0){
		while(@stack){push @rpn,pop @stack;}
	}
    
default {
    die "Bad expression!";
}
}
}
	return \@rpn;
}

1;
