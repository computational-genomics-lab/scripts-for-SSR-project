#!/usr/bin/perl -w
#

open FH, $ARGV[0] or die "cant open file for reading $! \n";

while(<FH>){

	 chomp;

        if(/^#/){
                next;
        }

        my @line = split(/\t/,$_);

		if($line[1] > $line[2]){
			
			print "$line[0]\tGenbank\tgene\t$line[2]\t$line[1]\t.\t-\t.\tID=$line[3];name=$line[3];product=$line[3]\n";
		}
		else{
			print "$line[0]\tGenbank\tgene\t$line[1]\t$line[2]\t.\t+\t.\tID=$line[3];name=$line[3];product=$line[3]\n";
		}
	}

close(FH);	
				

