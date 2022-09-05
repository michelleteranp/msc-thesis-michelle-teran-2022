# navigate to working directory

# import BLAST results and give correct header
# ID = subject accession version
BUSCOblast <- read.delim("BUSCOblast", header=FALSE)
headers <- c("query_accession_version", "ID", "percentage_identical_matches", "alignment_length",
             "mismatches", "gap_openings","start_aligenment_in_query","end_alignment_in_query","start_of_alignment_in_subject",
             "end_of_alignment_in_subject", "expected_value", "bit_score")
colnames(BUSCOblast) <- headers

# just the best hit - d
# unique for the subject_accession_version (ID)
unique(BUSCOblast$ID) -> unique_IDs.txt
ID <- as.character(unique_IDs.txt)

# install rtracklayer to read GFF file
library("rtracklayer")
gff <- import("45530-MA_B73_AGPv4_r36.gff3")
View(mcols(gff))
gff_df <- (as.data.frame(gff))

# extract chromosome number (ID), start position (start) from GFF file according to the ID column, only for unique IDs (4872)
gff_BUSCO_merged <- merge(gff_df, BUSCOblast, by="ID")
unique_df_B73 <- subset(gff_BUSCO_merged, !duplicated(gff_BUSCO_merged$ID))

# extract positions for each chromosome and store them in a txt file
chr1 <- subset(unique_df_B73, unique_df_B73$seqnames==1)
chr1$start
write.table(chr1$start, file="BUSCO_positions_B73_chr1.txt", sep="\n", row.names = FALSE, col.names = FALSE)
# it works

# now for chr10
chr10 <- subset(unique_df, unique_df$seqnames==10)
chr10$start
write.table(chr10$start, file="BUSCO_positions_B73_chr10.txt", sep="\n", row.names = FALSE, col.names = FALSE)

### Get start positions for Mo18 from BLAST results + GFF file ###
# import BLAST results and give correct header
# ID = subject accession version
BUSCOblast_Mo18 <- read.delim("BUSCOblast_Mo18", header=FALSE)
headers <- c("query_accession_version", "ID", "percentage_identical_matches", "alignment_length",
             "mismatches", "gap_openings","start_aligenment_in_query","end_alignment_in_query","start_of_alignment_in_subject",
             "end_of_alignment_in_subject", "expected_value", "bit_score")
colnames(BUSCOblast_Mo18) <- headers

# just the best hit - d
# unique for the subject_accession_version (ID)
unique(BUSCOblast_Mo18$ID) -> unique_IDs_Mo18.txt
ID_Mo18 <- as.character(unique_IDs_Mo18.txt)

# install rtracklayer to read GFF file
library("rtracklayer")
gff_Mo18 <- import("153432-MA_Mo18W_v1_r1.gff3")
View(mcols(gff_Mo18))
gff_df_Mo18 <- (as.data.frame(gff_Mo18))

# extract chromosome number (ID), start position (start) from GFF file according to the ID column, only for unique IDs (4854)
gff_BUSCO_merged_Mo18 <- merge(gff_df_Mo18, BUSCOblast_Mo18, by="ID")
unique_df_Mo18 <- subset(gff_BUSCO_merged_Mo18, !duplicated(gff_BUSCO_merged_Mo18$ID))

# extract positions for each chromosome and store them in a txt file
chr10_Mo18 <- subset(unique_df_Mo18, unique_df_Mo18$seqnames=="chr10")
chr10_Mo18$start
write.table(chr10_Mo18$start, file="BUSCO_positions_Mo18_chr10.txt", sep="\n", row.names = FALSE, col.names = FALSE)

chr1_Mo18 <- subset(unique_df_Mo18, unique_df_Mo18$seqnames=="chr1")
chr10_Mo1$start
write.table(chr10_Mo18$start, file="BUSCO_positions_Mo18_chr10.txt", sep="\n", row.names = FALSE, col.names = FALSE)

###
# write for loops to get the files for the 10 chromosomes in B73 and Mo18
for (i in 1:10){
chr <- subset(unique_df_B73, unique_df_B73$seqnames==(i))
write.table(chr$start, file= paste("BUSCO_positions_B73_chr",(i), ".txt", sep = ""),
            sep="\n", row.names = FALSE, col.names = FALSE)
}


# the seqnames of Mo18 are chr1, chr2...
chrlist <- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10")
for (i in chrlist){
  chr <- subset(unique_df_Mo18, unique_df_Mo18$seqnames==(i))
  write.table(chr$start, file= paste("BUSCO_positions_Mo18_",(i), ".txt", sep = ""),
              sep="\n", row.names = FALSE, col.names = FALSE)
}


# tried to add the prefix ("s/^/MA_Mo18W.1)in R. but it changes the output to character and this does not work in the following process
# this step will be done in the for loop in bash

### Get start positions for B97 from BLAST results + GFF file ###
# import BLAST results and give correct header
# ID = subject accession version
BUSCOblast_B97 <- read.delim("BUSCOblast_B97", header=FALSE)
headers <- c("query_accession_version", "ID", "percentage_identical_matches", "alignment_length",
             "mismatches", "gap_openings","start_aligenment_in_query","end_alignment_in_query","start_of_alignment_in_subject",
             "end_of_alignment_in_subject", "expected_value", "bit_score")
colnames(BUSCOblast_B97) <- headers

# just the best hit - d
# unique for the subject_accession_version (ID)
unique(BUSCOblast_B97$ID) -> unique_IDs_B97.txt
ID_B97 <- as.character(unique_IDs_B97.txt)

# install rtracklayer to read GFF file
library("rtracklayer")
gff_B97 <- import("153394-MA_B97_v1_r1.gff3")
View(mcols(gff_B97))
gff_df_B97 <- (as.data.frame(gff_B97))

# extract chromosome number (ID), start position (start) from GFF file according to the ID column, only for unique IDs (4861)
gff_BUSCO_merged_B97 <- merge(gff_df_B97, BUSCOblast_B97, by="ID")
unique_df_B97 <- subset(gff_BUSCO_merged_B97, !duplicated(gff_BUSCO_merged_B97$ID))
table(unique_df_B97$seqnames) # 4860 belong to chr1...chr10

table(unique_df_B73$seqnames)
table(unique_df_Mo18$seqnames)

# the seqnames of B97 are chr1, chr2...
chrlist <- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10")
for (i in chrlist){
  chr <- subset(unique_df_B97, unique_df_B97$seqnames==(i))
  chr_path_start <- chr[c("start")]
  chr_path_start$path <- rep(c(paste("MA_B97.1.",(i), sep = "")), times= nrow(chr_path_start))
  chr_path_start <- chr_path_start[,c('path', 'start')]
  write.table(chr_path_start, file= paste("BUSCO_positions_B97_",(i), ".txt", sep = ""),
              sep=",", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

#######################################################################################################################################################
### Generate BED file of ranges in paths to lift into the target graph ###
# navigate to working directory

# import BLAST results and give correct header
# ID = subject accession version
BUSCOblast <- read.delim("BUSCOblast", header=FALSE)
headers <- c("query_accession_version", "ID", "percentage_identical_matches", "alignment_length",
             "mismatches", "gap_openings","start_aligenment_in_query","end_alignment_in_query","start_of_alignment_in_subject",
             "end_of_alignment_in_subject", "expected_value", "bit_score")
colnames(BUSCOblast) <- headers

# just the best hit - d
# unique for the subject_accession_version (ID)
unique(BUSCOblast$ID) -> unique_IDs.txt
ID <- as.character(unique_IDs.txt)

# install rtracklayer to read GFF file
library("rtracklayer")
gff <- import("45530-MA_B73_AGPv4_r36.gff3")
View(mcols(gff))
gff_df <- (as.data.frame(gff))

# extract chromosome number (ID), start position (start) from GFF file according to the ID column, only for unique IDs (4872)
gff_BUSCO_merged <- merge(gff_df, BUSCOblast, by="ID")
unique_df_B73 <- subset(gff_BUSCO_merged, !duplicated(gff_BUSCO_merged$ID))

# extract positions for each chromosome and store them in a BED file
#chr1
chr1 <- subset(unique_df_B73, unique_df_B73$seqnames==1)
chr1_extr <- chr1[c("start","end")]
#MA_B73_v4.1.chr1
chr1_extr$path <- rep(c("MA_B73_v4.1.chr1"), times= nrow(chr1_extr))
chr1_extr <- chr1_extr[c('path','start','end')]
bed <- chr1_extr[,c("path", "start", "end")]
write.table(bed, "B73_chr1.bed",row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

### end B73 ###

# import BLAST results and give correct header
# ID = subject accession version
BUSCOblast_Mo18 <- read.delim("BUSCOblast_Mo18", header=FALSE)
headers <- c("query_accession_version", "ID", "percentage_identical_matches", "alignment_length",
             "mismatches", "gap_openings","start_aligenment_in_query","end_alignment_in_query","start_of_alignment_in_subject",
             "end_of_alignment_in_subject", "expected_value", "bit_score")
colnames(BUSCOblast_Mo18) <- headers

# just the best hit - d
# unique for the subject_accession_version (ID)
unique(BUSCOblast_Mo18$ID) -> unique_IDs_Mo18.txt
ID_Mo18 <- as.character(unique_IDs_Mo18.txt)

# install rtracklayer to read GFF file
library("rtracklayer")
gff_Mo18 <- import("153432-MA_Mo18W_v1_r1.gff3")
View(mcols(gff_Mo18))
gff_df_Mo18 <- (as.data.frame(gff_Mo18))

# extract chromosome number (ID), start position (start) from GFF file according to the ID column, only for unique IDs (4854)
gff_BUSCO_merged_Mo18 <- merge(gff_df_Mo18, BUSCOblast_Mo18, by="ID")
unique_df_Mo18 <- subset(gff_BUSCO_merged_Mo18, !duplicated(gff_BUSCO_merged_Mo18$ID))

chr1_Mo18W <- subset(unique_df_Mo18, unique_df_Mo18$seqnames=="chr1")
chr1_Mo18W_extr <- chr1_Mo18W[c("start","end")]
#MA_Mo18W.1.chr1
chr1_Mo18W_extr$path <- rep(c("MA_Mo18W.1.chr1"), times= nrow(chr1_Mo18W_extr))
bed_Mo18W_chr1 <- chr1_Mo18W_extr[,c("path", "start", "end")]
write.table(bed_Mo18W_chr1, "Mo18W_chr1.bed",row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")


############################################################################################################################################################################
# for loop to create files all chromosomes B73
for (i in 1:10){
  chr <- subset(unique_df_B73, unique_df_B73$seqnames==(i))
  chr_start_end <- chr[c("start","end")]
  chr_start_end$path <- rep(c(paste("MA_B73_v4.1.","chr",(i),sep = "")), times= nrow(chr_start_end))
  chr_start_end <- chr_start_end[,c('path','start','end')]
  write.table(chr_start_end, file= paste("BUSCO_positions_BED_B73_chr",(i),".bed",sep =""), row.names = FALSE, col.names = FALSE,  quote = FALSE, sep = "\t")
}

# for loop to create files all chromosomes Mo18W
# the seqnames of Mo18 are chr1, chr2...chrlist <- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10")
chrlist <- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10")
for (i in chrlist){
  chr <- subset(unique_df_Mo18, unique_df_Mo18$seqnames==(i))
  chr_start_end <- chr[c("start","end")]
  chr_start_end$path <- rep(c(paste("MA_Mo18W.1.",(i),sep = "")), times= nrow(chr_start_end))
  chr_start_end <- chr_start_end[,c('path','start','end')]
  write.table(chr_start_end, file= paste("BUSCO_positions_BED_Mo18W_",(i),".bed",sep =""), row.names = FALSE, col.names = FALSE,  quote = FALSE, sep = "\t")
}

# Files stored in BUSCO_positions_Mo18W_BED and BUSCO_positions_B73_BED folders in /michelle/blast
# Liftover process go to BLASTbusco.sh
table(unique_df_B73$seqnames)
table(unique_df_Mo18$seqnames)
