#!/usr/bin/perl -w
#
#This script takes a list file and greps the values of FIRs from the master FIR file
#Computes the average
# Author Sucheta
#
# Date: Oct 2021
#


open FH, $ARGV[0] or die "cant open list file for rading \n";

my %list = ();

while(<FH>){

	chomp;

	$list{$_} = 1;

}

close(FH);

open FH1, $ARGV[1] or die "cant open list file for rading \n";


while(<FH1>){

	chomp;

	my $line = $_;
	my @arr = split(/\t/,$_);

	if(exists($list{$arr[0]})){
		print "$line\n";
	}
}

close(FH1);



