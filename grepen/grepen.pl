#! /usr/bin/perl
use strict;
use warnings;

binmode(STDIN);

my $f = 0;

while(<>){
    chomp;
    if(m@^.if 0 /\*JP@){
        $f = 1;
        next;
    }
    if($f == 1 && ($_ =~ /^.endif/ || $_ =~ /^.else/)){
        $f = 0;
        next;
    }
    if($f == 1){
        next;
    }
    if($_ eq "/*JP"){
        $f = 2;
        next;
    }
    if($f == 2 && $_ eq "*/"){
        $f = 0;
        next;
    }
    if($f == 2){
        next;
    }

    if(m@^ */?\*@){ next; }
    if(/ifdebugresist\(/){ next; }
    if(/debugpline\d\(/){ next; }
    if(/impossible\(/){ next; }
    if(/panic\(/){ next; }
    if(/.include/){ next; }

    s@/\*.*\*/@@g;
    my $ff = 0;
    while(/\"([^\"]*)\"/gc){
        my $m = $1;
        $m =~ s/%s//g;

        if($m =~ /^[ !#-~]+$/a){ # }
            $ff = 1;
        }
    }
    if($ff == 1){
        printf "%d:%s\n", $., $_;
    }
}
