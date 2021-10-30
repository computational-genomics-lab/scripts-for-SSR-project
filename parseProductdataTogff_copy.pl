#!/usr/bin/perl


# This script takes the eggnog annotation file as well as the gff3 file annotated by funannotate
# Due to some parsing errors, the gff3 files are not having correct product annotations
# This script replaces the annotations in the gff3 file from the eggnog annotatin files 
# Author: Sucheta
# This script is modified to produce the 3' and 5' Flanking Intergenic distances
# Date : 21st Oct 2021



open FH, $ARGV[0] or die "can't open eggnog annotation file $!\n";

open FH1, $ARGV[1] or die "can't open gff3 file for adding annotations $!\n";

my %annotation=();

while(<FH>){

        chomp;

        if(/^#/){
                next;
        }

        my @line = split(/\t/,$_);


	$annotation{$line[0]}->{'product'}=$line[7];
	$annotation{$line[0]}->{'name'}=$line[20];

}

close(FH);

while(<FH1>){

	chomp;

	if(/^#/){
		next;
	}

	my @line = split(/\t/,$_);

	if($line[2] eq 'gene'){

		my $id;

		if($line[8] =~ /ID=(\S+);/){

		$id = $1."-T1";

		}		
	
		for(my $i=0;$i<=7;$i++){
			print "$line[$i]\t";
		}
		print "$line[8]name=$annotation{$id}->{'name'};product=$annotation{$id}->{'product'}\n";

		#print "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]\t$line[5]\t$line[6]\t$line[7]\t$line[8];name=$annotation{$id}->{'name'};product=$annotation{$id}->{'product'}\n";

	}
	elsif($line[2] eq 'mRNA'){

		my @annot = split(/;/,$line[8]);

			$parent = $1;

			$id = $annot[0];
			$id =~ s/ID=//;
			
			#print "id is $id\n";


		for(my $i=0;$i<=7;$i++){
			print "$line[$i]\t";
		}
		print "$annot[0];$annot[1];product=$annotation{$id}->{'product'};$annot[3]\n";


		#print "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]\t$line[5]\t$line[6]\t$line[7]\t$annot[0];$annot[1];product=$annotation{$id}->{'product'};$annot[3]\n";

	}	

	else{
		print $_,"\n";

	}	
			
                

}


close(FH1);

