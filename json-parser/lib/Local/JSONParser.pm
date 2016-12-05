package Local::JSONParser v1.0.0;
use strict;
use warnings;
use utf8;
use Encode qw(decode);
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );
my $bracount = 0;

sub parse_json {
	my $source = \$_[0];
	my $substr;
    foreach ($$source) {
        if (/\G\s*(-?\d+[\.eE]?\d*[-+]*\d*)/gc) {
			die "Invalid JSON sequence!" if $bracount == 0;
			return $1;
	    }
        elsif (/\G\s*\"([^"\\]*)/gc) {
			die "Invalid JSON sequence!" if $bracount == 0;
            $substr = decode ("utf8", $1);
            while(!(/\G\"/gc)) {
                if (/\G\\n/gc) {$substr = $substr . chr(10);}
				elsif (/\G\\\"/gc) {$substr = $substr . chr(34);}
				elsif (/\G\\u(\w{3,4})/gc) {$substr = $substr . chr(hex($1));}
				elsif (/\G\\t/gc) {$substr = $substr . chr(9);}
				elsif (/\G\\\\/gc) {$substr = $substr . chr(92);}
				elsif (/\G\\/gc) {$bracount = 0; die "Invalid JSON sequence!";}
				else {
                    /\G([^"\\]*)\s*/gc;
                    $substr = $substr . decode ("utf8", $1);
				}
            }
            return $substr;
        }
        elsif(/\G\s*[\'\"]?\[/gc) {
			$bracount++;
            my $i = 0;
            my @subarr;
            while (!(/\G\s*\][\'\"]?/gc)) {
                $subarr[$i++] = parse_json($$source);
                /\G\s*,/gc;
            }
            return \@subarr;
        }
        elsif (/\G\s*[\'\"]?\{/gc) {
			$bracount++;
            my %subhesh;
            while(!(/\G\s*\}[\'\"]?/gc)) {
                if (/\G\s*(\".*?\")\s*:/gc) {
                    my $key = $1;
		    $key = parse_json($key);
                    $subhesh{$key} = parse_json($$source);
                    /\G\s*,/gc;
                }
                else {$bracount = 0; die "Invalid JSON sequence!";}
            }
            return \%subhesh;
        }
        else {$bracount = 0; die "Invalid JSON sequence!";}
    }
}

1;
