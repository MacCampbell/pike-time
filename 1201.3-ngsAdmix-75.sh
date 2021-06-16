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
#SBATCH -o outputs/1201/1201.3.stdout

#Generate beagle file
/home/macampbell2/angsd/angsd -minInd 264 -GL 1 -out /home/macampbell2/pike-time/outputs/1201/352-75 -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/352.bamlist

#Generate covariance matrix
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/352-75.beagle.gz  -kinship -admix -o /home/macampbell2/pike-time/outputs/1201/352-75 -threads 10

#Do it again with covariance matrix Needs to be run again
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/352-75.beagle.gz  \
-relate /home/macampbell2/pike-time/outputs/1201/352-75.kinship.npy  -admix -o /home/macampbell2/pike-time/outputs/1201/352-75-relate -threads 24


# Run a bunch of NGSAdmix 1:16
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 2 -o outputs/1201/352-75-ngsadmix-k2 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 3 -o outputs/1201/352-75-ngsadmix-k3 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 4 -o outputs/1201/352-75-ngsadmix-k4 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 5 -o outputs/1201/352-75-ngsadmix-k5 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 6 -o outputs/1201/352-75-ngsadmix-k6 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 7 -o outputs/1201/352-75-ngsadmix-k7 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 8 -o outputs/1201/352-75-ngsadmix-k8 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 9 -o outputs/1201/352-75-ngsadmix-k9 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 10 -o outputs/1201/352-75-ngsadmix-k10 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 11 -o outputs/1201/352-75-ngsadmix-k11 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 12 -o outputs/1201/352-75-ngsadmix-k12 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 13 -o outputs/1201/352-75-ngsadmix-k13 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 14 -o outputs/1201/352-75-ngsadmix-k14 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 15 -o outputs/1201/352-75-ngsadmix-k15 -P 3
$HOME/angsd/misc/NGSadmix -likes outputs/1201/352-75.beagle.gz -K 16 -o outputs/1201/352-75-ngsadmix-k16 -P 3
