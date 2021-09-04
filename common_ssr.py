import pandas as pd
import os
import csv

no_files=int(input("enter no of files: "))
print("enter the names of the files: ")
x=[]
for i in range(0,no_files):
	user = input()
	x.append(user)

list_i=[]
list_j=[]
for files in x:
	with open(files,"r") as f:
		ref_ssr_file=pd.read_csv(f,header=0,sep="\t")
		ref_Motif=((ref_ssr_file.loc[:,'Motif']).tolist())	
        	 
		list_i.append(ref_Motif)

list_j= list(set.intersection(*map(set, list_i)))
#print(list_j)

with open("common_ssr.csv",'w') as f:
	writer = csv.writer(f)
	writer.writerow(["Motif"])
	for i in list_j:
		writer.writerow([i])
for i in x:
	with open(i,"r") as f:
		df1=pd.read_csv(f,header=0,sep="\t") 
		df1 = pd.DataFrame(df1)
	print(df1)

	with open("common_ssr.csv") as f:	

		df2=pd.read_csv(f,header=0) 
		df2 = pd.DataFrame(df2)
		df3=pd.merge(df2,df1, how='inner', on=["Motif"]) 

	df4=(df3.reindex(['Name','Seq_Len','StartPos','EndPos','Repetitions','Motif'],axis=1))
	df5 = (df4.drop_duplicates())

	filename = "common_ssr_" + str(i)
	df5.to_csv(filename,sep='\t',index=False)
