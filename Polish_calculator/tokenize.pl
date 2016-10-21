=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, состоящий из отдельных токенов.
Токен - это отдельная логическая часть выражения: число, скобка или арифметическая операция
В случае ошибки в выражении функция должна вызывать die с сообщением об ошибке

Знаки '-' и '+' в первой позиции, или после другой арифметической операции стоит воспринимать
как унарные и можно записывать как "U-" и "U+"

Стоит заметить, что после унарного оператора нельзя использовать бинарные операторы
Например последовательность 1 + - / 2 невалидна. Бинарный оператор / идёт после использования унарного "-"

=cut

use 5.010;
use strict;
use warnings;
use diagnostics;
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';

sub tokenize {
	chomp(my $expr = shift);
	my @res;
	my $trig=2;

$expr=~ tr/ //ds;
given($expr) {
	when(/(?<![0-9])e/){die "Invalid expression whis 'e'!"}

	when(/\.(?![0-9])/){die "Wrong use of '.'!"}
	
	when(/(?<=\.[0-9])\.[0-9]/){die "Wrong use of '.'!"}

	when(/\/(?=0)/){die "Division by zero!"}

	when(/[-+*\/^][*\/^]/){die "Invalid use of binary operator!"}
	
	when(/^[-+]+[^0-9(]/){die "Invalid use of unary operator!"}
}

@res= split m{((?<!e)[-+]|[*()/^])}, $expr;
@res= grep($_ ne '',@res);

foreach my $item (@res) {
    if($item =~ /(\.(?=[0-9]))|e/) {
        $item = 0+$item;
		$item='' . $item;
    }
	if($item=~ /[-+]/ and ($trig==1 or $trig==2)){$item= 'U' . $item;}
	elsif($item=~ /[-+*^\/\(]/ and $trig==0){$trig=1;}
	elsif($item=~ /\d/){$trig=0;}
	
}
	return \@res;
}

1;
