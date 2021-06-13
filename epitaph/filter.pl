#!
use strict;
use warnings;

my $f = 0;

open my $fr, '<', 'epitaph.base.txt';
open my $fw, '>', 'epitaph.txt';

print $fw <<'EOF'
# NetHack 3.6  epitaph.txt       $NHDT-Date: 1524689580 2018/04/25 20:53:00 $  $NHDT-Branch: NetHack-3.6.0 $:$NHDT-Revision: 1.3 $
# Copyright (c) 2015 by Pasi Kallinen
# NetHack may be freely redistributed.  See license for details.
# Epitaphs for random headstones
#
#
EOF
;

while(<$fr>){
    if(substr($_, 0, 1) eq '#'){
        next;
    }
    $f = 1 - $f;
    if($f == 0){
        print $fw $_;
    }
}

close $fr;
close $fw;
