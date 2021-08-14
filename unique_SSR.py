import pandas as pd
import os
import csv

# user has to make a directory called bin which will contain all the ssr files
# making the bin directory of user the working directory
cwd = os.getcwd()
wd = cwd + "/bin"
print (wd)
try: x = next(os.walk(wd))[2]
except: print("the bin directory doesn't exist")

# taking query file as input and attaching .ssr as attachment

query_SSR =input("Enter name of query SSR file: ")
query_SSR = query_SSR + ".ssr"

# taking the motif column of the query file and putting it in a list to be compared with later on

with open(query_SSR,"r") as ref:

	ssr_file=pd.read_csv(ref,header=0,sep="\t")
	Motif=((ssr_file.loc[:,'Motif']).tolist())


#A function is defined to make a csv file containing the unique SSR motifs in the query file. The function also takes these motifs as keys and fetches all the relevant information from the query SSR file which was taken as input. This was written in another csv file. This function also prints the common SSR motifs between the query and the reference files
#put this at the top
def open_func(x):
	list_i=[]
	for files in x:
		with open(files,"r") as f:
			ref_ssr_file=pd.read_csv(f,header=0,sep="\t")
			ref_Motif=((ref_ssr_file.loc[:,'Motif']).tolist())	
        	 
			list_i.extend(ref_Motif)

# create list of unique SSR motifs
	unique_in_query=[]
	for i in Motif:
		if i not in list_i:
			unique_in_query.append(i)

#create a csv file which has LIST of all the unique motifs which we just put in the variable called 'unique_in_query'	
	f = open('ssr_u.csv', 'w')
	writer = csv.writer(f)
	writer.writerow(["Motif"])

	for u in unique_in_query:
		writer.writerow([u])   # here we are converting the string u into a list
	f.close()

#opening the file with the name contained in the 'query_SSR' variable  
	with open(query_SSR,"r") as f:
		df1=pd.read_csv(f,header=0,sep="\t") #taking all the info in the query SSR file and converting it into a datafram 'df1'
#opening 'ssr_u.csv'
#we will fetch information about each of the unique motifs in ssr_u.csv; from the original query SSR file
	with open("ssr_u.csv") as f:
		df2=pd.read_csv(f,header=0) 
		df3=pd.merge(df2, df1,on="Motif") #merging the dataframes on the basis of the 'Motif' column

	df4=(df3.reindex(['Name','Seq_Len','StartPos','EndPos','Repetitions','Motif'],axis=1))
	df5 = (df4.drop_duplicates())
#converting the final dataframe with all the info about the unique motifs in query SSR file into a tsv file 'unique_ssr.tsv'
	df5.to_csv('unique_ssr.tsv',sep='\t',index=False)

# ask user to choose the mode of operation (default or special)

user=input("enter mode of operation default or special : ")

#default mode : here the query file is compared with rest of the SSR files in the bin directory of the user 
reference_list=[]
if user == "default":
	for i in x:
		if i != query_SSR: reference_list.append(i)  #all the files in the variable 'x' (which was declared at first) apart from the query SSR file are put inside a variable called reference_list 
	open_func(reference_list) 
	
#special mode : here the query file is compared with the reference files which are entered manually by the user  
lst=[]
if user == "special":
	
	n=int(input("Enter number of SSR files to be entered as reference : ")) #taking as input the number of files to be taken as reference
	print("now enter names of the files : ") # ask user to input names of the SSR files
	for i in range(0, n) :
		ele=str(input())
		lst.append(ele)
	open_func(lst) 


