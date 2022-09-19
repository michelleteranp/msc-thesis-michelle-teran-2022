### Navigate pangenome graphs ###
# Based on the pangenome with two genomes: B73 and Mo18
# navigate to working directory
conda activate odgi
# based on Stefan's manual navigate_graphs.txt

# convert path position (== bp) to graph position - input source path position, output target path position
odgi position -i chr6.og -p MA_B73_v4.1.chr6,159346413,+ -r MA_Mo18W.1.chr6
    # - p path name
    # - r Translate the given positions into positions relative to this reference path
# source.path.pos	target.path.pos	dist.to.ref	strand.vs.ref
# MA_B73_v4.1.chr6,159346413,+	MA_Mo18W.1.chr6,166774122,+	0	+
# works, this is a way to find orthologues in another path

# find graph position by path for the orthologues
odgi position -i chr6.og -p MA_B73_v4.1.chr6,159346413+ -v
    # -v emit graph positions (node, offset, strand)
# source.path.pos	target.graph.pos
# MA_B73_v4.1.chr6,159346413,+	3106183,1136,+

odgi position -i chr6.og  -p MA_Mo18W.1.chr6,166774122+ -v
# source.path.pos	target.graph.pos
# MA_Mo18W.1.chr6,166774122,+	3106183,1136,+
# same graph position

# other way, graph to path
odgi position -i chr6.og -g 3106183,1136,+ -I
    # -g a graph position
    # -I to print both paths otherwise emits only B73 paths
#target.graph.pos	target.path.pos	dist.to.ref	strand.vs.ref
#3106183,1136,+	MA_B73_v4.1.chr6,159346413,+	0	+
#3106183,1136,+	MA_Mo18W.1.chr6,166774122,+	0	+

# I took the next coordinate as example for the extraction process
grep '>6:159' MA_B73BUSCO_headers.txt 
#>6:159346413 
#>6:159661700 (this one)

odgi position -i chr6.og -p MA_B73_v4.1.chr6,159661700,+ -r MA_Mo18W.1.chr6
#source.path.pos	target.path.pos	dist.to.ref	strand.vs.ref
#MA_B73_v4.1.chr6,159661700,+	MA_Mo18W.1.chr6,167236201,+	0	+
odgi position -i chr6.og -p MA_B73_v4.1.chr6,159661700+ -v
#source.path.pos	target.graph.pos
#MA_B73_v4.1.chr6,159661700,+	3111064,30,+
odgi position -i chr6.og  -p MA_Mo18W.1.chr6,167236201+ -v
#source.path.pos	target.graph.pos
#MA_Mo18W.1.chr6,167236201,+	3111064,30,+

odgi position -i chr6.og -g 3111064,30,+ -I
#target.graph.pos	target.path.pos	dist.to.ref	strand.vs.ref
#3111064,30,+	MA_B73_v4.1.chr6,159661700,+	0	+
#3111064,30,+	MA_Mo18W.1.chr6,167236201,+	0	+

### Extract regions of the pangenome graph ###
# extract -> optimize -> visualize

# extract path range = target graph positions determined above
odgi extract -i chr6.og -o chr6_extracted.og --path-range MA_B73_v4.1.chr6:3106183,1136-3111064,30 # Mo18 divided in 10 sections
odgi extract -i chr6.og -o chr6_specifiedrange.og --path-range MA_B73_v4.1.chr6:3106183-3111064 -E # it works
    # strange, it worked 3106183,1136-3111064,30
odgi extract -i chr6.og -o chr6_ext.og --path-range MA_B73_v4.1.chr6:159660000-159661000 # Mo18 divided in >10 sections
odgi extract -i chr6.og -o chr6_specrange.og --path-range MA_B73_v4.1.chr6:159660000-159661000 -E # now they are only divided in two genotypes ***
    # -E Collects all nodes in the sorted order of the graph in the min and max position touched by the given path ranges.
    # This ensures that all the paths of the subgraph are not split by node, but that the nodes are laced together again. 
    # Comparable to -R, --lace-paths=FILE, but specifically for all paths in the resulting subgraph. Be careful to use it with very complex graphs.

# optimization is required to visualize
odgi sort -i chr6_extracted.og -O -o chr6_sorted_t1.og
odgi sort -i chr6_ext.og -O -o chr6_sorted_t2.og
odgi sort -i chr6_E.og -O -o chr6_sorted_t3.og
odgi sort -i chr6_specifiedrange.og -O -o chr6_sorted_specifiedrange.og


# visualize
odgi viz -i chr6_sorted_t1.og -o chr6_t1.png -x 1000 -y 666 -b -w 10
odgi viz -i chr6_sorted_t2.og -o chr6_t2.png -x 1000 -y 666 -b -w 10
odgi viz -i chr6_sorted_t3.og -o chr6_t3.png -x 1000 -y 666 -b -w 10
odgi viz -i chr6_sorted_specifiedrange.og -o chr6_specifiedrange.png -x 1000 -y 666 -b -w 10

# same range determined directly in odgi viz
odgi viz -i chr6.og -o chr6_rangetest.png -x 1000 -y 666 -b -w 10 --path-range  MA_B73_v4.1.chr6:159660000-159661000 # same visualization as chr6_t3.png

# -p list of paths to display in the specified order; the file must contain one path name per line and a subset of all paths can be specified.
# should I produce a file and try -p --paths-to-display again?

# range with target path positions from the BUSCO headers
odgi viz -i chr6.og -o chr6_BUSCOrange.png -x 1000 -y 666 -b -w 1000 --path-range  MA_B73_v4.1.chr6:159346413-159661700
# extraction worked

### Other odgi commands ###
# Interrogate the embedded paths of a graph.
odgi paths -i chr6.og -L -l
# MA_B73_v4.1.chr6	1	174033170
# MA_Mo18W.1.chr6	1	181875842

# Describe the graph in terms of node degree
odgi degree -i chr6.og -S
    # -S summarization mode, summarize the graph properties and dimensions
#node.count     edge.count      avg.degree      min.degree      max.degree
#3136543 4249484 2.70966 1       6

# odgi panpos: get the pangenome position of a given path and nucleotide position (1 based)
