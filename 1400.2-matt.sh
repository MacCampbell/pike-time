#! /bin/bash

#SBATCH --partition=bio
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#If running on the bio or analysis queue add:
#SBATCH --mem=214G

#SBATCH --time=0-20:05:00
#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o outputs/1400/1400.2.stdout

#CMD ./angsd -nThreads 12 -out Pike_SC_AK2 -doMaf 2 -minMaf 0.05 -minInd 155 -doPost 1 -bam pike_bams_list.txt -doMajorMinor 1 -snp_pval 1e-5 -doGeno 2 -GL 1 -minQ 20 -minMapQ 20 -doPlink 2 -doCounts 1
/home/macampbell2/angsd/angsd -nThreads 12 -out outputs/1400/Pike_SC_AK2 -doMaf 2 -minMaf 0.05 -minInd 155 -doPost 1 \
-bam bamlists/pike_bams_list_all.txt -doMajorMinor 1 -snp_pval 1e-5 -doGeno 2 -GL 1 -minQ 20 -minMapQ 20 -doPlink 2 -doCounts 1