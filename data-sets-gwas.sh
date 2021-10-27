#! /bin/bash

#SBATCH --partition=bio
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#If running on the bio or analysis queue add:
#SBATCH --mem=214G
#SBATCH --time=1-20:05:00

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o outputs/data/gwas.stdout


/home/macampbell2/angsd/angsd -GL 1 -nThreads 8 -minInd 322 -doMajorMinor 1 -doMaf 2 -minMaf 0.05 -doGeno 2 -SNP_pval 1e-5 \
-minMapQ 20 -minQ 20 -doPlink 2 -doCounts 1 -doPost 1 \
-bam /home/macampbell2/pike-time/bamlists/358.bamlist -out /home/macampbell2/pike-time/outputs/data/358-gwas


