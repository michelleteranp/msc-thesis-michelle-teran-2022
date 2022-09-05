### Create small pangenome (6 genomes from the NAM population) ###
# navigate to working directory
# run conda
conda activate
# NAM subpopulations: non-stiff-stock, tropical, popcorn, sweet corn, temporate/tropical mix. https://maizegdb.org/NAM_project

# Selected genomes: B73 reference (v4), B97 (non-stiff-stock), CML52 (tropical), HP301 (popcorn), Il14H (sweetcorn), Mo18W (temporate/tropical mix)

# Set A (-p 80 -s 10000 -a asm20)
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta,inFasta/B97.fasta,inFasta/CML52.fasta,inFasta/HP301.fasta,inFasta/Il14H.fasta"
/PGGB_run.sh -r MA_B73_v4 \
    -i  $INGENOMES \
    -n 6 -s 10000 -p 80 -a asm20 \
    -c True

# clean
mkdir param_set_A
mv chr* param_set_A
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list

# Set D (-p 95 -s 10000 -a asm20)
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta,inFasta/B97.fasta,inFasta/CML52.fasta,inFasta/HP301.fasta,inFasta/Il14H.fasta"
/PGGB_run.sh -r MA_B73_v4 \
    -i  $INGENOMES \
    -n 6 -s 10000 -p 95 -a asm20 \
    -c True

# clean
mkdir param_set_D
mv chr* param_set_D
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list

# Set H2 (-p 90 -s 30000 -a asm20)
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta,inFasta/B97.fasta,inFasta/CML52.fasta,inFasta/HP301.fasta,inFasta/Il14H.fasta"
/PGGB_run.sh -r MA_B73_v4 \
    -i  $INGENOMES \
    -n 6 -s 30000 -p 90 -a asm20 \
    -c True

# clean
mkdir param_set_H2
mv chr* param_set_H2
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list

# Set combined (-p 80 -s 30000 -a asm20)
INGENOMES="inFasta/B73_v4.fasta,inFasta/Mo18W.fasta,inFasta/B97.fasta,inFasta/CML52.fasta,inFasta/HP301.fasta,inFasta/Il14H.fasta"
/PGGB_run.sh -r MA_B73_v4 \
    -i  $INGENOMES \
    -n 6 -s 30000 -p 80 -a asm20 \
    -c True

# clean
mkdir set_combined
mv chr* set_combined
rm -r profile/ run/ splits/ pangenome.seq.fasta pangenome.seq.fasta.fxi rename splits.done sequences.list