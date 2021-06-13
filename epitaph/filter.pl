#!
use strict;
use warnings;

my $f = 0;
while(<>){
    if(substr($_, 0, 1) eq '#'){
        next;
    }
    $f = 1 - $f;
    if($f == 0){
        print $_;
    }
}
