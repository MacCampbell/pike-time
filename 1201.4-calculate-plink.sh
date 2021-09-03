#! /bin/bash

#SBATCH --partition=bio
#SBATCH --ntasks=24
#SBATCH --tasks-per-node=24
#If running on the bio or analysis queue add:
#SBATCH --mem=214G

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL



#Step one
#Make sure we have directories
#mkdir /home/macampbell2/pike-time/outputs
#mkdir /home/macampbell2/pike-time/outputs/1201

/home/macampbell2/angsd/angsd -minInd 322 -GL 1 -out /home/macampbell2/pike-time/outputs/1201/358-plink -nThreads 24 -doGlf 2 -doMajorMinor 1 \
-doMaf 2 -minMaf 0.05 -doGeno 4 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/358.bamlist -doPlink 2 -doCounts 1 -doPost 1 \
-postCutoff 0.9

