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
#SBATCH -o outputs/data/data-sets-dapc.stdout


# (1) data set of all samples 358 samples, 286.4 ~ 287 at 80 % missing, 95% post cutoff 
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 287 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/358.bamlist \
-out /home/macampbell2/pike-time/outputs/data/358-dapc -doPlink 2 -doCounts 1 -doPost 1 postCutoff 0.95 -doGeno 4

# (2) Southcentral data set

/home/macampbell2/angsd/angsd -minInd 172 -GL 2 -out /home/macampbell2/pike-time/outputs/data/sc-dapc -nThreads 12 -doGlf 2 \
-doMajorMinor 1 -doMaf 1 -minMaf 0.05 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/sc.bamlist.txt \
-doPlink 2 -doCounts 1 -doPost 1 postCutoff 0.95 -doGeno 4

# (3) Anchorage subset
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 68 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/anchorage.bamlist \
-out /home/macampbell2/pike-time/outputs/data/anchorage-dapc \
-doPlink 2 -doCounts 1 -doPost 1 postCutoff 0.95 -doGeno 4

# (4) Susitna subset
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 78 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/susitna.bamlist \
-out /home/macampbell2/pike-time/outputs/data/susitna-dapc \
-doPlink 2 -doCounts 1 -doPost 1 postCutoff 0.95 -doGeno 4

