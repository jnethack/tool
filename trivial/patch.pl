#! /usr/bin/perl
use strict;
use warnings;

print STDERR "$ARGV[0]\n";
my @file;
my @file2;
my @diff;
{
    open F, $ARGV[0];
    (@file) = <>;
    (@file2) = (@file);
    close F;
}
for(my $i = 0; $i < $#file; $i++){
    $file2[$i] =~ s/^[\t ]+//;
}

{
    my $f = 0;
    my $s1 = '';
    my $s2 = '';
    open my $fi, "<../../trivial/$ARGV.txt" or die $!;
    while(<$fi>){
        if($_ eq "---\n"){
            if($f == 0){
                $f = 1;
            } else {
                my ($ss1, $ss2) = ($s1, $s2);
                push @diff, [$ss1, $ss2];
                $s1 = $s2 = '';
                $f = 0;
            }
            next;
        }
        if($f == 0){
            s/^[\t ]+//;
            $s1 .= $_;
        } else {
            $s2 .= $_;
        }
    }
}

for(my $i = 0; $i <= $#file; $i++){
#    print "$i\n$file2[$i]\n";
    for(my $di = 0; $di <= $#diff; $di++){
        my($so, $sp) = @{$diff[$di]};
#print "$so\n-\n$sp\n--\n";
        my(@ol) = split /(?<=\n)/, $so;
        my $f = 0;
        for(my $c = 0; $c <= $#ol; $c++){
            if($file2[$i + $c] ne $ol[$c]){
                $f = 1;
                last;
            }
        }
        if($f == 0){
            $file[$i] = "#if 0 /*JP:T*/\n" . $file[$i];
            $file[$i + $#ol] = $file[$i + $#ol] . "#else\n" . $sp . "#endif\n";
#            $file2[$i] = '';
            for(my $c = 0; $c <= $#ol; $c++){
#                $file[$i + $c] = '';
                $file2[$i + $c] = '';
            }
            splice @diff, $di, 1;
            last;
        }
    }
#    if($i == 200){last;}
}

open FO, ">$ARGV.new";
print FO @file;
close FO;

for(@diff){
    my($so, $sp) = @$_;
    printf "%s--\n%s--\n", $so, $sp;
}
