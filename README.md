# Msc thesis Michelle Teran 2022

A project to hold scripts and workflow from Michelle Teran developed as part of her Masters Thesis: Accessing maize pangenome graphs.

Scripts are divided into different folders as described:

## 1. BUSCO approach
- [ ] blastBUSCO.sh
  -  BLASTP poales_odb10 ancestral BUSCO dataset and B73AGPv04, Mo18W and B97.
  -  Run for loop to determine the number of BUSCOs present in the pangenome .og files.
- [ ] BUSCOstart.R
  - Create files with BUSCO genes start positions (.txt) and start/end positions (.bed).
- [ ] plot_pangenome_liftover.R
  - Generate bar plots of lift-over percentage achieved in pangenomes with 2 and 6 genomes and different parameter sets.

## 2. Extraction and visualization
- [ ] extraction_three_candidate_genes.sh: procedure for the extraction of ZmCCT, Anthocyanin regulatory C1 and ZmRLK1 from a pangenome with 7 genomes (B73_v4, B73_v5, B97, CML52, HP301, Il14H, M37W) and parameter set (-p 90, -s 10000, -a asm20, -n 7
  - Create .bed file for each gene +- 1000 bp window.
  - Extract with odgi extract.
  - Generate visualizations with odgi viz and STM.
  - Generate of list with node identifiers and node length.
  - Explore of sub-paths generated as result of the extraction process.

- [ ] extraction_optimized_pangenome.sh
  - Extraction of the three candidate genes in a pangenome constructed with optimized parameter sets. Both the graph and the extraction failed in capturing the genetic complexity of the loci.

- [ ] extract_target_genes.sh
  - Exploration of extraction of regions/genes with different options of odgi extract: extraction with node ID, path range, .bed files.

## 3. Pangenome construction
- [ ] pangenome_construction_manual.sh 
  - Create pangenomes with 2 genomes and different parameter sets with the PGGB pipeline.
- [ ] 6genomes_param_sets.sh 
  - Create pangenomes with 6 genomes and different parameter sets with the PGGB pipeline.

## 4. Pangenome navigation
- Scripts used to explore navigation with path and graph positions, average node length, degree, depth, node size, odgi stats, and estimate divergency with mash.

## 5. Variant calling
- [ ] variant_calling_process.sh
  - Filter and edit HapMap3 subset and genetic variation obtained from a pangenome with 6 genomes constructed with the optimized parameter settings. 
  - Comparison with bcftools gtcheck.
- [ ] indels.sh
  - Filter pangenome dataset to include only InDels.
- [ ] gtcheck_vc_calling_process.R:
  - Overlap Hapmap3 and pangenome exploration.
  - Classification of Indels obtained from the pangenome according to the absolute value of node length.
  - Get a list of the largest InDels.