### Finding BUSCO (Benchmarking Universal Single-Copy Orthologs) genes in the pangenome ###
# navigate to working directory


### BLASTP poales data set against B73AGPv04, Mo18W and B97 ###
# navigate to working directory

conda install busco
conda install blast
conda activate busco

busco --list-datasets
# download poales data set
busco --download "poales_odb10"

conda activate blast
tar zxvpf ncbi-blast-2.13.0+-x64-linux.tar.gz
tar -xf odgi-0.7.2-py36hcac48a8_1.tar.bz2 -C /michelle

# BLASTP B73AGPv04
#make db
makeblastdb -in 151374-MA_B73_AGPv4_r36_protein.fasta -dbtype prot -title MA_B73_AGPv4 -out MA_B73_AGPv4_r36
#check db
blastdbcmd -db MA_B73_AGPv4_r36 -info
#blast
blastp -db MA_B73_AGPv4_r36 -query /michelle/blast/poales_odb10.2020-08-05/poales_odb10/ancestral -max_target_seqs 1 -outfmt 6 -out BUSCOblast -num_threads 2
#check output
BUSCOblast less
nano BUSCOblast

# BLASTP Mo18W
# make db based on Mo18W file MA_Mo18W_v1_r1_protein.fasta
makeblastdb -in /MA_Mo18W_v1_r1_protein.fasta -dbtype prot -title MA_Mo18W_v1 -out MA_Mo18W_v1
# check db
blastdbcmd -db MA_Mo18W_v1 -info
# blast
blastp -db MA_Mo18W_v1 -query //michelle/blast/poales_odb10.2020-08-05/poales_odb10/ancestral -max_target_seqs 1 -outfmt 6 -out BUSCOblast_Mo18 -num_threads 2
# check output
less BUSCOblast_Mo18

# BLASTP B97
# make db based on Mo18W file MA_B97_v1_r1_protein.fasta
makeblastdb -in /MA_B97_v1_r1_protein.fasta -dbtype prot -title MA_B97_v1 -out MA_B97_v1
# check db
blastdbcmd -db MA_B97_v1 -info
# blast
blastp -db MA_B97_v1 -query /michelle/blast/poales_odb10.2020-08-05/poales_odb10/ancestral -max_target_seqs 1 -outfmt 6 -out BUSCOblast_B97 -num_threads 2

### Get start positions from GFF file based on unique IDs from the BUSCOblast file ###
# This process is developed in the R script -> BUSCOstart.R
# When the files with start positions are available, run for loop.

### For loop to find BUSCO genes in the pangenome (BUSCO start positions are specified in .txt files ###
# B73
# navigate to working directory
# run conda
conda activate odgi

chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
sed "s/^/MA_B73_v4.1."$i",/" -i BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt
odgi position -i ogFiles/"$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -r MA_Mo18W.1."$i" > path_position_results_B73_"$i".txt
odgi position -i ogFiles/"$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -v > graph_position_results_B73_"$i".txt
pathcount=$(cat BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt | wc -l)
pathresults=$(cat path_position_results_B73_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B73_"$i".txt | wc -l)
echo "Input BUSCOs in B73 "$i": $pathcount. Path position results in Mo18W: $((pathresults/2)). Graph position results: $((graphresults/2))."
done

# Mo18W
# navigate to working directory
# run conda
conda activate odgi

chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
sed "s/^/MA_Mo18W.1."$i",/" -i BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt
odgi position -i ogFiles/"$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -r MA_B73_v4.1."$i" > path_position_results_Mo18_"$i".txt
odgi position -i ogFiles/"$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -v > graph_position_results_Mo18_"$i".txt
pathcount=$(cat BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt | wc -l)
pathresults=$(cat path_position_results_Mo18_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_Mo18_"$i".txt | wc -l)
echo "Input BUSCOs in Mo18 "$i": $pathcount. Path position results in B73: $((pathresults/2)). Graph position results: $((graphresults/2))."
done

# Get lists of found and not found positions (for verification)
grep -f BUSCO_positions_B73/BUSCO_positions_B73_chr2.txt path_position_results_B73_chr2.txt  > found.txt
cat found.txt | wc -l # 303, same as counted before in the for loop.
sed 's/,+.*//' found.txt > found_positions.txt # only positions
grep -v -f found_positions.txt BUSCO_positions_B73/BUSCO_positions_B73_chr2.txt > not_found.txt
cat not_found.txt | wc -l # 227, confirmed results 530-303 = 227

### Check if the change of parameters affects the % of lift-over ###
# Pangenomes with different parameter sets were generated (see pangenome_construction folder)
# After constructing these pangenomes, the BUSCO approach was used as a tool to evaluate the resulting pangenomes.
# navigate to working directory

# Example for parameter_set_K
# copy sets of positions to the folder containing the og files
cp -r /michelle/B73_Mo18_parameter_sets/param_set_K
cp -r /michelle/B73_Mo18_parameter_sets/param_set_K

# navigate to working directory
# run conda
conda activate odgi

# B73
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -r MA_Mo18W.1."$i" > path_position_results_B73_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -v > graph_position_results_B73_"$i".txt
pathcount=$(cat BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt | wc -l)
pathresults=$(cat path_position_results_B73_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B73_"$i".txt | wc -l)
echo "Input BUSCOs in B73 "$i": $pathcount. Path position results in Mo18W: $((pathresults/2)). Graph position results: $((graphresults/2))."
done

# Mo18W
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -r MA_B73_v4.1."$i" > path_position_results_Mo18_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -v > graph_position_results_Mo18_"$i".txt
pathcount=$(cat BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt | wc -l)
pathresults=$(cat path_position_results_Mo18_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_Mo18_"$i".txt | wc -l)
echo "Input BUSCOs in Mo18 "$i": $pathcount. Path position results in B73: $((pathresults/2)). Graph position results: $((graphresults/2))."
done

# BUSCOs in ancestral poales file: 	4896
# BLAST results B73: 	5179 //	4872 (unique IDs) -> 99.51% of the BUSCOs present in the poales dataset
# BLAST results Mo18: 5163 // 4854 (unique IDs) -> 99.14% of the BUSCOs present in the poales dataset
# BLAST results B97: 	5157 // 4861 (unique IDs) -> 99.29% of the BUSCOs present in the poales dataset
####################################################################################################################################################################################
### Check if there are changes in the results of the BUSCO approach when the search of genes is not based in start positions but in start/end positions specified in a .bed file ###
# odgi position with BED file
# navigate to working directory
# run conda
conda activate odgi

# Generate BED file -> BUSCOstart.R
# B73 chr1
less B73_chr1.bed

odgi position -i ogFiles/chr1.og -b B73_chr1.bed -r MA_Mo18W.1.chr1 > path_position_results_B73_BED.txt
cat path_position_results_B73_BED.txt | wc -l # 549, it works! -10 positions compared to the process with start positions only
cat path_position_results_B73_chr1.txt | wc -l #1118/2 = 559 (divided by 2 because here the output prints header for every position)

odgi position -i ogFiles/chr1.og -b B73_chr1.bed -v > graph_position_results_B73_BED.txt 
cat graph_position_results_B73_BED.txt | wc -l #864, it works! same result obtained with start positions only
cat graph_position_results_B73_chr1.txt | wc -l #1728/2 = 864 (divided by 2 because here the output prints header for every position)

# using a BED file as input, the output does not print headers
path_position_results_B73_BED.txt #549
path_position_results_B73_chr1.txt #559
graph_position_results_B73_BED.txt #864
graph_position_results_B73_chr1.txt #864

#Mo18W chr1
less Mo18W_chr1.bed

odgi position -i ogFiles/chr1.og -b Mo18W_chr1.bed -r MA_B73_v4.1.chr1 > path_position_results_Mo18W_BED.txt
cat path_position_results_Mo18W_BED.txt | wc -l #544 -13 positions compared to process with start positions only
cat path_position_results_Mo18_chr1.txt | wc -l #1114/2 = 557

odgi position -i ogFiles/chr1.og -b Mo18W_chr1.bed -v > graph_position_results_Mo18W_BED.txt
cat graph_position_results_Mo18W_BED.txt | wc -l #869
cat graph_position_results_Mo18_chr1.txt | wc -l #1738/2 = 869

# Conclusion: results obtained with odgi position based on BED files were comparable to those obtained with odgi position and files with start positions.

### Lift-over calculation for all parameter sets with 2 genomes B73 and Mo18W with a for loop (BUSCOs start/end positions are specified in a .bed file) ###
# navigate to working directory
# run conda
conda activate odgi

# B73
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -b BUSCO_positions_B73_BED/BUSCO_positions_BED_B73_"$i".bed -r MA_Mo18W.1."$i" > path_position_results_B73_BED_"$i".txt
odgi position -i "$i".og -b BUSCO_positions_B73_BED/BUSCO_positions_BED_B73_"$i".bed -v > graph_position_results_B73_BED_"$i".txt
pathcount=$(cat BUSCO_positions_B73_BED/BUSCO_positions_BED_B73_"$i".bed | wc -l)
pathresults=$(cat path_position_results_B73_BED_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B73_BED_"$i".txt | wc -l)
echo "Input BUSCOs in B73_BED "$i": $pathcount. Path position results in Mo18W: $pathresults. Graph position results: $graphresults." >> liftover_B73_BED.txt
done

# Mo18
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -b BUSCO_positions_Mo18W_BED/BUSCO_positions_BED_Mo18W_"$i".bed -r MA_B73_v4.1."$i" > path_position_results_Mo18_BED_"$i".txt
odgi position -i "$i".og -b BUSCO_positions_Mo18W_BED/BUSCO_positions_BED_Mo18W_"$i".bed -v > graph_position_results_Mo18_BED_"$i".txt
pathcount=$(cat BUSCO_positions_Mo18W_BED/BUSCO_positions_BED_Mo18W_"$i".bed | wc -l)
pathresults=$(cat path_position_results_Mo18_BED_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_Mo18_BED_"$i".txt | wc -l)
echo "Input BUSCOs in Mo18W_BED "$i": $pathcount. Path position results in B73: $pathresults. Graph position results: $graphresults." >> lifotver_Mo18W_BED.txt
done

###################################################################################################################################################################
# Lift-over calculation for pangenome with 6 genomes (sets: param_set_A, param_set_D, param_set_H2. Based on BUSCOs start positions)
# navigate to working directory
# run conda
conda activate odgi

### direction B73 - Mo18W
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -r MA_Mo18W.1."$i" > path_position_results_B73_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -v > graph_position_results_B73_"$i".txt
pathcount=$(cat BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt | wc -l)
pathresults=$(cat path_position_results_B73_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B73_"$i".txt | wc -l)
echo "Input BUSCOs in B73 "$i": $pathcount. Path position results in Mo18W: $((pathresults/2)). Graph position results: $((graphresults/2))." >> liftover_B73.txt
done

chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -r MA_B73_v4.1."$i" > path_position_results_Mo18_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt -v > graph_position_results_Mo18_"$i".txt
pathcount=$(cat BUSCO_positions_Mo18/BUSCO_positions_Mo18_"$i".txt | wc -l)
pathresults=$(cat path_position_results_Mo18_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_Mo18_"$i".txt | wc -l)
echo "Input BUSCOs in Mo18W "$i": $pathcount. Path position results in B73: $((pathresults/2)). Graph position results: $((graphresults/2))." >> liftover_Mo18W.txt
done


# navigate to working directory
# run conda
conda activate odgi

### direction B73 - B97
chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -r MA_B97.1."$i" > path_position_results_B73_B97_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt -v > graph_position_results_B73_B97_"$i".txt
pathcount=$(cat BUSCO_positions_B73/BUSCO_positions_B73_"$i".txt | wc -l)
pathresults=$(cat path_position_results_B73_B97_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B73_B97_"$i".txt | wc -l)
echo "Input BUSCOs in B73 "$i": $pathcount. Path position results in B97: $((pathresults/2)). Graph position results: $((graphresults/2))." >> liftover_B73_B97.txt
done

chr=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10)
for i in "${chr[@]}"
do
odgi position -i "$i".og -F BUSCO_positions_B97/BUSCO_positions_B97_"$i".txt -r MA_B73_v4.1."$i" > path_position_results_B97_"$i".txt
odgi position -i "$i".og -F BUSCO_positions_B97/BUSCO_positions_B97_"$i".txt -v > graph_position_results_B97_"$i".txt
pathcount=$(cat BUSCO_positions_B97/BUSCO_positions_B97_"$i".txt | wc -l)
pathresults=$(cat path_position_results_B97_"$i".txt | wc -l)
graphresults=$(cat graph_position_results_B97_"$i".txt | wc -l)
echo "Input BUSCOs in B97 "$i": $pathcount. Path position results in B73: $((pathresults/2)). Graph position results: $((graphresults/2))." >> liftover_B97_B73.txt
done

### end of BUSCO approach ###

### Generate statics summary for chromosome 10 of the different param_sets with odgi ###
# statistics include: length, number of nodes, number of edges
# run conda
conda activate odgi

# navigate to working directory

cd ..
cd param_set_F
odgi stats -i chr10.og -S