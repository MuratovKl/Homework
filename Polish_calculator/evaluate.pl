=head1 DESCRIPTION

Эта функция должна принять на вход ссылку на массив, который представляет из себя обратную польскую нотацию,
а на выходе вернуть вычисленное выражение

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

sub evaluate {
	my $rpn = shift;
	my @heap;
	my $secop;
	my @rpnout=@$rpn;
	while(scalar @rpnout!=0){
    given($rpnout[0]){
        when(/\d/){push @heap,shift @rpnout}
        
        when(/U\+/){shift @rpnout}
        
        when(/U\-/){
            shift @rpnout;
            $heap[$#heap]= -$heap[$#heap];
        }
        
        when(/\+/){
            shift @rpnout;
            $secop= pop @heap;
            $heap[$#heap]+= $secop;
        }
        
        when(/\*/){
            shift @rpnout;
            $secop= pop @heap;
            $heap[$#heap]*= $secop;
            }
        
        when(/\//){
            shift @rpnout;
            $secop= pop @heap;
            $heap[$#heap]/= $secop;
            }
        
        when(/\-/){
            shift @rpnout;
            $secop= pop @heap;
            $heap[$#heap]-= $secop;
            }
        
        when(/\^/){
            shift @rpnout;
            $secop= pop @heap;
            $heap[$#heap]**= $secop;
            }
    }
}
	return pop @heap;
}

1;
