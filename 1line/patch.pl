#! /usr/bin/perl
print STDERR "$ARGV\n";
open F, $ARGV;
my (@file) = <>;
my (@file2) = @file;
close F;
for($i = 0; $i < $#file; $i++){
$file2[$i] =~ s/^[\t ]+//;
}
open FI, "<../../1line/$ARGV.txt";
while(!eof(FI)){
	my ($i);
	my ($in, $in2, $out);
	my ($f) = 0;
	$in = <FI>;
	$out = <FI>;
	$in2 = $in;
	$in2 =~ s/^[\t ]+//;
	for($i = 0; $i < $#file; $i++){
		if($file[$i] eq "#if 0 /*JP*/\n"){
			$f = 1;
			next;
		}
		if($file[$i] =~ /endif/){
			$f = 0;
			next;
		}

		if($f == 1){
			next;
		}

		if($in2 eq $file2[$i]){
			$file[$i] = "/*JP\n$in*/\n$out";
			$file2[$i] = '';
			last;
		}
	}
	if($i == $#file){
		print "$ARGV:\n" . $in . $out;
	}
}
close FI;
open FO, ">$ARGV.new";
print FO @file;
close FO;
