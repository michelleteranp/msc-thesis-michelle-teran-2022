### Liftover hypothesis ###

# The mean node size is smaller for the genes which were lifted over.
# The mean node size is larger for genes which were not lifted over.

# How to test it:
# list lifted - find node - mean of node size

# list not lifted - find node -mean of node size
# set working directory

chr1_nodelist <- read.delim("chr1_nodelist.txt", header=FALSE)
colnames(chr1_nodelist) <- c("node_ID", "node_length")

found_graph_positions_chr1 <- read.table("found_graph_positions_chr1.txt", quote="\"", comment.char="")
colnames(found_graph_positions_chr1) <- c("node_ID")

not_found_graph_positions_chr1 <- read.table("not_found_graph_positions_chr1.txt", quote="\"", comment.char="")
colnames(not_found_graph_positions_chr1) <- c("node_ID")

lifted_chr1 <- merge(found_graph_positions_chr1, chr1_nodelist, by= "node_ID")
not_lifted_chr1 <- merge(not_found_graph_positions_chr1, chr1_nodelist, by= "node_ID")

summary(lifted_chr1$node_length)
summary(not_lifted_chr1$node_length)

# Conclusion: failed induction, which we tested by node size
# suggestion: in the graph induction do smoothing less strict 

# chr 1, set A, 6 pangenome
# list not lifted - find node -mean of node size
setwd("param_set_A")

chr1_nodelist_6pg <- read.delim("chr1_nodelist_6pg.txt", header=FALSE)
colnames(chr1_nodelist_6pg) <- c("node_ID", "node_length")

found_graph_positions_chr1_6pg <- read.table("found_graph_positions_chr1_6pg.txt", quote="\"", comment.char="")
colnames(found_graph_positions_chr1_6pg) <- c("node_ID")

not_found_graph_positions_chr1_6pg <- read.table("not_found_graph_positions_chr1_6pg.txt", quote="\"", comment.char="")
colnames(not_found_graph_positions_chr1_6pg) <- c("node_ID")

lifted_chr1_6pg <- merge(found_graph_positions_chr1_6pg, chr1_nodelist_6pg, by= "node_ID")
not_lifted_chr1_6pg <- merge(not_found_graph_positions_chr1_6pg, chr1_nodelist_6pg, by= "node_ID")

summary(lifted_chr1_6pg$node_length)
summary(not_lifted_chr1_6pg$node_length)