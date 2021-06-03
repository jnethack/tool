#! /usr/bin/perl
use strict;
use warnings;

binmode(STDIN);

my $f = 0;

while(<>){
    if (eof) {     # eof() Ç≈ÇÕÇ»Ç¢ÅB
        close(ARGV);
    }
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
    if(/error\(/){ next; }

    if(/getobj\(/){ next; }
    if(/floorfood\(/){ next; }
    if(/wield_tool\(/){ next; }

    if(/.include/){ next; }

    s@/\*.*\*/@@g;
    my $ff = 0;
    while(/\"([^\"]*)\"/gc){
        my $m = $1;
        $m =~ s/%-?[0-9]*l?[sd]//g;
        $m =~ s/[ \[\]]//g;

        if($m =~ /^[ !#-~]+$/a){ # }
            $ff = 1;
        }
    }
    if($ff == 1){
        printf "%s:%d:%s\n", $ARGV, $., $_;
    }
}
