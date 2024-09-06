#!/bin/bash

for i in *rxlr.gff; do
# Input BED file
input_file=$i

# Process the input file and modify it inline
awk '{
    if ($4 > $5) {
        temp = $4;
        $4 = $5;
        $5 = temp;
    }
    print $0;
}' "$input_file" > temp.bed && mv temp.bed "$input_file"

done
