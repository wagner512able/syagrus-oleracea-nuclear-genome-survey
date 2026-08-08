# Syagrus oleracea Nuclear Genome — Genome Survey Pipeline

Scripts used to produce a genome-survey-level draft of the nuclear genome of
*Syagrus oleracea*. The assembly obtained was highly fragmented and is
reported in the associated manuscript as a genome survey rather than a
reference-quality assembly.

Author: Wagner N. Ribeiro

## Repository structure

```
01_quality_control_organelle_filtering/   Read QC, trimming, and removal of organellar reads
02_genome_size_estimation/                K-mer-based genome size estimation
03_genome_assembly/                       Genome assembly with three different assemblers
04_coverage_assessment/                   Sequencing coverage assessment
05_repeat_annotation/                     Repeat element annotation
06_ssr_annotation/                        SSR (microsatellite) annotation and marker design
```

### 01_quality_control_organelle_filtering

| File | Description |
|---|---|
| `01_quality_control_and_organelle_filtering.sh` | Read QC with FastQC, adapter/quality trimming with Trimmomatic (repeated across Phred 15-30), and removal of chloroplast/mitochondrial reads by aligning against the organelle reference with Bowtie2 (unaligned pairs = nuclear reads). |
| `adapters_illumina_dna_prep.fa` | Adapter sequences used by Trimmomatic's `ILLUMINACLIP` step. |

### 02_genome_size_estimation

| File | Description |
|---|---|
| `02a_kmer_analysis_kmergenie.sh` | K-mer window/size estimation with KmerGenie (diploid mode). |
| `02b_genome_size_estimation_jellyfish_genomescope.sh` | K-mer counting and histogram generation with Jellyfish, for genome size/heterozygosity estimation with GenomeScope. |

### 03_genome_assembly

Three assemblers were tested on the nuclear read set:

| File | Description |
|---|---|
| `03a_assembly_spades.sh` | Assembly with SPAdes (short reads, multi-k-mer, mismatch correction). |
| `03b_assembly_abyss.sh` | Assembly with ABySS (single k-mer, high-memory run with logging and automatic stats). |
| `03c_assembly_masurca.sh` | Assembly with MaSuRCA, including generation of the configuration file. |
| `masurca.config` | Standalone MaSuRCA configuration file (same content generated inline by the script above). |

### 04_coverage_assessment

| File | Description |
|---|---|
| `04_coverage_qualimap.sh` | Read alignment (BWA) to the assembled genome and sequencing coverage assessment with Qualimap. |

### 05_repeat_annotation

| File | Description |
|---|---|
| `05a_repeat_annotation_annotep_edta.sh` | Repeat element annotation with EDTA / AnnoTEP, including the TIR re-run and RepeatMasker step for chromosome-level assemblies. |
| `05b_repeat_annotation_repeatmodeler.sh` | De novo repeat family identification with RepeatModeler. |
| `05c_repeat_library_merge_repeatmasker.sh` | Merges the AnnoTEP/EDTA and RepeatModeler libraries, removes redundancy (CD-HIT-EST), reclassifies unknown repeats, and runs the final RepeatMasker annotation. |

### 06_ssr_annotation

| File | Description |
|---|---|
| `06a_ssr_annotation_misa.sh` | General SSR (microsatellite) identification with MISA. |
| `06b_ssr_annotation_qdd.sh` | SSR marker design and validation pipeline with QDD (pipe1-pipe4). |
| `set_qdd_default.config` | QDD default configuration file (`set_qdd_default`) with the parameters used. |

## Dependencies

**External tools** (installed separately, e.g. via conda/bioconda):
- FastQC, Trimmomatic
- Bowtie2
- KmerGenie
- Jellyfish, GenomeScope
- SPAdes, ABySS, MaSuRCA
- BWA, samtools, Qualimap
- EDTA, AnnoTEP, RepeatModeler, RepeatMasker, RepeatClassifier, CD-HIT-EST
- MISA, QDD

## Note on assembly quality

The nuclear genome assembly reported here is fragmented (see the manuscript
for full assembly statistics) and is classified as a genome survey rather
than a chromosome- or scaffold-level reference assembly.

## Citation

If you use these scripts, please cite the associated manuscript (citation to
be added upon publication).
