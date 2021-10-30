#!/usr/bin/perl
#
#
#This script  replaces the genbank ids in rxlr, crn and WY effectors with refseq ids
#Takes rxlr file and mapping file as input
#
# Author Sucheta
# Date: October 2021

open FH, $ARGV[0] or die "Cant open mapping file $!\n";

my %hash = ();

while(<FH>){

	chomp;

	my @line = split(/\t/,$_);

	$hash{$line[0]} = $line[1];

}

close(FH);


open FH1, $ARGV[1] or die "Cant open annotation file $!\n";

while(<FH1>){
	
	chomp;

	if(/^#/){
		print $_,"\n";;
		next;
	}

	else{
		
		my $tmp = $_;

		my @line= split(/\t/,$_);

			print "$hash{$line[0]}\t";

			for(my $i=1;$i<=$#line;$i++){
				print "$line[$i]\t";
			}
			print "\n";
	}

}

close(FH1);

						


