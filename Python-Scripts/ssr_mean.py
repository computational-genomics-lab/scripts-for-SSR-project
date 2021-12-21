#script to find the mean values of SSR regions of all the organisms
#files need to be in same directory as the program
#based on these mean values, scatterplots were plotted

import pandas as pd
import csv
from statistics import mean, stdev
import os

cwd = os.getcwd()
wd = cwd + "/bin"
print (wd)
try: lis1 = next(os.walk(wd))[2]
except: print("the bin directory doesn't exist")

		
data = []
lab = []
x = int()

for files in lis1:
	with open(files,"r") as f:
		query_ssr_file=pd.read_csv(f,header=0,sep="\t") 
		Repetitions=(query_ssr_file.loc[:,'Repetitions'].tolist())
		Motif=((query_ssr_file.loc[:,'Motif']).tolist())
		
		motif = []
		for i in Motif:
			x= len(i)
			motif.append(x)
		
			
		product = []
		for i,j in zip(Repetitions,motif):
			product.append(i*j)
		lab.append([files, mean(product)])
				
data.extend(lab)
		
	
			

header = ["Genome_name","mean", "standard_deviation"]
with open('ssr_mean.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)

    # write the header
    writer.writerow(header)

    # write the data
    writer.writerows(data)
