# set working directory
library("writexl")
library("stringr")

#### gtcheck comparisons ###
#### gtcheck performed in hapmap with 5 samples ####
# all vs all
check_e0_s5 <- read.delim("allvsall_gtcheck_e0_s5.txt", header=FALSE, comment.char="#")
gtcheck_allvsall_s5 <- check_e0_s5[,-1]
gtcheck_allgenotypes_s5 <- gtcheck_allvsall_s5[,-4]
header_gt <- c('query_sample','genotyped_sample','discordance','number_of_sites_compared')
colnames(gtcheck_allgenotypes_s5) <- header_gt

write_xlsx(gtcheck_allgenotypes_s5,"gtcheck_allvsall_s5.xlsx")

# pairs check
pairs_check_s5 <- read.delim("pairs_gtcheck_e0_s5.txt", header=FALSE, comment.char="#")
gtcheck_p_s5 <- pairs_check_s5[,-1]
gtcheck_pairs_s5 <- gtcheck_p_s5[,-4]
colnames(gtcheck_pairs_s5) <- header_gt

write_xlsx(gtcheck_pairs_s5,"gtcheck_pairs_s5.xlsx")

#### gtcheck performed in hapmap with 26 samples ####
# all vs all
check_e0 <- read.delim("allvsall_gtcheck_e0.txt", header=FALSE, comment.char="#")
gtcheck_allvsall <- check_e0[,-1]
gtcheck_allgenotypes <- gtcheck_allvsall[,-4]
header_gt <- c('query_sample','genotyped_sample','discordance','number_of_sites_compared')
colnames(gtcheck_allgenotypes) <- header_gt

write_xlsx(gtcheck_allgenotypes,"gtcheck_allvsall.xlsx")

# pairs check
pairs_check <- read.delim("pairs_gtcheck_e0.txt", header=FALSE, comment.char="#")
gtcheck_p <- pairs_check[,-1]
gtcheck_pairs <- gtcheck_p[,-4]
colnames(gtcheck_pairs) <- header_gt

write_xlsx(gtcheck_pairs,"gtcheck_pairs.xlsx")

### why don't we have more overlap in the gtcheck? 
#### overlap? hapmap with 5 samples ####
# subset of chr1, positions 1'000.000 - 1'001.000 in hapmap and 6pg files
hapmap_1000_s5 <- read.table("hapmap_1000_s5.txt", quote="\"")
headers_hapmap_s5 <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","B97","CML52","HP301","Il14H","Mo18W")
colnames(hapmap_1000_s5) <- headers_hapmap_s5

pangenome_1000 <- read.table("6pangenome_1000.txt", quote="\"")
headers_6pg <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","B97","CML52","HP301","Il14H","Mo18W")
colnames(pangenome_1000) <- headers_6pg

# hapmap 10 positions
# pangenome 12 positions
table(pangenome_1000$POS %in% hapmap_1000_s5$POS) #9/12 are the same positions, pangenome has 3 more.

#### import IDs of SNPs in hapmap with 5 samples and pangenome ####
### chr1
SNPs_hapmap_chr1 <- read.table("SNPs_hapmap_chr1.txt", header=TRUE, quote="\"")
SNPs_pangenome_chr1 <- read.table("SNPs_pangenome_chr1.txt", header=TRUE, quote="\"")

table(SNPs_pangenome_chr1$ID %in% SNPs_hapmap_chr1$ID)
# 1,471,959 from the pangenome are also in the hapmap, 3,448,382 are only in the pangenome file.

###chr10
SNPs_hapmap_chr10 <- read.table("SNPs_hapmap_chr10.txt", header=TRUE, quote="\"")
SNPs_pangenome_chr10 <- read.table("SNPs_pangenome_chr10.txt", header=TRUE, quote="\"")

table(SNPs_pangenome_chr10$ID %in% SNPs_hapmap_chr10$ID)
#  656,396 from the pangenome are also in the hapmap,  1,551,335 are only in the pangenome file.




#### overlap? hapmap with 26 samples ####
# subset of chr1, positions 1'000.000 - 1'001.000 in hapmap and 6pg files
hapmap_1000 <- read.table("hapmap_1000.txt", quote="\"")
headers_hapmap <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT", "B73",
                    "B97","CML52","CML69","CML103","CML228","CML247","CML277","CML322","CML333",
                    "HP301","Il14H","KI3","Ki11","Ky21","M37W", "M162W","Mo18W","Ms71","NC350","NC358",
                    "Oh7B","Oh43","P39","Tx303","Tzi8")
colnames(hapmap_1000) <- headers_hapmap

pangenome_1000 <- read.table("6pangenome_1000.txt", quote="\"")
headers_6pg <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","B97","CML52","HP301","Il14H","Mo18W")
colnames(pangenome_1000) <- headers_6pg

# hapmap 15 positions
# pangenome 12 positions
table(hapmap_1000$POS %in% pangenome_1000$POS) #9/15 are the same positions

#### INDELS ####                 
# Indel distribution 6pg
indel_distribution_exclist <- read.delim("/indel_distribution_exclist.txt", header=FALSE, comment.char="#")
headers_idd <- c("IDD", "id", "length", "number_of_sites", "number_of_genotypes", "mean_VAF")
# length (deletions are negative)
colnames(indel_distribution_exclist) <- headers_idd
summary(indel_distribution_exclist$length)
plot(indel_distribution_exclist$number_of_sites)
sum(indel_distribution_exclist$number_of_sites)

#### file with all indels pangenome ####
indels_pangenome <- read.table("/indels_pangenome.txt", quote="\"")
colnames(indels_pangenome) <- c("CHROM", "POS", "REF", "ALT")
indels_pangenome$length_REF <- str_length(indels_pangenome$REF)                
indels_pangenome$length_ALT <- str_length(indels_pangenome$ALT)
indels_pangenome$indel_length <- (indels_pangenome$length_ALT - indels_pangenome$length_REF)

large_indels_pg <- subset(indels_pangenome, indels_pangenome$indel_length > 100)
summary(large_indels_pg$indel_length)

hist(log10(indels_pangenome$indel_length))

# number of large indels in each chr
table(large_indels_pg$CHROM)

# absolute value of indel length and summarize it in a table
indels_pangenome$indel_length_abs <- abs(indels_pangenome$indel_length)
summary(indels_pangenome$indel_length_abs)

indels_summary <- data.frame(category=c("1-10","11-100","101-1000","1001-10000","> 10001"))

indels_summary[1,2] <- (sum(indels_pangenome$indel_length_abs >= 0 & indels_pangenome$indel_length_abs <= 10))
indels_summary[2,2] <- sum(indels_pangenome$indel_length_abs >= 11 & indels_pangenome$indel_length_abs <= 100)
indels_summary[3,2] <- sum(indels_pangenome$indel_length_abs >= 101 & indels_pangenome$indel_length_abs <= 1000)
indels_summary[4,2] <- sum(indels_pangenome$indel_length_abs >= 1001 & indels_pangenome$indel_length_abs <= 10000)
indels_summary[5,2] <- sum(indels_pangenome$indel_length_abs >= 10001)
colnames(indels_summary) <- c("category", "count")
sum(indels_summary$count) == nrow(indels_pangenome)

# get a list of the largest indels
indels_larger10k <- indels_pangenome[indels_pangenome$indel_length_abs >= 10001,]

write_xlsx(indels_summary,"indels_summary.xlsx")
