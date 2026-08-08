#!/bin/bash
# Author: Wagner N. Ribeiro
# Script for palm nuclear genome assembly with ABySS
# Setup: 30 cores, 400GB RAM, paired-end Illumina reads

# SETTINGS - ADJUST THESE VALUES!
# Working directory and files
WORK_DIR="/media/lgbio-nas1/wagnerribeiro/Syagrus"
READS_FW="${WORK_DIR}/nuclear_R1.fastq.gz"
READS_RV="${WORK_DIR}/nuclear_R2.fastq.gz"

# ABySS parameters
ASSEMBLY_NAME="nuclear_palm"
KMER=65
MEMORY_GB=400
THREADS=30

# INITIAL VALIDATION
echo "=================================================="
echo "STARTING GENOME ASSEMBLY WITH ABYSS"
echo "=================================================="
echo "Date: $(date)"
echo "Directory: ${WORK_DIR}"
echo "Memory: ${MEMORY_GB}G"
echo "Threads: ${THREADS}"
echo "=================================================="

# Check that the read files exist
if [[ ! -f "${READS_FW}" ]] || [[ ! -f "${READS_RV}" ]]; then
 echo "ERROR: Read files not found!"
 echo "Forward: ${READS_FW}"
 echo "Reverse: ${READS_RV}"
 exit 1
fi

# Check available memory
MEM_AVAILABLE=$(free -g | grep Mem: | awk '{print $2}')
if [[ ${MEM_AVAILABLE} -lt 400 ]]; then
 echo "WARNING: Available memory (${MEM_AVAILABLE}G) is below the recommended (400G)"
fi

# RUN THE ASSEMBLY
cd "${WORK_DIR}"
echo "Running ABySS with the following parameters:"
echo " k=${KMER}"
echo " name=${ASSEMBLY_NAME}"
echo " B=${MEMORY_GB}G"
echo " j=${THREADS}"
echo ""

# Main ABySS command
abyss-pe \
 k=${KMER} \
 name=${ASSEMBLY_NAME} \
 B=${MEMORY_GB}G \
 j=${THREADS} \
 in="${READS_FW} ${READS_RV}" \
 2>&1 | tee ${ASSEMBLY_NAME}_log.txt

# CHECK RESULTS
if [[ $? -eq 0 ]]; then
 echo ""
 echo "=================================================="
 echo "ASSEMBLY COMPLETED SUCCESSFULLY!"
 echo "=================================================="

 # Generate assembly statistics
 echo "Generating statistics..."
 abyss-fac ${ASSEMBLY_NAME}-contigs.fa > ${ASSEMBLY_NAME}_statistics.txt

 # Show the main statistics
 echo ""
 echo "MAIN STATISTICS:"
 echo "------------------------"
 grep -E "(total|N50|N90|mean|median)" ${ASSEMBLY_NAME}_statistics.txt | head -10

 # Check generated files
 echo ""
 echo "GENERATED FILES:"
 echo "-----------------"
 ls -lh ${ASSEMBLY_NAME}-*

else
 echo ""
 echo "=================================================="
 echo "ASSEMBLY ERROR!"
 echo "=================================================="
 echo "Check the log file: ${ASSEMBLY_NAME}_log.txt"
 exit 1
fi

echo ""
echo "Process finished at: $(date)"
