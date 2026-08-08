#!/bin/bash
# Author: Wagner N. Ribeiro

# Build the index file
# BuildDatabase -name SyagrusDB Syagrus_oleracea_NCBI_2.fasta

# Run RepeatModeler
RepeatModeler -database SyagrusDB -engine rmblast -threads 100
