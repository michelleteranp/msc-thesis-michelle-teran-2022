# navigate to working directory
conda activate odgi

# get positions of a BUSCO in chr1
odgi position -i chr1.og -p MA_B73_v4.1.chr1,38903073,+ -v -I
# source.path.pos        target.graph.pos
# MA_B73_v4.1.chr1,38903073,+     5274804,95,-

# find positions in the 7 genomes
odgi position -i chr1.og -g  5274804,95,- -I
    # -g, --graph-pos=[[node_id][,offset[,(+|-)]**]**]
#target.graph.pos       target.path.pos dist.to.ref     strand.vs.ref
#5274804,95,-    MA_B73_v4.1.chr1,38903073,+     0       +
#5274804,95,-    MA_B73_v5.1.chr1,38480186,+     0       +
#5274804,95,-    MA_B97.1.chr1,38646234,+        0       +
#5274804,95,-    MA_CML52.1.chr1,42143649,+      0       +
#5274804,95,-    MA_HP301.1.chr1,39772632,+      0       +
#5274804,95,-    MA_Il14H.1.chr1,39123502,+      0       +
#5274804,95,-    MA_M37W.1.chr1,38691095,+       0       +

odgi extract -i chr1.og -o chr1_BUSCO_extraction.og -n 5274804 -c 10
# -n A single node from which to begin our traversal.
# The number of steps away from our initial subgraph that we should collect.

odgi view -i chr1_BUSCO_extraction.og -g > chr1_BUSCO_extraction.gfa
#Write the graph in GFAv1 format to standard output
vg view chr1_BUSCO_extraction.gfa -v > chr1_BUSCO_extraction.vg
vg index chr1_BUSCO_extraction.vg -x chr1_BUSCO_extraction.xg

odgi sort -i chr1_BUSCO_extraction.og -o chr1_BUSCO_extraction.og -O
odgi stats -i chr1_BUSCO_extraction.og -s

odgi position -i chr1_BUSCO_extraction.og -p MA_B73_v4.1.chr1:38902272-38902334,1,+ -v

# did not work in STM, now try with entire chromosome
odgi view -i chr1.og -g > chr1_7pg.gfa
vg view chr1_7pg.gfa -v -t 2 > chr1_7pg.vg
vg index chr1_7pg.vg -x chr1_7pg.xg
# check in STM node:5274804+20