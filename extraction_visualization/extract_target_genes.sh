### Extract region of target genes ###
# navigate to working directory
# run conda
conda activate odgi

odgi viz -i chr1.og -o chr1viz.png -x 500

### Extraction process in chr1.og with different options of odgi extract ###
# navigate to working directory
# chr1.og from Stefan's pangenome files

### explore the file 
odgi stats -i chr1.og -S
# length nodes   edges   paths
# 448318460       6759947 9215902 2

odgi paths -i chr1.og -L
#MA_B73.1.chr1
#MA_5G7601.1.chr1

odgi paths -i chr1.og -L -l 
# -L -l list            path start      and end
# MA_B73.1.chr1             1           307041717
# MA_5G7601.1.chr1          1           305905078

odgi stats -i chr1.og -b
# -b describes the base content of the graph
#A       117214409
#C       105224750
#G       105077988
#N       3688293
#T       117113020

odgi stats -i chr1.og -s -p
#sum_of_path_node_distances
#path                  in_node_space   in_nucleotide_space     nodes       nucleotides     num_penalties
#MA_B73.1.chr1          23.89           24.2672                 4662628     307041717       436611
#MA_5G7601.1.chr1       33.0535         34.284                  4716211     305905078       437501
#all_paths              28.4979         29.2663                 9378839     612946795       874112

# extract a node by ID
odgi extract -n 20 -i chr1.og -c 1 -o node_20_extracted.og
-c, --context-steps=N
The number of steps (nodes) N away from our initial subgraph that we should collect.

odgi stats -i node_20_extracted.og -S
#length nodes   edges   paths
85      3       2       3

odgi paths -i node_20_extracted.og -L
#MA_B73.1.chr1:18888-18952
#MA_B73.1.chr1:18953-18973
#MA_5G7601.1.chr1:405-490

odgi extract -n 300 -i chr1.og -o node_300_extracted.og
odgi stats -i node_300_extracted.og -S
#length nodes   edges   paths
1       1       0       1
#length 1, approach does not achieve the goal to calculate the length of 1 node

### extract a subgraph with the MaizeGDB gene ###
# positions in B73 are provided, copy the path name
# determine positions for the other genome

## start position
odgi position -i chr1.og -p MA_B73.1.chr1,246894253,+ -r MA_5G7601.1.chr1
#source.path.pos        target.path.pos dist.to.ref     strand.vs.ref
MA_B73.1.chr1,246894253,+       MA_5G7601.1.chr1,247140771,+    0       +

## stop position 
odgi position -i chr1.og -p MA_B73.1.chr1,246905503,+ -r MA_5G7601.1.chr1
#source.path.pos        target.path.pos dist.to.ref     strand.vs.ref
MA_B73.1.chr1,246905503,+       MA_5G7601.1.chr1,247152013,+    0       +

### EXTRACTION WITH PATH RANGE --path-range or -r - it works!
odgi extract -i chr1.og -o GDBgene.og --path-range MA_B73.1.chr1:246894253-246905503 -E
odgi sort -i GDBgene.og -O -o GDBgene_sorted.og
odgi viz -i GDBgene_sorted.og -o GDBgene.png -x 1000 -y 666 -b -w 10

odgi stats -i GDBgene.og -S
#length nodes   edges   paths
11638   591     811     2
odgi stats -i GDBgene_sorted.og -S
#length nodes   edges   paths
11638   591     811     2
# the stats are the same for the original and the sorted file, odgi sort determines the node order

# convert og file to gfa, in GFA files it is possible to see the paths, to do that: open them with nano, press Ende.
odgi view -i GDBgene_sorted.og  -g > GDBgene_sorted.gfa
less GDBgene_sorted.gfa

### EXTRACTION WITH BED FILE -b
# 1 RANGE
# create bed file with 1 path using nano
nano testbed.bed
# write content with tabs, save, enter, exit. This bed file works for the extraction process.
# extraction for 1 path 
odgi extract -i chr1.og -o GDBgene_bedext.og -b testbed.bed -E -P
odgi stats -i GDBgene_bedext.og -S 
#length nodes   edges   paths
#11638   591     811     2
# looks good, same as the one obtained with path range

# 2 RANGES 
# Gene from  https://maizegdb.org/gene_center/gene/Zm00001d030232
# Name: Zm00001d030232
# 1:114928784..114930818
# Length 2,035 

# create bed file with 2 paths using nano
nano twogenes.bed
# now try for two ranges
odgi extract -i chr1.og -o j_tworanges_extraction.og -b twogenes.bed -E -P # this is not what I want.
odgi stats -i j_tworanges_extraction.og -S
#length nodes   edges   paths
119691881       1772122 2417564 12
# og file > gfa file > vg file > xg file
odgi view -i j_tworanges_extraction.og -g > j_tworanges_extraction.gfa
nano j_tworanges_extraction.gfa

odgi extract -i chr1.og -b twogenes.bed -P -s  # -s split subgraphs # 181 paths, not what I want.
odgi stats -i MA_B73.1.chr1:246894253-246905503.og -S
#length nodes   edges   paths
11419   412     453     181
odgi stats -i MA_B73.1.chr1:114928784-114930818.og -S
#length nodes   edges   paths
56055   1       0       1

less twogenes.bed
odgi extract -i chr1.og  -b twogenes.bed -P -s -E # -s split subgraphs -E, stats for the first gene look ok now. (SOLUTION)
                                                  # For the second, only 1 path. Try with a different second gene.
odgi paths -i MA_B73.1.chr1:246894253-246905503.og -L 
odgi stats -i MA_B73.1.chr1:246894253-246905503.og -S 
#length nodes   edges   paths
11638   591     811     2

odgi paths -i MA_B73.1.chr1:114928784-114930818.og -L
odgi stats -i MA_B73.1.chr1:114928784-114930818.og -S
#length nodes   edges   paths
56055   1       0       1
ls
#length nodes   edges   paths
56055   1       0       1           # is the reason that this gene is only in one of the genotypes?

odgi position -i chr1.og -p MA_B73.1.chr1,114928784,+ -r MA_5G7601.1.chr1 #this gene is not in the second genotype

odgi sort -i MA_B73.1.chr1:246894253-246905503.og -O -o MA_B73.1.chr1:246894253-246905503_sorted.og
odgi view -i MA_B73.1.chr1:246894253-246905503_sorted.og -g > MA_B73.1.chr1:246894253-246905503.gfa
vg view MA_B73.1.chr1:246894253-246905503.gfa -v > MA_B73.1.chr1:246894253-246905503.vg
vg index MA_B73.1.chr1:246894253-246905503.vg -x MA_B73.1.chr1:246894253-246905503.xg

odgi sort -i MA_B73.1.chr1:114928784-114930818.og -O -o MA_B73.1.chr1:114928784-114930818_sorted.og
odgi view -i MA_B73.1.chr1:114928784-114930818_sorted.og -g > MA_B73.1.chr1:114928784-114930818.gfa
vg view MA_B73.1.chr1:114928784-114930818.gfa -v > MA_B73.1.chr1:114928784-114930818.vg
vg index MA_B73.1.chr1:114928784-114930818.vg -x MA_B73.1.chr1:114928784-114930818.xg
# to visualize og files which were result of odgi extraction use node ID+x in STM.

#try to visualize all the chromosome and navigate to the position
odgi view -i chr1.og -g > chr1.gfa
vg view chr1.gfa -v > chr1.vg
vg index chr1.vg -x chr1_B73_5G_pangenome.xg

# get node ID of a position
odgi position -i chr1.og -p MA_B73.1.chr1,114928784,+ -v

246894253-246905503
114928784-114930818

odgi extract -i chr1.og  -b twogenes.bed - c # try -c - L
less twogenes.bed

### -c, --context-steps=N
# The number of steps (nodes) N away from our initial subgraph that we should collect.

# -c in extraction via node ID
# get node ID of a position
odgi position -i chr1.og -p MA_B73.1.chr1,114928784,+ -v # output -> node, offset, strand.
# node ID is 3591013
odgi extract -i chr1.og -n 3591013 -o gene1_noC.og
odgi extract -i chr1.og -n 3591013 -c 1 -E -o gene1_C1.og # -E
odgi extract -i chr1.og -n 3591013 -c 1 -o gene1_NoE.og # without E

odgi stats -i gene1_noC.og -S
#length nodes   edges   paths
# 56055   1       0       1
odgi stats -i gene1_C1.og -S
#length nodes   edges   paths # with -E
#161917  12      16      2          # why 12 nodes? How does it look like? try odgi viz and STM
odgi stats -i gene1_NoE.og -S # without -E
#length nodes   edges   paths
#56057   3       2       2

odgi viz -i gene1_C1.og -o gene1_C1.png -x 1000

odgi view -i gene1_C1.og -g > gene1_C1.gfa
vg view gene1_C1.gfa -v > gene1_C1.vg
vg index gene1_C1.vg -x gene1_C1.xg

odgi view -i gene1_NoE.og -g > gene1_NoE.gfa
vg view gene1_NoE.gfa -v > gene1_NoE.vg
vg index gene1_NoE.vg -x gene1_NoE.xg

# extraction via bed file
less test.bed # bed file with positions of 1 region
odgi paths -i chr1.og -l -L

odgi extract -i chr1.og -b test.bed -c 1 -E -o test.og
# general stats: length, nodes, edges, paths
odgi stats -i test.og -S
#length nodes   edges   paths
#161917  12      16      2
# see node ID and node size 
odgi view -i test.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}'
odgi paths -i test.og -l -L

odgi stats -i gene1_noC.og -S

# what we were trying...
odgi position -b test.bed -i chr1.og -r MA_5G7601.1.chr1 -I

odgi viz -i gene1_noC.og -o gene1_noC.png -x 500 # not informative

odgi sort -i gene1_C.og -O -o gene1_C_sorted.og 
odgi viz -i gene1_C_sorted.og -o gene1_C_sorted.png -x 500 # not informative

odgi view -i gene1_noC.og -g > gene1_noC.gfa
vg view gene1_noC.gfa -v > gene1_noC.vg
vg index gene1_noC.vg -x gene1_noC.xg

odgi view -i gene1_C.og -g > gene1_C.gfa
vg view gene1_C.gfa -v > gene1_C.vg
vg index gene1_C.vg -x gene1_C.xg

# -c in extraction with -b (bed file)
odgi extract -i chr1.og -b twogenes.bed -c 1 -o twogenes_c.og
odgi stats -i twogenes_c.og -S
#length nodes   edges   paths
#67699   598     817     4

odgi extract -i chr1.og -b twogenes.bed -c 1 -P -s -E


---
#-L, --context-bases
# The number of bases N away from our initial subgraph that we should collect.
# get node ID of a position
odgi position -i chr1.og -p MA_B73.1.chr1,114928784,+ -v # output -> node, offset, strand.
# node ID is 3591013

odgi extract -i chr1.og -n 3591013 -o extraction_noL.og
odgi extract -i chr1.og -n 3591013 -L 1 -o exraction_L1.og
odgi extract -i chr1.og -n 3591013 -L 2 -o exraction_L2.og
odgi extract -i chr1.og -n 3591013 -L 3 -o exraction_L3.og

odgi stats -i extraction_noL.og -S -b
#length nodes   edges   paths
#56055   1       0       1
#A       15217
#C       12647
#G       12252
#T       15939
odgi stats -i exraction_L1.og -S -b
#length nodes   edges   paths
#56057   3       2       2
#A       15218
#C       12648
#G       12252
#T       15939
odgi stats -i exraction_L2.og -S -b
#length nodes   edges   paths
#56057   3       2       2
#A       15218
#C       12648
#G       12252
#T       15939
odgi stats -i exraction_L3.og -S -b
#length nodes   edges   paths
#161275  8       9       3
#A       43138
#C       36944
#G       38217
#T       42976

---
# Exploring node size along paths (from odgi GitHub issues, reported by Stefan)
odgi view -i chr1.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}'
#go from ODGI format to GFA format
#grep S lines
#print in a tab-separated manner node id and node length

###################################################################################################################################################################

### Try with 1 BUSCO that lifted over in both, look at the two graphs.
# I have to do this with chr1.og from the Mo18 and B73 pangenomes.
# navigate to working directory
odgi paths -i chr1.og -L -l
#MA_B73_v4.1.chr1        1       307041717
#MA_Mo18W.1.chr1 1       305859294

odgi position -i chr1.og -p MA_B73_v4.1.chr1,4900834,+ -r MA_Mo18W.1.chr1
#source.path.pos        target.path.pos dist.to.ref     strand.vs.ref
#MA_B73_v4.1.chr1,4900834,+      MA_Mo18W.1.chr1,5152394,+       0       +
odgi position -i chr1.og -p MA_B73_v4.1.chr1,4903371,+ -r MA_Mo18W.1.chr1
#source.path.pos        target.path.pos dist.to.ref     strand.vs.ref
#MA_B73_v4.1.chr1,4903371,+      MA_Mo18W.1.chr1,5158910,+       0       +

# extract 
odgi extract -i chr1.og -o BUSCO_lifted_gene.og --path-range MA_B73_v4.1.chr1:4900834-4903371 -E
odgi stats -i BUSCO_lifted_gene.og -S
#length nodes   edges   paths
#6889    532     720     2

odgi sort -i BUSCO_lifted_gene.og -O -o BUSCO_lifted_gene_sorted.og

odgi view -i BUSCO_lifted_gene_sorted.og -g > BUSCO_lifted_gene.gfa
vg view BUSCO_lifted_gene.gfa -v > BUSCO_lifted_gene.vg
vg index BUSCO_lifted_gene.vg -x BUSCO_lifted_gene.xg

---

# EXTRACTION WITH -p
-p, --paths-to-extract=FILE
List of paths to consider in the extraction. The FILE must contain one path name per line and a subset of all paths can be specified.
# create the txt file that contains the paths 
nano 2paths.txt
# extract
odgi extract -i chr1.og -o GDBgene_2bedext_p.og -p 2paths.txt -r MA_B73.1.chr1:246894253-246905503 -E -P # here I specify that I want to collect results in both paths, this can be useful later in pangenomes with more genotypes.
odgi stats -i GDBgene_2bedext_p.og -S
#length nodes   edges   paths
11638   591     811     2
# same result as before

### EXTRACTION WITH -R (must contain 1 path name per line)
-R, --lace-paths=FILE
List of paths to fully retain in the extracted graph. Must contain one path name per line and a subset of all paths can be specified.
odgi extract -i chr1.og -o tworanges_extraction.og -p 2paths.txt -R 2path_ranges.txt -P

### Extract region of target genes ###
# navigate to working directory
conda activate odgi

#https://maizegdb.org/gene_center/gene/Zm00001eb048020
#Zm00001eb
#chr1:246894253..246905503 (11.25 Kb)

odgi paths -i chr1.og -L -l
#MA_B73_v4.1.chr1        1       307041717
#MA_B73_v5.1.chr1        1       308452471
#MA_B97.1.chr1   1       306305032
#MA_CML52.1.chr1 1       310447882
#MA_HP301.1.chr1 1       305741490
#MA_Il14H.1.chr1 1       300415183
#MA_M37W.1.chr1  1       306779357

odgi extract -i chr1.og -o chr1_extgene.og --path-range MA_B73_v4.1.chr1:246894253-246905503 -E
    # -E Collects all nodes in the sorted order of the graph in the min and max position touched by the given path ranges.
    # This ensures that all the paths of the subgraph are not split by node, but that the nodes are laced together again.

# optimization is required to visualize
odgi sort -i chr1_extgene.og -O -o chr1_extgene_sorted.og

# visualize
odgi viz -i chr1_extgene_sorted.og -o chr1_extgene.png -x 1000 -y 666 -b -w 10

# same range determined directly in odgi viz
odgi viz -i chr1.og -o chr1_extgene_viz.png -x 1000 -y 666 -b -w 10 --path-range  MA_B73_v4.1.chr1:246894253-246905503

odgi position -i chr1_BUSCO_extraction.og -p MA_B73_v4.1.chr1,246894253,+ -v

odgi paths -i chr1_BUSCO_extraction.og -L -l

odgi stats -i chr1_BUSCO_extraction.og -m
