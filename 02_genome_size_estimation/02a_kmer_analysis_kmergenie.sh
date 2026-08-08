#!/bin/bash
# Author: Wagner N. Ribeiro

./kmergenie file_list.txt -t 30 -l 21 -k 121 -o kmergenie_results --diploid
# This command can be run directly, no need to create a submission script for it
# file_list.txt contains the paths to the two nuclear read files
# -t 30: threads used
# -l 21 -k 121: read window chosen for the estimate
# --diploid: for a more precise estimate, since S. oleracea has a diploid genome
