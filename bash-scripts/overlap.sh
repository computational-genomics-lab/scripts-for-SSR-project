for i in *-bedintersect_result; do
b=`basename $i -bedintersect_result`	
sed 's/ID=//g' $i | sed 's/;/\t/g' | sed 's/gene-/\t/g' | awk '{
if ($8=="gene" && length($5)==3)
	{
	print $14, $5;
}
OFS="\t"
}' > $b.tri_gene.txt
done
