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
mkdir /home/macampbell2/pike-time/outputs
mkdir /home/macampbell2/pike-time/outputs/102


# Step two
# The only input PCAngsd needs and accepts are genotype likelihoods in Beagle format.
# ANGSD can be easily be used to compute genotype likelihoods and output them in the
# required Beagle format {says the manual}.

#Do the calculations (putting in absolute paths). Making sure sites are present in 90% of individuals.
/home/macampbell2/angsd/angsd -minInd 177 -GL 1 -out /home/macampbell2/pike-time/outputs/102/197 -nThreads 24 -doGlf 2 -doMajorMinor 1  -doMaf 2 -SNP_pval 1e-6 -bam /home/macampbell2/pike-time/bamlists/197.txt

# Step 3
# Generate a covariance matrix
# For Linux
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/102/197.beagle.gz -admix -o /home/macampbell2/pike-time/outputs/102/197

# admixture proportions are in .qopt
# covariance matrix is .cov
