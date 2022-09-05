### Explore node IDs ###
# set working directory

# import node list for whole chromosome 8 small_NAM_pangenome
chr8_nodelist <- read.delim("chr8_nodelist.txt", header=FALSE)
colnames(chr8_nodelist) <- c("node_ID","node_length")
# import node list for RLK1 extracted region
RLK1_nodelist <- read.delim("RLK1_nodelist.txt", header=FALSE)
colnames(RLK1_nodelist) <- c("node_ID","node_length")


summary(chr8_nodelist$node_ID)
summary(chr8_nodelist$node_length)

summary(RLK1_nodelist$node_ID)
summary(RLK1_nodelist$node_length)

plot(sort(chr8_nodelist$node_ID))
boxplot(sort(chr8_nodelist$node_length))

plot(sort(RLK1_nodelist$node_ID))
head(RLK1_nodelist$node_ID)
is.ordered(RLK1_nodelist$node_ID)

#are the numbers in this vector consecutive? YES.
max(RLK1_nodelist$node_ID)-min(RLK1_nodelist$node_ID)

test_vector = seq(11549165, 11568253, by=1)
RLK1_sorted <- (sort(RLK1_nodelist$node_ID))

table(test_vector == RLK1_sorted)

intersect <- intersect(test_vector, RLK1_sorted)





