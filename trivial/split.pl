#! /usr/bin/perl -i.bak
use strict;
use warnings;

my $f = 0;

my $en = '';
my $jp = '';

open my $ff, ">../../trivial/$ARGV[0].txt" or die $!;

while(<>){
    if($_ eq "#if 0 /*JP:T*/\n"){
        $f = 1;
        next;
    }
    if($f == 0){
        print $_;
        next;
    }
    if($_ eq "#else\n"){
        $f = 2;
        next;
    }
    if($f == 1){
        $en .= $_;
        next;
    }
    if($_ eq "#endif\n"){
        print $ff $en;
        print $ff "---\n";
        print $ff $jp;
        print $ff "---\n";
        print $en;
        $f = 0;
        $en = '';
        $jp = '';
        next;
    }
    {
        $jp .= $_;
        next;
    }
}

close $ff;
