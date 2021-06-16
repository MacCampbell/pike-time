#! /bin/bash

#SBATCH --partition=bio
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#If running on the bio or analysis queue add:
#SBATCH --mem=214G

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

#SBATCH -o outputs/1202/1202.2.stdout

#Looking to find beagle sites we can use more broadly as a region file or subset of a more relaxed file (1202.1)
/home/macampbell2/angsd/angsd -minInd 18 -GL 1 -out /home/macampbell2/pike-time/outputs/1202/outgroup -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/outgroup.bamlist -minMaf 0

