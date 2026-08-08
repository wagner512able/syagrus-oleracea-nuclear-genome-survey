#!/bin/bash
# Author: Wagner Nunes Ribeiro

# 1. COUNT READS USING K-MER = 21 AND THE TWO READ FILES AS INPUT
# jellyfish count -F 2 -m 21 -s 30G -t 15 -C <(zcat nuclear_R1.fastq.gz) <(zcat nuclear_R2.fastq.gz)

# 2. STATISTICS
# jellyfish stats mer_counts.jf

# 3. HISTOGRAM (THIS IS THE MOST IMPORTANT ONE, AND THE ONE UPLOADED TO GENOMESCOPE)
# jellyfish histo mer_counts.jf > nuclear_histo.txt

# 4. FIRST LINES OF THE HISTOGRAM TO CONFIRM THE FILE WAS GENERATED
# head -20 nuclear_histo.txt
