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

    open my $fd, '<', 'jtrnsobj.dat' or die;

    while(<$fd>){
	if(!/^(.)([^:]*):\t*([^:]*):/){next;}
	my($c, $e, $j) = ($1, $2, $3);
	if($c eq '#'){next;}
	my $itemhash = $base{$c};
	if(!defined $itemhash){
	    $itemhash = {};
	}
	$$itemhash{$e} = $j;
	$base{$c} = $itemhash;
    }
    close $fd;

    open my $fr, '<', 'objects.c' or die;

    my @orig;
    while(<$fr>){
	push @orig, $_;
    }
    close $fr;

    open my $fw, '>', 'objectsj.c' or die;
    binmode($fw);
    for(@orig){
	if(/^(OBJECT\(OBJ|[A-Z_]+)\("([^\"]*)", *"([^\"]*)"/){
	    my $c = $type{$1};
	    if(defined $c){
		my $e = $2;
		my $e2 = $3;
		{
		    my $j = $base{$c}{$e};
		    if(defined $j){
			s/$e/$j/;
		    }
		}
		{
		    my $j = $base{$c}{$e2};
		    if(defined $j){
			s/$e2/$j/;
		    }
		}
	    }
	} elsif(/^([A-Z_]+)\((None, *)?"([^\"]*)"/){
	    my $c = $type{$1};
	    if(defined $c){
		my $e = $3;
		my $j = $base{$c}{$e};
		if(defined $j){
		    s/$e/$j/;
		}
	    }
	}
	print $fw $_;
    }
    close $fw;
}
