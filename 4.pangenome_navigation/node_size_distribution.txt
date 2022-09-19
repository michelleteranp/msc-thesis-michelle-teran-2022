### Distribution of node size in the parameter sets of B73_Mo18_pangenome ###
# navigate to working directory
# run conda

# 13 sets: A B C D E F G H2 H3 H I J K 
# navigate to working directory
odgi view -i chr10.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}' > node_distribution_chr10_set_K.txt

# Node_size_distribution.R