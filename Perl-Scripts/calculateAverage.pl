#!/usr/bin/perl -w


use List::Util qw(min max sum);

#
#This script takes 5 files:
# 1. All FIR file  2. Busco FIR file 3. RXLR FIR file 4. CRN FIR file 5. WYL FIR file
# Computes the average 5'distance and 3'distance Max 5'distance Min 5'distance Max 3'distance Min 3'distance

my $firstpass = 0;

#while(!$firstpass){
#	print "All FiveMin\tAll FiveMax\tAll ThreeMin\tAll ThreeMax\tAll FiveAverage\tAll ThreeAverage\tBusco FiveMin\tBusco FiveMax\tBusco ThreeMin\tBusco ThreeMax\tBusco Average\tRXLR FiveMin\tRXLR FiveMax\tRXLR ThreeMin\tRXLR ThreeMax\tRXLR FiveAverage\tRXLR ThreeAverage\tCRN FiveMin\tCRN FiveMax\tCRN ThreeMin\tCRN ThreeMax\tCRN FiveAverage\tCRN ThreeAverage\tWYL FiveMin\tWYL FiveMax\tWYL ThreeMin\tWYL ThreeMax\tWYL FiveAverage\tWYL ThreeAverge\n";
#	$firstpass = 1;
#}	

print "$ARGV[0]\t";

for (my $i=0; $i<=4; $i++){
	open FH, $ARGV[$i] or die "can't open file for reading $!\n";
	
	my $count = 0;

	my @fivenumbers;
	my @threenumbers;

	while(<FH>){
		
		chomp;

		my @line = split(/\t/,$_);

		if ($line[1] > 1){ push (@fivenumbers, $line[1]);}	
		if ($line[2] > 1){ push (@threenumbers, $line[2]);}


	}		

close(FH);	
		my $fivemin = min @fivenumbers;
		my $threemin = min @threenumbers;
		my $fivemax = max @fivenumbers;
		my $threemax = max @threenumbers;
		my $fivediv;
		my $threediv;
		if($#fivenumbers == 0){ $fivediv = 1; } else { $fivediv = $#fivenumbers; }
		if($#threenumbers == 0){ $threediv = 1; } else { $threediv = $#threenumbers; }
		my $fiveaverage = (sum @fivenumbers)/$fivediv;
		my $threeaverage =( sum @threenumbers)/$threediv;

		print "$fivemin\t$fivemax\t$threemin\t$threemax\t$fiveaverage\t$threeaverage\t";

	}

print "\n";	
