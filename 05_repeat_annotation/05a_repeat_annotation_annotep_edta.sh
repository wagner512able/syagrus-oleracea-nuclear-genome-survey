#!/bin/bash
# Author: Wagner Nunes Ribeiro

# cd ~/AnnoTEP/MyGenome
# nohup ../EDTA/EDTA.pl \
# --genome ./Syagrus_oleracea.fasta \
# --species others \
# --step all \
# --sensitive 1 \
# --anno 1 \
# --threads 60 \
# --force 1 \
# -u 7.0e-9 > EDTA.log 2>&1 &

### re-running the TIR step after fixing the break_fasta.pl file
# nohup perl ../EDTA/EDTA_raw.pl \
# --genome ./Syagrus_oleracea.fasta \
# --type tir \
# --overwrite 1 \
# --species others \
# --sensitive 1 \
# --threads 60 \
# -u 7.0e-9 \
# > EDTA_TIR.log 2>&1 &

### now running the EDTA finalization step, reusing what it had already found
# nohup perl ../EDTA/EDTA.pl \
# --genome ./Syagrus_oleracea.fasta \
# --species others \
# --step all \
# --overwrite 0 \
# --sensitive 1 \
# --anno 1 \
# --threads 60 \
# --force 1 \
# -u 7.0e-9 \
# > EDTA_final.log 2>&1 &
# tail -f EDTA_final.log

### Since the chromosome_density_plots.pdf file failed, run the RepeatMasker step separately
## this file "chromosome_density_plots.pdf" is only worth generating if the assembly is at
## chromosome level or has few contigs
# nohup RepeatMasker \
# -lib Syagrus_oleracea.fasta.mod.EDTA.TElib.fa \
# -pa 60 \
# -gff \
# -dir . \
# ./Syagrus_oleracea.fasta \
# > RM.log 2>&1 &
# tail -f RM.log

### Re-running the final EDTA step in sensitive mode
# nohup perl ../EDTA/EDTA.pl \
# --genome ./Syagrus_oleracea.fasta \
# --species others \
# --step final \
# --overwrite 0 \
# --sensitive 1 \
# --anno 1 \
# --threads 60 \
# --force 1 \
# -u 7.0e-9 \
# > EDTA_final_sensitive.log 2>&1 &
# tail -f EDTA_final_sensitive.log

### To run the final AnnoTEP step, move the "MyGenome" folder into the "cli" folder,
### where the "run_annotep.py" file is located
## Use the command below, and the final files will go to the "results" folder
# cd ~/AnnoTEP/cli
# nohup python run_annotep.py \
# --genome /home/wagner/AnnoTEP/MyGenome/Syagrus_oleracea.fasta \
# --species others \
# --step final \
# --sensitive 1 \
# --threads 60 \
# --force 1 \
# --folder MyGenome \
# > AnnoTEP.log 2>&1 &
# tail -f AnnoTEP.log
