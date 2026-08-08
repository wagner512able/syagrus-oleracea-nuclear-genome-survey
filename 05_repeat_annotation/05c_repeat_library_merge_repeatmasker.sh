#!/bin/bash
# Author: Wagner Nunes Ribeiro

# Concatenate the AnnoTEP and RepeatModeler libraries
cat Syagrus_oleracea.fasta.mod.EDTA.TElib.fa consensi.fa.classified > combined_raw.fa

# Remove redundancy
cd-hit-est -i combined_raw.fa -o combined_nr.fa -c 0.85 -n 8 -M 0 -T 25

# Reclassify the "Unknown" entries (optional, but recommended)
RepeatClassifier -consensi combined_nr.fa

# Use the final library in RepeatMasker
RepeatMasker -pa 100 -gff -lib combined_nr.fa.classified ../Syagrus_oleracea_NCBI_2.fasta
