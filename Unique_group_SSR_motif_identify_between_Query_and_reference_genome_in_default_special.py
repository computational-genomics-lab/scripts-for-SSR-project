#Python program to identify unique Group SSR motifs between query and reference genomes. 
#Required files - SAT2 and SSR files of each genome must be in the same directory of the program
#input file : EX. Phyag_NZFS3770.fna
#In default mode it will detect the unique group motifs of the input genome, comparing the all other genomes in the present directory
#In special mode, We have to put the names of the reference genomes along with the query genome name.
#Run the program as python3 unique_group_motif_ssr_identify_default_special.py
#First enter the name of the query genome as Phyag_NZFS3770.fna
#Then enter the mode if special
#Then enter the number of reference genome if 1
#Then enter the name of reference genome as the name of SAT2 file name such as Phyag_NZFS3772.fna.ssr.sat2

from pathlib import Path
import itertools
import csv
from itertools import product
from string import ascii_lowercase
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import re
import os

#READING THE SAT2 FILE 
def read_ssr2_file(file_name):

  with open(file_name) as f:
      lines = f.readlines()
      read_flag = False
      data_df = pd.DataFrame()
      data_dct = {}
      row_dct = {}
      column_header = []
      for line in lines:
        line = line.strip()
        if re.match(r'^Table 3', line):
          read_flag = True
          continue

        if read_flag and re.match(r'^total_above',line):
          break

        if re.match(r'^Table 4', line):
          read_flag = False

        if read_flag:
          line_arr = line.split('\t')
          if re.match(r'^Grouped_Motif',line):
            column_header = line_arr
          else:
            data_dct[line_arr[0]] = ((line_arr[2]))
            
            df=pd.DataFrame.from_dict(data_dct,orient='index')
      #return data_dct
      #converting the index into a column with header name motif
      df['motif'] = df.index
      #resetting the index
      df1=df.reset_index()
      #drop the column name index
      df2=df1.drop(['index'], axis = 1)
      #converting the motif column into a list named Motif
      Motif=((df2.loc[:,'motif']).tolist())
      lst=[]
      for i in Motif:
        #split each group motifs into single motif which are separated by "/"
        res=(re.split('/', i))
        lst.append(res)
      #concatenate the lists within a list
      return (sum(lst, []))
      #return df2
#read_ssr2_file(file1)

# taking query file as input and attaching .ssr as attachment

query_SAT2 =input("Enter name of query SSR file: ")
query_SSR = query_SAT2 + ".ssr"
query_SAT2 = query_SAT2 + ".ssr.sat2"

Motif=read_ssr2_file(query_SAT2)

   
arr = next(os.walk('.'))[2]

def open_function(arr):
  lst2=[]
  list_i=[]
  for i in arr:
    if i.endswith(".sat2"):
      lst2.append(i)
  print(lst2)
  for i in lst2:
    r=(read_ssr2_file(i))
    list_i.extend(r)
  #print(list_i)
# create list of unique SSR motifs
  unique_in_query=[]
  for i in Motif:
    if i not in list_i:
      unique_in_query.append(i)
#printing unique ssr in a csv file  
  f = open('ssr_u.csv', 'w')
  writer = csv.writer(f)
  writer.writerow(["Motif"])
 
  for u in unique_in_query:
# here we are converting the string u into a list
    writer.writerow([u])
  f.close()
#opening the query ssr file
  with open(query_SSR,"r") as f:
    df1=pd.read_csv(f,header=0,sep="\t")
#opening the unique ssr csv file 
  with open("ssr_u.csv") as f:
    df2=pd.read_csv(f,header=0)
    df3=pd.merge(df2, df1,on="Motif")
  df4=(df3.reindex(['Name','Seq_Len','StartPos','EndPos','Repetitions','Motif'],axis=1))
  df5 = (df4.drop_duplicates())
#write the ssr file of corresponding unique motifs
  df5.to_csv('unique_ssr.tsv',sep='\t',index=False)

# ask user to choose the mode of operation (default or special)

user=input("enter mode of operation default or special : ")

#default mode : here the query file is compared with rest of the SAT2 files in the bin directory of the user 
reference_list=[]
if user == "default":
  for i in arr:
    if i != query_SAT2: reference_list.append(i)
  open_function(reference_list)

#special mode : here the query file is compared with the reference files which are entered manually by the user after taking as input the number of files to be taken as reference
lst=[]
if user == "special":
# ask user to input no of files to be entered & then names of files resp; put the names of the files in a list
  n=int(input("Enter number of SAT2 files to be entered as reference : "))
  print("now enter names of the files : ")
  for i in range(0, n) :
    ele=str(input())
    lst.append(ele)
  open_function(lst)

