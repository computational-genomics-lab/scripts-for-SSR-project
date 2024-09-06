import sys

args = sys.argv

def gff_to_bedgraph(gff_file, bedgraph_file):
    with open(gff_file, 'r') as gff, open(bedgraph_file, 'w') as bedgraph:
        for line in gff:
            if line.startswith("#") or not line.strip():
                continue  # Skip comments or empty lines and reverse strands
            
            parts = line.strip().split('\t')
            #print(parts)
            chrom = parts[0]
            start = int(parts[3]) - 1  # Convert 1-based GFF start to 0-based for BedGraph
            end = int(parts[4])        # End is already exclusive in GFF
            strand = parts[6]
            
            # Assign a value based on strand (can be customized)
            #value = 1 if strand == '+' else -1  # Positive for '+' strand, negative for '-'
            value = end - start

            # Write the BedGraph entry
            bedgraph.write(f"{chrom}\t{start}\t{end}\t{value}\n")

# Usage
#gff_file = 'Phymel_WB_scaffolded_rxlr.gff'  # Replace with your GFF file
bedgraph_file = 'output.bedgraph'  # Replace with your desired BedGraph file
gff_to_bedgraph(args[1], bedgraph_file)

