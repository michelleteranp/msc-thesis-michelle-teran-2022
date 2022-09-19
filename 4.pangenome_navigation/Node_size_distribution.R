### Plot node size distribution ###
# set working directory

# import chr10 node distribution files from the different parameter sets
files <- list.files()
names <- strsplit(files, "\\.")

for (i in 1:length(files)) {
  fileName <- files[[i]]
  dataName <- names[[i]][[1]]
  tempData <- read.delim(fileName, header = F, col.names = c("node_ID","node_length"))
  assign (dataName, tempData, envir = .GlobalEnv)
}


# get the ranges of node length of the sets
range(node_distribution_chr10_set_A$node_length)
range(node_distribution_chr10_set_E$node_length)
range(node_distribution_chr10_set_J$node_length)
# the ranges are large,now visualize...

# plot the distribution of node length 
freq_A <- as.table(node_distribution_chr10_set_A$node_length)
hist(freq_A)

hist(node_distribution_chr10_set_A$node_length)
summary - not transformed data

boxplot(log10(node_distribution_chr10_set_A$node_length), breaks = 100)


hist(log10(node_distribution_chr10_set_A$node_length))
hist(log10(node_distribution_chr10_set_H2$node_length))
summary(node_distribution_chr10_set_A$node_length)
summary(node_distribution_chr10_set_H2$node_length)

boxplot(node_distribution_chr10_set_B$node_length)
boxplot(node_distribution_chr10_set_C$node_length)
boxplot(node_distribution_chr10_set_D$node_length)

breakvec <- seq(1, 348000, by = 29000)
breakvec <- seq(1, 400000, by= 50000)
hist(node_distribution_chr10_set_A$node_length,breaks = breakvec, xlim = c(1,346599), freq = T)

install.packages("ggplot2")
library(ggplot2)

ggplot(node_distribution_chr10_set_A, aes(x=node_length)) +
  geom_histogram(binwidth = .5, colour="black", fill="white")

# playground to explore why the graph looks like that = the range is so large!
mich  <- c(4,4,4,4,4,4,4,4,1,2,3,2,2,2,200,200,200)
hist(table(mich))
boxplot(table(mich))
boxplot(mich)

hist(mich, breaks = 2, freq = T)
boxplot(mich)
plot(mich)
dev.off()
