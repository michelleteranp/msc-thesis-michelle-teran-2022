# Average node length of subgraphs resulting from the extraction process #
# set working directory

ZmCCT_nodelist <- read.delim("ZmCCT_nodelist.txt", header=FALSE)
colnames(ZmCCT_nodelist) <- c("node_id", "node_length")
summary(ZmCCT_nodelist$node_length)

C1_nodelist <- read.delim("C1_nodelist.txt", header=FALSE)
colnames(C1_nodelist) <- c("node_id", "node_length")
summary(C1_nodelist$node_length)

RLK1_nodelist <- read.delim("RLK1_nodelist.txt", header=FALSE)
colnames(RLK1_nodelist) <- c("node_id", "node_length")
summary(RLK1_nodelist$node_length)

# total bp = sum node_length
sum(ZmCCT_nodelist$node_length) #5621       #4,645 -> region I wanted
sum(C1_nodelist$node_length)    #10,579     #3,273  -> region I wanted
sum(RLK1_nodelist$node_length)  #919,581    #12,760  -> region I wanted

# ZmCCT -> ATG found in node 8810032!