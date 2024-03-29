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
#SBATCH -o outputs/1400/1400.1.stdout


#Generate plink file
#/home/macampbell2/angsd/angsd -minInd 42 -GL 1 -out /home/macampbell2/pike-time/outputs/1300/plink -nThreads 12 -doPlink 2 -doMajorMinor 1 -doMaf 1 \
#-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -minMaf 0.3 -bam /home/macampbell2/pike-time/bamlists/wgs.bamlist \
#-doGeno 4 -doPost 1 -postCutoff 0.95  > $HOME/pike-time/outputs/1300/plink.out \
#2> $HOME/pike-time/outputs/1300/plink.err

/home/macampbell2/angsd/angsd -minInd 132 -GL 1 -out /home/macampbell2/pike-time/outputs/1400/plink -nThreads 12 -doPlink 2 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -minMaf 0.3 -bam /home/macampbell2/pike-time/bamlists/wgs-phy.bamlist \
-doGeno 4 -doPost 1 -postCutoff 0.95  > $HOME/pike-time/outputs/1400/plink.out \
2> $HOME/pike-time/outputs/1400/plink.err

#A more relaxed version
/home/macampbell2/angsd/angsd -minInd 125 -GL 1 -out /home/macampbell2/pike-time/outputs/1400/plink2 -nThreads 12 -doPlink 2 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-2 -minMapQ 20 -minQ 20 -minMaf 0.3 -bam /home/macampbell2/pike-time/bamlists/wgs-phy.bamlist \
-doGeno 4 -doPost 1 -postCutoff 0.9  > $HOME/pike-time/outputs/1400/plink2.out \
2> $HOME/pike-time/outputs/1400/plink2.err