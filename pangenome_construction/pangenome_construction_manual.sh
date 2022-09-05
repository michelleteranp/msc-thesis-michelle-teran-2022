### Run pangenome pipeline for B73 and Mo18W ###
# run conda

# input
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"

# clean
mv chr* param_setX
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list

# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm20 \
    -c True

################################################################################################################################

### Try different parameter sets and check impact on BUSCO liftover % ###
# navigate to working directory

# Param set A
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 80 -a asm20 \
    -c True
    
# move results inside param_set_A folder 
# clean
mv chr* param_set_A
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list

# Param set B
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 85 -a asm20 \
    -c True

# move results inside param_set_B folder 
# clean
mv chr* param_set_B
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set C
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm20 \
    -c True
    
# move results inside param_set_C folder 
# clean
mv chr* param_set_C
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set D
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 95 -a asm20 \
    -c True

# move results inside param_set_D folder 
# clean
mv chr* param_set_D
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set E
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 5000 -p 90 -a asm20 \
    -c True
    
# move results inside param_set_E folder 
# clean
mv chr* param_set_E
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set F
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm20 \
    -c True

# clean
mv chr* param_set_F
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake
    
# Param set G
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 15000 -p 90 -a asm20 \
    -c True

# clean
mv chr* param_set_G
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set H
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 100000 -p 90 -a asm20 \
    -c True

# clean
mv chr* param_set_H
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set I
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm5 \
    -c True
    
# clean
mv chr* param_set_I
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set J
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm10 \
    -c True

# clean
mv chr* param_set_J
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set H2
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 30000 -p 90 -a asm20 \
    -c True

# clean
mv chr* param_set_H2
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set H3
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 60000 -p 90 -a asm20 \
    -c True

# clean
mv chr* param_set_H3
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake

# Param set K
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta"
# add -n 2 because only 2 input genomes
/PGGB_run.sh -r MA_B73 \
    -i  $INGENOMES \
    -n 2 -s 10000 -p 90 -a asm15 \
    -c True

# clean
mv chr* param_set_K
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list .snakemake