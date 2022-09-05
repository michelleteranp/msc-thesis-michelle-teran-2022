### Extract three candidate genes in a pangenome with 6 genomes + optimized parameters ###
# navigate to working directory
# run conda
conda activate odgi

# optimized pangenome (p 80, s 30000, a asm20)

# 1. Flowering time : ZmCCT  - Zm00001d024909 (AGPv04) - 10:94430850-94433495
# create bed file with start and end positions of the gene
nano ZmCCT.bed
less ZmCCT.bed
# perform extraction 
odgi extract -i chr10.og -b ZmCCT.bed -L 1000 -P -E -o ZmCCT_opt_pg.og
# stats of the extraction
odgi stats -S -i ZmCCT_opt_pg.og
    #length nodes   edges   paths
    #3919    261     356     6
# visualization with odgi viz
odgi viz -i ZmCCT_opt_pg.og -o ZmCCT_opt_pg.png -x 500

# visualize in STM
odgi view -i ZmCCT_opt_pg.og -g > ZmCCT_opt_pg.gfa
vg view ZmCCT_opt_pg.gfa -v > ZmCCT_opt_pg.vg
vg index ZmCCT_opt_pg.vg -x ZmCCT_opt_pg.xg # !!!

# get list with node ID and length
odgi view -i ZmCCT_opt_pg.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}' > ZmCCT_opt_pg_nodelist.txt
head ZmCCT_opt_pg_nodelist.txt
tail ZmCCT_opt_pg_nodelist.txt
    # first node ID 15074689
    # last node ID 15074949

# 2. Anthocyanin regulatory C1 - Zm00001d044975 (AGPv04) - 9:8983448..8984721
# create bed file with start and end positions of the gene
nano C1.bed
less C1.bed

# perform extraction, in this case no -E since documentation does not recommend this for complex graphs.Flag -d included to merge close subpaths
odgi extract -i chr9.og -b C1.bed -L 1000 -d 300 -P -o C1_opt_pg_d300.og # with -d 300 - not good
odgi stats -S -i C1_opt_pg_d3000.og # tried with -d 3000, did not give good result. and the distance between subpaths does not exceed 3000. In most cases 2,3...
#length nodes   edges   paths
#5434206 1358110 1804677 1274647

odgi extract -i chr9.og -b C1.bed -L 1000 -d 300 -P -o C1_opt_pg_d300.og # NO
odgi stats -S -i C1_opt_pg_d300.og
#length nodes   edges   paths
#38239   13451   19109   34975

odgi extract -i chr9.og -b C1.bed -L 1000 -d 300 -e 10 -P -o C1_opt_pg_d300e.og #NO
odgi stats -S -i C1_opt_pg_d300e.og
#length nodes   edges   paths
#4309800 1444825 2165229 464448

odgi extract -i chr9.og -b C1.bed -L 1000 -P -E -o C1_opt_pg_E.og # try -E
odgi stats -i C1_opt_pg_E.og -S
#length nodes   edges   paths
#75561792        9811911 13874618        444325

# extraction as in https://github.com/pangenome/odgi/pull/419
odgi extract -i chr9.og -L 1000 -r MA_B73_v4.1.chr9:8983448-8984721 -o - -d 500000 | odgi sort -i - -O -o C1.og && odgi viz -i C1.og -o C1.png
odgi stats -i C1.og -S
#length          nodes             edges         paths
#319493403       35302709        49541061        8

# this does not look good, extracted nearly the complete chromosome

###
# 3. Resistance: ZmRLK1 - Zm00001d011629 (AGPv04) - 8:156763311..156774071
nano RLK1.bed
less RLK1.bed

odgi extract -i chr8.og -b RLK1.bed -L 1000 -d 3000 -P -o RLK1.og
odgi stats -i RLK1.og -S
#length nodes   edges   paths
#34252   9698    13652   28

odgi paths -i RLK1.og -l -L

# visualize in STM
odgi view -i RLK1.og -g > RLK1.gfa
vg view RLK1.gfa -v > RLK1.vg
vg index RLK1.vg -x RLK1_opt_set.xg # !!!

# get list with node ID and length
odgi view -i RLK1.og -g | grep '^S' | awk -v OFS='\t' '{print($2,length($3))}' > RLK1_nodelist.txt
head RLK1_nodelist.txt
tail RLK1_nodelist.txt
    # first node ID 25335211
    # last node ID 37523681

### 
# Second try C1
# 2. Anthocyanin regulatory C1 - Zm00001d044975 (AGPv04) - 9:8983448..8984721
# create bed file with start and end positions of the gene
nano C1.bed
less C1.bed
#MA_B73_v4.1.chr9        8983448 8984721

odgi extract -i chr9.og -b C1.bed -L 1000 -d 3000 -P -o C1_ext_opt_set.og
odgi stats -i C1_ext_opt_set.og -S
#length nodes   edges   paths
#5434206 1358110 1804677 1274647