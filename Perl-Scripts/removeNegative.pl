#!/usr/bin/perl -w
#
#This script takes a FIR data file and removes the columns having negative values
#
#Author Sucheta
#Date : October 2021

open FH, $ARGV[0] or die "cant open file for reading $!\n";

while(<FH>){

	my @line =split(/\t/,$_);

		if(($line[1] <= 0 ) or ($line[2] <= 0)){
			next;
		}
		else{
			print $_;
		}
	}

close(FH);	
