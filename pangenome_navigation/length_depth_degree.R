### Length, depth and degree for each node ###
# set working directory

chr10_setA_length <- read.delim("chr10_setA_length.txt",
                               header=FALSE, col.names = c("node_id", "length"))

chr10_setA_depth <- read.delim("chr10_setA_depth.txt",
                               header=FALSE, col.names = c("node_id", "depth", "depth.uniq"), comment.char = "#")

chr10_setA_degree <- read.delim("chr10_setA_degree.txt",
                                header=FALSE, col.names = c("node_id", "degree"), comment.char = "#")

chr10_setA_node_info <- merge(chr10_setA_length, chr10_setA_depth, by= "node_id")
chr10_setA_node_info  <- merge(chr10_setA_node_info, chr10_setA_degree, by= "node_id")

# depth and depth.uniq look similar, are they identical? 
identical(chr10_setA_node_info$depth, chr10_setA_node_info$depth.uniq) #No

# check degree
range(chr10_setA_node_info$degree)
nrow(chr10_setA_node_info[which(chr10_setA_node_info$degree > 4), ])*100/nrow(chr10_setA_node_info) #1.19% of the observations have a degree >4
chr10_setA_node_info[which(chr10_setA_node_info$degree == 14), ] # 1 observation has a degree of 14 


