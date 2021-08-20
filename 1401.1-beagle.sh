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
#SBATCH -o outputs/1401/1401.1.stdout

#Generate beagle file
#cat pike_bams_list.txt | perl -pe 's/\/Users\/mchale\/Desktop\/pike_//g' > sc.bamlist.txt

/home/macampbell2/angsd/angsd -minInd 172 -GL 1 -out /home/macampbell2/pike-time/outputs/1401/sc -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 -minMaf 0.05 \
-SNP_pval 1e-5 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/sc.bamlist.txt


##Generate covariance matrix
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1401/sc.beagle.gz -kinship -admix -selection -sites_save -snp_weights -o /home/macampbell2/pike-time/outputs/1401/sc-pca -threads 10

#Do again with related individuals
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1401/sc.beagle.gz  -relate /home/macampbell2/pike-time/outputs/1401/sc-pca.kinship.npy  -admix -selection -sites_save -snp_weights -o /home/macampbell2/pike-time/outputs/1401/sc-pca-relate -threads 12

