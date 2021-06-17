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

#SBATCH -o outputs/1202/1202.3.stdout


#Step one
#Make sure we have directories
mkdir /home/macampbell2/pike-time/outputs
mkdir /home/macampbell2/pike-time/outputs/1202


# Step two
# The only input PCAngsd needs and accepts are genotype likelihoods in Beagle format.
# ANGSD can be easily be used to compute genotype likelihoods and output them in the
# required Beagle format {says the manual}.

#Considering -P flag here, not sure how to set --ntasks --tasks-per-node and -P here for best performance on Chinook
/home/macampbell2/angsd/angsd -minInd 38 -GL 1 -out /home/macampbell2/pike-time/outputs/1202/small -nThreads 12 -doGlf 2 -doMajorMinor 1 -doMaf 2 \
-SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/42.bamlist 


# -rf /home/macampbell2/pike-time/metadata/chroms.txt


# Step 3
# Generate a covariance matrix and admixture
# For Linux
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1202/small.beagle.gz -admix -o /home/macampbell2/pike-time/outputs/1202/small -threads 12
