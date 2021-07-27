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
#SBATCH -o outputs/1300/1300.1.stdout

#Generate beagle file
/home/macampbell2/angsd/angsd -minInd 42 -GL 1 -out /home/macampbell2/pike-time/outputs/1300/wgs -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/wgs.bamlist

#Generate plink file
/home/macampbell2/angsd/angsd -minInd 42 -GL 1 -out /home/macampbell2/pike-time/outputs/1300/plink -nThreads 12 -doPlink 2 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-6 -minMapQ 0 -minQ 20 -minMaf 0.3 -bam home/macampbell2/pike-time/bamlists/wgs.bamlist \
-doGeno 4 -doPost 1 -postCutoff 0.95  > $HOME/pike-time/outputs/1300/plink.out \
2> $HOME/pike-time/outputs/1300/plink.err

#Generate covariance matrix
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1300/wgs.beagle.gz -minMaf 0.3 -kinship -admix -o /home/macampbell2/pike-time/outputs/1300/wgs -threads 10
