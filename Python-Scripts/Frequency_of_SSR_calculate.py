#Python program to calculate the total no of SSRs, no of SSR motifs and frequency of SSR
#Here the GMATA derived SSR files are the input files; We have to keep the SSR files for all the genomes in the same directory as the script. 
#We need to provide an input csv file containing the SSR file name of the genome on the first column and genome size in MB in the second coloumn.
#The SSR file name in the csv file must be same as the SSR files present in the same directory. 
#Example csv file format : 
# Genome,Genome_size_in_MB
# Phyag_NZFS3770.fna.ssr,37
# Phyag_NZFS3772.fna.ssr,37


import pandas as pd
import csv
import collections
data=[]
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
#Motif frequency calculation
def get_list_of_elements_of_list(Motif):
	lst1=[]
	for i in Motif:
		lst1.append(len(i))
		lst1.sort()
	frequency=collections.Counter(lst1)
	return((dict(frequency)))

lst=[]
product=[]
lst1=[]
#open and read the csv file which contains two columns Genome_name,Genome_size_in_MB
with open('list_128_phy_genome_11_7_2021.csv',"r") as f1:
	next(f1)
	reader=csv.reader(f1)
	dict_from_csv = {rows[0]:float(rows[1]) for rows in reader}

for keys in dict_from_csv.keys():
	lst1.append(keys)

for files in lst1:
	with open(files,"r") as f:
		query_ssr_file=pd.read_csv(f,header=0,sep="\t")
		Repetitions=(query_ssr_file.loc[:,'Repetitions'].tolist())
		Motif=((query_ssr_file.loc[:,'Motif']).tolist())
		for i,j in zip(Repetitions,Motif):
			product.append(i*j)
		l=''.join(product)
		ssr_density=(float(len(l))/float(dict_from_csv.get(files)))
		ssr_coverage=((float(len(l))/(float(dict_from_csv.get(files))*(float(pow(10,6)))))*100)
		lab=[]
		lab=[files,len(Motif),no_of_ssr_motifs(Motif),get_list_of_elements_of_list(Motif)]
		data.append(lab)



header = ["Genome_name","total_no_of_SSR","no_of_SSR_motif","frequency"]
with open('tmp_freq_motif.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)

    # write the header
    writer.writerow(header)

    # write the data
    writer.writerows(data)

