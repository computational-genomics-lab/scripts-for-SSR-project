#!/usr/bin/perl -w
#
#This script corrects the order of the BUSCO files so that the scaffold name is placed in the first column
#And the first column is placed in the third column
#
#Author: Sucheta   Date: 25th October 2021


open FH, $ARGV[0] or die "cant open file for reading $!\n";

while(<FH>){

	chomp;

	if(/^#/){
		print $_,"\n";
	}
	else{	

	my @line= split(/\t/,$_);

	print "$line[2]\t$line[1]\t$line[0]\t$line[3]\t$line[4]\t$line[5]\t$line[6]\t$line[7]\t$line[8]\n";
	}	

}

close(FH);
