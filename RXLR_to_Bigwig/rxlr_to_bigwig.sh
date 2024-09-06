for i in *_rxlr.gff; do
    
    sed -i "s/ /\t/g" $i
    b=`basename $i _rxlr.gff`

    python3 gff_bedgraph.py $i

       
    # Remove overlaps in positive strand BedGraph and sort it
    awk '{
        if (NR == 1) {prev_start=$2; prev_end=$3; print $0}
        else {
            if ($2 >= prev_end) {
                prev_start=$2; prev_end=$3; print $0
            }
        }
    }' output.bedgraph | sort -k1,1 -k2,2n > output_sorted.bedgraph


    bedGraphToBigWig output_sorted.bedgraph $b.size "$b"_rxlr.bw


done
