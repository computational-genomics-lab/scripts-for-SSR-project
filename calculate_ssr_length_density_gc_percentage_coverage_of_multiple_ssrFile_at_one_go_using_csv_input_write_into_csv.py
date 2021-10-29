#Python script to calculate SSR Length, SSR Density, GC Percentage of SSR, SSR Coverage 
#Here the GMATA derived SSR files are the input files; We have to keep the SSR files for all the genomes in the same directory
#as the script. 
#We need to provide a input csv file containing the SSR file name of the genome on the first column and genome size in MB in the second coloumn.
#The SSR file name in the csv file must be same with SSR files present in the same directory. 
#Example csv file format : 
# Genome,Genome_size_in_MB
# Phyag_NZFS3770.fna.ssr,37
# Phyag_NZFS3772.fna.ssr,37
#calculate the SSR density( bp covered by SSRs per Mb of the genome )

#SSR_density=(float(total_ssr_length_across_genome)/float(Genomesize_in_MB))
#print("SSR_DENSITY", SSR_density)

#calculate SSR coverage (% of genome covered)

#SSR_coverage=(float(total_ssr_length_across_genome)/(float(Genomesize_in_MB)*(float(pow(10,6)))))*100

import pandas as pd
import csv
data = []
#function to calculate gc_percentage
def get_gc_percentage(l):
	C=l.count("C")
	G=l.count("G")

	GC_TOTAL=(G+C)
	GC_PERCENTAGE=(float(GC_TOTAL)/float(len(l)))*100
	return( GC_PERCENTAGE)
def no_of_ssr_motifs(Motif):
	lst2=[]
	for i in Motif:
		if i not in lst2:
			lst2.append(i)
	return (len(lst2))	
lst=[]
product=[]
lst1=[]
#open and read the csv file which contains two columns Genome_name,Genome_size_in_MB
with open('list_128_phy_genome_11_7_2021.csv',"r") as f1:
	next(f1)
	reader= csv.reader(f1)
	dict_from_csv = {rows[0]:float(rows[1]) for rows in reader}

#get the keys of dictionary as list which contains genomes name as elements
for keys in dict_from_csv.keys():
	lst1.append(keys)

print("Genome_name","ssr_length","gc_percentage_of_ssr","ssrDensity","ssrCoverage","no_of_ssr","no_of_ssr_motif")
for files in lst1:
	with open(files,"r") as f:
		query_ssr_file=pd.read_csv(f,header=0,sep="\t")
		Repetitions=(query_ssr_file.loc[:,'Repetitions'].tolist())
		Motif=((query_ssr_file.loc[:,'Motif']).tolist())
		#print(f,":",Repetitions,Motif)
		for i,j in zip(Repetitions,Motif):
			product.append(i*j)
			#print(product)
		#print(product)
		l=''.join(product)
		#print(l)
		#print(files,"TOTAL SSR LENGTH", len(l),get_gc_percentage(l))
		ssr_density=(float(len(l))/float(dict_from_csv.get(files)))
		ssr_coverage=((float(len(l))/(float(dict_from_csv.get(files))*(float(pow(10,6)))))*100)
		#print("Genome_name","gc_percentage_of_ssr","ssrDensity","ssrCoverage")
		#print(files,len(l),get_gc_percentage(l),ssr_density,ssr_coverage,len(Motif),no_of_ssr_motifs(Motif))
		lab =[]		
		lab = [files,len(l),get_gc_percentage(l),ssr_density,ssr_coverage,len(Motif),no_of_ssr_motifs(Motif)]
		data.append(lab)
		
		
print (data)


		


header = ["Genome_name","ssr_length","gc_percentage_of_ssr","ssrDensity","ssrCoverage","no_of_ssr","no_of_ssr_motif"]
with open('ssr.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)

    # write the header
    writer.writerow(header)

    # write the data
    writer.writerows(data)