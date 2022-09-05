### List of node information ###
# run conda
conda activate odgi
# navigate to working directory

# Get a list with the length, degree, depth for each node.

# length, this creates a table with node id and length
odgi view -i chr10.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}' > chr10_setA_length.txt

# depth, this creates a table with node.id, depth and depth.uniq.
odgi depth -i chr10.og -d > chr10_setA_depth.txt

# degree, this creates a table with node.id, degree, and degree.uniq.
odgi degree -i chr10.og -d > chr10_setA_degree.txt
less chr10_setA_degree.txt