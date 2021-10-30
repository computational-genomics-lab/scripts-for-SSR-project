#!/usr/bin/perl
#
#This script will convert the funannotate files into Genbank type gff
#So parsing and working with tabix conversion and display with jbrowse becomes
#feasible
#Author: Sucheta
#Date: 24th October 2021

#This script takes 5 arguements
# 1- mapping file 2-gff file from funannotate 3-strain 4-taxon id 5-country of origin 6-host
# The output is printed to the screen
 
my $strain = $ARGV[2];
my $taxon_id=$ARGV[3];
my $country = $ARGV[4];
my $host = $ARGV[5];

open FH, $ARGV[0] or die "Can't open file for reading $!\n";

my %hash = ();

while(<FH>){

	chomp;
	my @line = split(/\t/,$_);

	$hash{$line[0]}=$line[1];
}

close(FH);

open FH1, $ARGV[1] or die "can't open file for reading $!\n";

print "##gff-version 3\n";
print "#!gff-spec-version 1.21\n";
print "#!processor funannotate local\n";
print "#!genome-build $ARGV[1]\n";
print "#!genome-build-accession NCBI_Assembly:$ARGV[1]\n";
print "#!annotation-date Oct 2021\n";
print "#!annotation-source ST Lab CSIR-IICB, Kolkata, India Release 1.01\n";


my $firstpass = 0;

my $scaffold_name;

while(<FH1>){

	chomp;

	my @line = split(/\t/,$_);

	if(!$scaffold_name and !$firstpass){
		print "##sequence-region $line[0] 1 $hash{$line[0]}\n";
		print "##species https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=$taxon_id\n";
		print "$line[0]\tfunannotate\tregion\t1\t$hash{$line[0]}\t.\t+\t.\tID=$line[0]:1..$hash{$line[0]};Dbxref=taxon:$taxon_id;country=$country;gbkey=Src;mol_type=genomic DNA;nat-host=$host;strain=$strain\n";
		print "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]\t$line[5]\t$line[6]\t$line[7]\t";
			
			$line[8] =~ s/Name=(.*?);name=(.*?);/Name=$1;/;
			$line[8] =~ s/name=-/Name=Hypothetical Protein/;
			$line[8] =~ s/product=-/product=Hypothetical Protein/;
			$line[8] =~ s/product=;|product=$/product=Hypothetical Protein;/;
			$line[8] =~ s/name=;/Name=Hypothetical Protein;/;
			$line[8] =~ s/prob=/prob /;
			$line[8] =~ s/cutsite=/cutsite /;

			print "$line[8]\n";
			


		$scaffold_name=$line[0];
		$firstpass = 1;
		

	}
	elsif($scaffold_name eq $line[0]){
		for (my $i=0; $i<=7;$i++){
			print "$line[$i]\t";
		}
			$line[8] =~ s/Name=(.*?);name=(.*?);/Name=$1;/;
			$line[8] =~ s/name=-/Name=Hypothetical Protein/;
			$line[8] =~ s/product=-/product=Hypothetical Protein/;
			$line[8] =~ s/product=;|product=$/product=Hypothetical Protein;/;
			$line[8] =~ s/name=;/Name=Hypothetical Protein;/;
			$line[8] =~ s/prob=/prob /;
			$line[8] =~ s/cutsite=/cutsite /;
		
			
			
			
			#my @last = split(/;/,$line[8]);

			#my $flag = 0;
		
			#for(my $j;$j<=$#last;$j++){
			#	if($last[$j] =~ /product=-/){
			#	       	print "product=Hypothetical protein;";
			#	}
			#	elsif($last[$j] =~ /Name=(.*)/ and !$flag){
			#		print "name=$1;";
			#		$flag = 1;
			#	}
			#	elsif($last[$j] =~ /Name=-/ and !$flag){
			#		print "name=Hypothetical protein;";
			#	}
			#}
			print "$line[8]\n";

	}
	else{
		$scaffold_name = $line[0];
		print "##sequence-region $line[0] 1 $hash{$line[0]}\n";
		print "##species https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=$taxon_id\n";
		print "$line[0]\tfunannotate\tregion\t1\t$hash{$line[0]}\t.\t+\t.\tID=$line[0]:1..$hash{$line[0]};Dbxref=taxon:$taxon_id;country=$country;gbkey=Src;mol_type=genomic DNA;nat-host=$host;strain=$strain\n";
		print "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]\t$line[5]\t$line[6]\t$line[7]\t";
			
			$line[8] =~ s/Name=(.*?);name=(.*?);/Name=$1;/;
			$line[8] =~ s/name=-/Name=Hypothetical Protein/;
			$line[8] =~ s/product=-/product=Hypothetical Protein/;
			$line[8] =~ s/product=;|product=$/product=Hypothetical Protein;/;
			$line[8] =~ s/name=;/Name=Hypothetical Protein;/;
			$line[8] =~ s/prob=/prob /;
			$line[8] =~ s/cutsite=/cutsite /;
			print "$line[8]\n";

	}

}

close(FH1);


