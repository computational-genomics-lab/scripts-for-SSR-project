#!/usr/bin/perl 


# This script takes the GFF file as input 
# Author: Sucheta
# This script is modified to produce the 3' and 5' Flanking Intergenic distances
# Date : 17th Oct 2021 

my %HOH = &readGFF3($ARGV[0]);



# Initializing the minimum lengths to some arbitrary large values



for my $scaffold(keys %HOH){
	
	my @gene_arr = ();

	my @sorted = ();

	my $first_pass = 0;

	my $scaffoldLength = $HOH{$scaffold}->{'length'};

	#print "Scaffold length is $scaffoldLength\n";

	for my $gene(keys %{$HOH{$scaffold}}){
		

		my (@genes, @element);	
	
		@genes = sort{$a <=> $b} @{ $HOH{$scaffold}{$gene}{'gene_coord'}};
		my $strand = $HOH{$scaffold}{$gene}->{'strand'};

		#print "$scaffold\t$gene\t$genes[0]\t$genes[1]\t$strand\n";
		if($gene eq 'length'){ next; }
		push (@element,$genes[0], $genes[1], $gene, $strand);
		push ( @gene_arr, \@element);


	}

	# Sort the 2 diemnsional array by first column
	@sorted = sort {$a->[0] <=> $b->[0]} @gene_arr;

	my $index = $#sorted;

=begin comment
	for(my $i=0; $i <= $index; $i++){
		for(my $j=0; $j <= @{$sorted[$i]}; $j++){
			print "$sorted[$i+1][$j]\t";
			}
		print "\n";
		}	
=cut

	for(my $i=0; $i <= $index; $i++){
			if($first_pass == 0){
				if($i == $index){
					if($scaffoldLength == 0){ $scaffoldLength = $sorted[$i][1]; }
					print "$sorted[$i][2]\t$sorted[$i][0]\t",$scaffoldLength - $sorted[$i][1],"\t$sorted[$i][3]\n";
				}
				else{	
				print "$sorted[$i][2]\t$sorted[$i][0]\t",$sorted[$i+1][0]-$sorted[$i][1],"\t$sorted[$i][3]\n";
			}
				$first_pass=1;
			}
			else{	
				if($i==$index){
					if($scaffoldLength == 0){ $scaffoldLength = $sorted[$i][1]; }
					print "$sorted[$i][2]\t",$sorted[$i][0] - $sorted[$i-1][1],"\t", $scaffoldLength - $sorted[$i][1],"\t$sorted[$i][3]\n";			}

				else{
					
				print "$sorted[$i][2]\t",$sorted[$i][0] - $sorted[$i-1][1],"\t", $sorted[$i+1][0] - $sorted[$i][1],"\t$sorted[$i][3]\n";
			}
		}
	}

}

			


# Begin sub routine readGFF3##
# There are 3 levels: 1. gene -> 2. mRNA     -> 3. CDS; 3. exons
#                     1. gene{'gene_coord'}  -> gene coordinates
#                     2. mRNA{'mrna_coord'}  -> mRNA coordinates
#                     3. CDS{'CDS_coord'}    -> CDS coordinates
#                     3. exons{'exon_coord'} -> exon coordinates


sub readGFF3{

my $fileName = shift;
my %HOH;
my %geneNameHash;

open PRED, $fileName or die "Can't open file $!\n";

my $gene;

while(<PRED>){

	chomp;
	
	if(/^#/){
		next;
	}	
	
	my @line = split(/\t/,$_);
		

		
		if(/gene\t(\d+)\t(\d+)\t.\t(.)\t.\tID=(.*?);/i){

			$gene = $4;

			push(@{$HOH{$line[0]}->{$gene}->{'gene_coord'}}, $1, $2);
			$HOH{$line[0]}->{$gene}->{'strand'}=$3;

		}
		if(/\tregion\t(\d+)\t(\d+)\t.\t.\t.\tID=.*/i){
			$HOH{$line[0]}->{'length'} = $2;

		}






}

close PRED;
return %HOH;

}

