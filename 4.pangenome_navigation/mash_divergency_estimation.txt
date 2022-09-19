### Mash divergency estimation ###

# run conda
conda activate odgi
conda env list

# simple distance estimation
mash dist inFasta/B73_v4.fasta inFasta/Mo18W.fasta 
# The results are tab delimited lists of Reference-ID, Query-ID, Mash-distance, P-value, and Matching-hashes
# inFasta/B73_v4.fasta	inFasta/Mo18W.fasta	0.0172424	0	534/1000

# submit job to calculate mash triangle via mash_triangle.sh script
bsub -o mashtriangle_results.txt -e mashtriangle.err "sh mash_triangle.sh splits/chr1.fasta"
