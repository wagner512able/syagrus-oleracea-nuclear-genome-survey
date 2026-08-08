#!/bin/bash
# Author: Wagner Nunes Ribeiro

#### QDD script
# pipe1
# perl pipe1.pl -input_file ./../Syagrus_oleracea_2025.fasta -out_folder .

# pipe2
# perl pipe2.pl -input_file Syagrus_oleracea_2025_pipe1_for_pipe2.fas -out_folder .

# pipe3
# perl pipe3.pl -input_file Syagrus_oleracea_2025_pipe2_for_pipe3.fas -out_folder .

# pipe4
perl pipe4.pl -input_file Syagrus_oleracea_2025_pipe3_primers.tabular -out_folder .

# Before running these commands (one at a time), configure the QDD configuration file
# "set_qdd_default" exactly as shown in set_qdd_default.config. It already ships with this
# structure — just change the values and paths as needed.
