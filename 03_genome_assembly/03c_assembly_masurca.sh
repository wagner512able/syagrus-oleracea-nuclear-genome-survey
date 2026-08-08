#!/bin/bash
# Author: Wagner N. Ribeiro
# masurca.sh

# CREATE THE CONFIGURATION FILE
cat <<EOT > masurca.config
DATA
PE= pA 257 101 nuclear_R1.fastq.gz nuclear_R2.fastq.gz
END
PARAMETERS
GRAPH_KMER_SIZE=auto
USE_LINKING_MATES=1
CA_PARAMETERS = ovlMerSize=30 cgwErrorRate=0.15 ovlHashBits=26 ovlHashBlockLength=200000000
NUM_THREADS=20
JF_SIZE=2000000000
LIMIT_JUMP_COVERAGE=60
END
EOT

# RUN MASURCA ON THE OUTPUT DIRECTORY
masurca masurca.config

# PE = paired-end reads
# pA = reads from a single library
# 257 = mean insert size, in base pairs (bp) (calculated by a separate script or from the SPAdes
#       assembly log. It is recommended to assemble with SPAdes first specifically to obtain this
#       value from its log file)
# 101 = standard deviation of the insert size, also in bp. Also calculated from the SPAdes assembly.
# GRAPH_KMER_SIZE=auto = automatically calculates the best k-mer size, giving the same result
#       as KmerGenie or similar
# ovlMerSize=30 = the suggested default for bacterial and eukaryotic genomes. Acts as a second
#       k-mer value set for the assembly
# cgwErrorRate=0.15: controls the maximum error rate allowed during consensus graph
#       construction. Recommendation: 0.25 for bacterial genomes (more tolerant); 0.1-0.15 for
#       other organisms, such as eukaryotes (including plants), to balance accuracy and completeness.
# JF_SIZE=2000000000 = estimated genome size. Set a value 3x larger than the estimate. If it is
#       still too small, MaSuRCA itself selects a larger value during assembly. No need to worry
#       about this.
# Keep in mind that MaSuRCA consumes more storage than the other assemblers. For genomes
#       > 1 Gb, have at least 1 TB of storage available.
