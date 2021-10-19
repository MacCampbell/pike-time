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
#SBATCH -o outputs/1401/1401.3.stdout

#CMD ./angsd -nThreads 12 -out Pike_SC_AK2 -doMaf 2 -minMaf 0.05 -minInd 155 -doPost 1 -bam pike_bams_list.txt -doMajorMinor 1 -snp_pval 1e-5 -doGeno 2 -GL 1 
#-minQ 20 -minMapQ 20 -doPlink 2 -doCounts 1

#./angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -minMaf 0.05 -doMaf 1
#-minInd flag @ 0.8

/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 68 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/pike_anchorage_bams_list.txt \
-out /home/macampbell2/pike-time/outputs/1401/pike_anchorage_bams_list

/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 78 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/pike_susitna_bams_list copy.txt \
-out /home/macampbell2/pike-time/outputs/1401/pike_susitna_bams_list



