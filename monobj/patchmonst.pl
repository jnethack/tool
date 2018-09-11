#!
use strict;
use warnings;

use Data::Dumper;

my %type = (
    PROJECTILE => ')',
    WEAPON => ')',
    BOW => ')',
    HELM => ']',
    ARMOR => ']',
    DRGN_ARMR => ']',
    CLOAK => ']',
    SHIELD => ']',
    GLOVES => ']',
    BOOTS => ']',
    RING => '=',
    AMULET => '"',
    CONTAINER => '(',
    TOOL => '(',
    WEPTOOL => '(',
    FOOD => '%',
    POTION => '!',
    SCROLL => '?',
    SPELL => '+',
    WAND => '/',
    COIN => '$',
    GEM => '*',
    ROCK => '*',
    'OBJECT(OBJ' => 'K',
    );

{
    my %base;

    open my $fd, '<', 'jtrnsmon.dat' or die;

    while(<$fd>){
	if(!/^([^:]*):\t*([^:]*):/){next;}
	my($e, $j) = ($1, $2, $3);
	$base{$e} = $j;
    }
    close $fd;

    open my $fr, '<', 'monst.c' or die;

    my @orig;
    while(<$fr>){
	push @orig, $_;
    }
    close $fr;

    open my $fw, '>', 'monstj.c' or die;
    binmode($fw);
    for(@orig){
	if(/^ *MON\("([^\"]*)"/){
	    my $j = $base{$1};
	    if(defined $j){
		s/$1/$j/;
	    }
	}
	print $fw $_;
    }
    close $fw;
}
