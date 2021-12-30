for i in *.gff;do
#awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t"}' Phyra_CC1011.gff > tmp.gff
b=`basename $i .gff`
#echo $b
gt gff3 -sortlines -tidy -retainids $b.gff > $b.sorted.gff
bgzip $b.sorted.gff
tabix $b.sorted.gff.gz
done
