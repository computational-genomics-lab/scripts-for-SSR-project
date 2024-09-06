def parse_fasta_to_gff(fasta_file, gff_file):
    with open(fasta_file, 'r') as fasta, open(gff_file, 'w') as gff:
        for line in fasta:
            if line.startswith('>'):
                # Parse the header line
                parts = line[1:].split(' ')
                
                # Split by "_" to extract sequence ID and RXLR identifier
                seq_info = parts[0].split('_')
                seq_id = seq_info[0]
                rxlr_id = f"RXLR{seq_info[1]}"
                
                # Extract start and end positions
                #positions = parts[3]
                start = parts[1].strip('[')
                end = parts[3].strip(']')
                
                #print(start, end)
                # Determine strand
                strand = '-' if '(REVERSE SENSE)' in line else '+'
                
                # Generate the GFF line
                gff_line = f"{seq_id}\tGenbank\tgene\t{start}\t{end}\t.\t{strand}\t.\tID={rxlr_id};name={rxlr_id};product={rxlr_id}\n"
                gff.write(gff_line)

# Usage
fasta_file = 'Phymel_WB_scaffolded_orf_translated.fna'  # Replace with your FASTA file name
gff_file = 'output.gff'     # Replace with your desired GFF output file name
parse_fasta_to_gff(fasta_file, gff_file)

