This directory contains 9 scripts written in Pearl.
The following are the scripts and their utilities:

1) calculateAverage.pl 
This is a script which takes 5 files:All FIR file, Busco FIR file, RXLR FIR file, CRN FIR file and WYL FIR file; and then computes the average 5'distance and 3'distance Max 5'distance Min 5'distance Max 3'distance Min 3'distance

2) convertFunannotateToGenbank.pl
This script will convert the funannotate files into Genbank type gff so parsing and working with tabix conversion and display with jbrowse becomes feasible

3)convertToGFF.pl

4)correctBuscoFiles.pl
This script corrects the order of the BUSCO files so that the scaffold name is placed in the first column and the first column is placed in the third column

5)correctRefseq.pl
This script  replaces the genbank ids in rxlr, crn and WY effectors with refseq ids takes rxlr file and mapping file as input

6)getFIRofBusco.pl
This script takes a list file and greps the values of FIRs from the master FIR file and computes the average

7)getFIRs.pl
This script takes the GFF file as input and produces the 3' and 5' Flanking Intergenic distances

8)parseProductdataTogff_copy.pl
This script takes the eggnog annotation file as well as the gff3 file annotated by funannotate
Due to some parsing errors, the gff3 files are not having correct product annotations
This script replaces the annotations in the gff3 file from the eggnog annotation files

9)removeNegative.pl
This script takes an FIR data file and removes the columns having negative values
