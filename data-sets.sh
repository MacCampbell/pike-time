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
#SBATCH -o outputs/data/data.stdout


#create bamlists 
#cat bamlists/pike_anchorage_bams_list.txt | perl -pe 's/\/Users.*pike_bams\//bams\//g' > bamlists/anchorage.bamlist
#cat bamlists/pike_susitna_bams_list\ copy.txt | perl -pe 's/\/Users.*pike_bams\//bams\//g' > bamlists/susitna.bamlist
#cat pike_bams_list.txt | perl -pe 's/\/Users\/mchale\/Desktop\/pike_//g' > sc.bamlist.txt


# (1) data set of all samples 358 samples, 286.4 ~ 287 at 80 % missing
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 287 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/358.bamlist \
-out /home/macampbell2/pike-time/outputs/data/358

# (2) data set of all samples 358 samples, for phylogenetics. 90% missing thresh
/home/macampbell2/angsd/angsd -nThreads 8 -minInd 322 -GL 2 -doGlf 2 -doMajorMinor 1 \
-doMaf 2 -minMaf 0.05 -doGeno 4 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 \
-bam /home/macampbell2/pike-time/bamlists/358.bamlist -doPlink 2 -doCounts 1 -doPost 1 \
-postCutoff 0.95 \
-out /home/macampbell2/pike-time/outputs/data/358-phylo 

# (3) Southcentral data set

/home/macampbell2/angsd/angsd -minInd 172 -GL 2 -out /home/macampbell2/pike-time/outputs/data/sc -nThreads 12 -doGlf 2 \
-doMajorMinor 1 -doMaf 2 -minMaf 0.05 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/sc.bamlist.txt

# (3) Anchorage subset
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 68 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/anchorage.bamlist \
-out /home/macampbell2/pike-time/outputs/data/anchorage

# (4) Susitna subset
/home/macampbell2/angsd/angsd -GL 2 -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minInd 78 \
-minMaf 0.05 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/susitna.bamlist \
-out /home/macampbell2/pike-time/outputs/data/susitna



