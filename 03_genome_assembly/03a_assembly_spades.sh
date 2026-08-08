#!/bin/bash
# Author: Wagner N. Ribeiro

# ASSEMBLY OF THE SYAGRUS OLERACEA GENOME USING SPADES
/home/lgbio/programas/spades/SPAdes-4.0.0-Linux/bin/spades.py \
 -1 nuclear_R1.fastq.gz -2 nuclear_R2.fastq.gz -t 30 -m 700 -k 21,33,55,65 \
 --mismatch-correction --phred-offset 33 -o SPAdes

# -m 700 = SPAdes requires a lot of memory, so this is what was available
# -k 21,33,55,65 = k-mer values used for short reads, based on the KmerGenie result
# --phred-offset 33 = this value is set during sequencing and can be checked in the first FastQC result
# --mismatch-correction = increases processing time but recovers more contigs
# do not use the --isolate parameter, since it is only recommended for organelles or smaller
# genomes (not advisable for genomes > 100 Mb)
