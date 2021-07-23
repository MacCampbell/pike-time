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
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/wgs.bamlist -rf metadata/regions.tsv

#Generate covariance matrix
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1300/wgs.beagle.gz  -kinship -admix -o /home/macampbell2/pike-time/outputs/1300/wgs -threads 10
