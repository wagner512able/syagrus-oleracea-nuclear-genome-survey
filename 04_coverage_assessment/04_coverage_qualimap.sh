#!/bin/bash
# Author: Wagner N. Ribeiro

# conda activate qualimap_env # if installed in a separate conda environment

# INDEX THE ASSEMBLED GENOME (FASTA)
# bwa index Syagrus_oleracea.fasta

# ALIGN THE FASTQ READS TO THE ASSEMBLED GENOME
# bwa mem Syagrus_oleracea.fasta ordered_R1.fastq.gz ordered_R2.fastq.gz > alignment.sam

# CONVERT SAM TO BAM, SORT, AND INDEX
# samtools view -bS alignment.sam | samtools sort -o alignment.bam
# samtools index alignment.bam

# RUN QUALIMAP TO CALCULATE COVERAGE
# Configurable parameters
BAM_FILE="alignment.bam"
OUTPUT_DIR="qualimap_results"
JAVA_MEM_SIZE="200G" # Memory allocated to the JVM
NUM_THREADS=25
GTF_FILE="gueroba.gtf" # GTF file (if needed, for RNA-seq)
