package Local::JSONParser v1.0.0;
use strict;
use warnings;
use utf8;
use Encode qw(decode);
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

sub parse_json {
	my $source = \$_[0];
	my $substr ;
    foreach ($$source) {
        if (/\G\s*(-?\d+[\.eE]?\d*[-+]*\d*)/gc) {return $1;}
        elsif (/\G\s*\"([^"\\]*)/gc) {	
            $substr = decode ("utf8", $1);
            while(!(/\G\"/gc)) {
                if (/\G\\n/gc) {$substr = $substr . chr(10);}
				elsif (/\G\\\"/gc) {$substr = $substr . chr(34);}
				elsif (/\G\\u(\w{3,4})/gc) {$substr = $substr . chr(hex($1));}
				elsif (/\G\\t/gc) {$substr = $substr . chr(9);}
				elsif (/\G\\\\/gc) {$substr = $substr . chr(92);}
				elsif (/\G\\/gc) {die "Invalid JSON sequence!";}
				else {
                    /\G([^"\\]*)\s*/gc;
                    $substr = $substr . decode ("utf8", $1);
				}
            }
            return $substr;
        }
        elsif(/\G\s*[\'\"]?\[/gc) {
            my $i = 0;
            my @subarr;
            while (!(/\G\s*\][\'\"]?/gc)) {
                $subarr[$i++] = parse_json($$source);
                /\G\s*,/gc;
            }
            return \@subarr;
        }
        elsif (/\G\s*[\'\"]?\{/gc) {
            my %subhesh;
            while(!(/\G\s*\}[\'\"]?/gc)) {
                if (/\G\s*(\".*?\")\s*:/gc) {
                    my $key = $1;
		    $key = parse_json($key);
                    $subhesh{$key} = parse_json($$source);
                    /\G\s*,/gc;
                }
                else {die "Invalid JSON sequence!";}
            }
            return \%subhesh;
        }
        else {die "Invalid JSON sequence!";}
    }
}

1;
