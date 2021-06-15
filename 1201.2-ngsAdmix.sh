#NGS Admix results tend to look "cleaner"

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

#Generate beagle file
/home/macampbell2/angsd/angsd -minInd 317 -GL 1 -out /home/macampbell2/pike-time/outputs/1201/352 -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/352.bamlist

# Run a bunch of NGSAdmix 1:16
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 2 -o outputs/1201/352-ngsadmix-k2 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 3 -o outputs/1201/352-ngsadmix-k3 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 4 -o outputs/1201/352-ngsadmix-k4 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 5 -o outputs/1201/352-ngsadmix-k5 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 6 -o outputs/1201/352-ngsadmix-k6 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 7 -o outputs/1201/352-ngsadmix-k7 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 8 -o outputs/1201/352-ngsadmix-k8 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 9 -o outputs/1201/352-ngsadmix-k9 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 10 -o outputs/1201/352-ngsadmix-k10 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 11 -o outputs/1201/352-ngsadmix-k11 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 12 -o outputs/1201/352-ngsadmix-k12 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 13 -o outputs/1201/352-ngsadmix-k13 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 14 -o outputs/1201/352-ngsadmix-k14 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 15 -o outputs/1201/352-ngsadmix-k15 -P 3
/Users/mac/angsd/misc/NGSadmix -likes outputs/1201/352.beagle.gz -K 16 -o outputs/1201/352-ngsadmix-k16 -P 3
