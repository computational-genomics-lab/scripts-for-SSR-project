import pandas as pd
import sys
dataframe1 = pd.read_csv(sys.argv[1], sep="\t", header=None)
duplicate = dataframe1.drop_duplicates()
duplicate.columns =['ID', 'motif']
# with pd.option_context('display.max_rows', None, 'display.max_columns', None):  # more options can be specified also
#     print(duplicate)
dictionary_tri = {k: list(v) for k,v in duplicate.groupby("ID")["motif"]} 
#print (dictionary_tri)
from Bio import SeqIO
dictionary_ffn={}
dictionary={}
with open(sys.argv[2]) as handle:
  for record in SeqIO.parse(handle, "fasta"):
    dictionary_ffn[record.id] = str(record.seq)
# print(dictionary_ffn)
for search_key in dictionary_tri:
    res = [val for key, val in dictionary_ffn.items() if search_key==key]
    CDS_residue=''.join(res)
    record_seq_length = len(CDS_residue)
    for tri in dictionary_tri[search_key]:
    #print(tri)
        for k in range(0, record_seq_length, 3):
            tri1=CDS_residue[k:k+3]
      #print (tri,tri1)
            if tri1 in dictionary and tri==tri1: dictionary[tri1]+=1
            elif tri1 == tri: dictionary[tri1] =1

import operator
sorted_d = dict( sorted(dictionary.items(), key=operator.itemgetter(0)))
df = pd.DataFrame.from_dict(sorted_d,  orient ='index')
print(df)

