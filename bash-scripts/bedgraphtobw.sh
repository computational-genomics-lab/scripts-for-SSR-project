for file in *.fna.ssr; do
        b=`basename $file .fna.ssr`
        sed '1d' $b.fna.ssr > tmp
        sed 's/^>//g' tmp > tmp1
        awk '{print $1 "\t" $3 "\t" $4 "\t" $5}' tmp1 > myFile.bedgraph
        sort -k1,1 -k2,2n myFile.bedgraph > myFile_sorted.bedgraph
        samtools faidx $b.fna
        cut -f1,2 $b.fna.fai > $b.size
        bedGraphToBigWig myFile_sorted.bedgraph $b.size $b.bw
done
