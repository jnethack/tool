#! /usr/bin/perl -i.bak
while(<>){
	if($_ eq "/*JP\n"){
		my($s1, $s2, $s3);
		$s1 = <>;
		$s2 = <>;
		$s3 = <>;
		if($s2 eq "*/\n"){
			print $s1;
			open FF, ">>../../1line/$ARGV.txt";
			print FF $s1;
			print FF $s3;
			close FF;
		} else {
			print "/*JP\n";
			print $s1;
			print $s2;
			print $s3;
		}
	} else {
		print $_;
	}
}


