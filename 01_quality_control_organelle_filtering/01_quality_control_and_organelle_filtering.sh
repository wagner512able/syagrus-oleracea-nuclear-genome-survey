#!/bin/bash
# Author: Wagner N. Ribeiro

######## ESTIMATE SEQUENCING QUALITY AND QUANTITY OF RAW READS WITH FASTQC
# fastqc Sol-01_S1_L001_R1_001.fastq.gz Sol-01_S1_L001_R2_001.fastq.gz -t 30

######## QUALITY CONTROL USING DIFFERENT PHRED VALUES
# trimmomatic PE -threads 50 -phred33 \
# Sol-01_S1_L001_R1_001.fastq.gz Sol-01_S1_L001_R2_001.fastq.gz \
# output_R1_paired.fastq output_R1_unpaired.fastq \
# output_R2_paired.fastq output_R2_unpaired.fastq \
# ILLUMINACLIP:adapters_illumina_dna_prep.fa:2:30:10:2:keepBothReads \
# SLIDINGWINDOW:4:25 MINLEN:50
# The file "adapters_illumina_dna_prep" with the adapter sequences is in adapters_illumina_dna_prep.fa
# Repeat the analyses using Phred 15, 20, 25, and 30 (to do this, replace the SLIDINGWINDOW
# values according to the Phred values).

######## ESTIMATE DATA AND READ QUALITY WITH FASTQC AGAIN AFTER TRIMMING WITH PHRED VALUES
# fastqc output_R1_paired.fastq output_R2_paired.fastq -t 30

######## PERFORM ORGANELLE READ ASSEMBLY WITH GETORGANELLE
# separate script located in the chloroplast genome repository

######## CONCATENATE THE OBTAINED CHLOROPLAST AND MITOCHONDRIAL SEQUENCES TO CREATE THE INDEX FILE
# cat embplant_pt.K85.complete.graph1.2.path_sequence.fasta embplant_mt.K85.scaffolds.graph1.1.path_sequence.fasta > organelles_ref.fasta

######## BUILD THE INDEX FOR THE ORGANELLE REFERENCE FILE USING BOWTIE2
bowtie2-build organelles_ref.fasta organelles_ref

######### ALIGN THE OVERALL READS TO THE ORGANELLE REFERENCE AND EXTRACT THE UNALIGNED (NUCLEAR) READS
bowtie2 -x organelles_ref -1 output_R1_paired.fastq -2 output_R2_paired.fastq -S aligned_to_organelles.sam --un-conc nuclear.fastq --no-unal -p 20
# --un-conc was used to save the concordantly unaligned pairs
# --no-unal to exclude alignments from the SAM (to save space)
# -p 20 to use 20 threads
# with this command we don't need to convert SAM to BAM, sort, index, and then convert back
# to fastq. It is more direct.
