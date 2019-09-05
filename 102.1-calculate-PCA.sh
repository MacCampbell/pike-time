#! /bin/bash

#SBATCH --partition=debug
#SBATCH --ntasks=24
#SBATCH --tasks-per-node=24
#If running on the bio or analysis queue add:
#SBATCH --mem=214G


bamlist=197.txt
threads=24

#Step one
#Make sure we have directories
mkdir outputs
mkdir outputs/102


# Step two
# The only input PCAngsd needs and accepts are genotype likelihoods in Beagle format.
# ANGSD can be easily be used to compute genotype likelihoods and output them in the
# required Beagle format {says the manual}.

#Do the calculations (putting in absolute paths)
/home/macampbell2/angsd/angsd -GL 1 -out ./outputs/102/`basename $1 .bamlist` -nThreads $threads -doGlf 2 -doMajorMinor 1  -doMaf 2 -SNP_pval 1e-6 -bam ./bamlists/$bamlist

# Step 3
# Generate a covariance matrix
# For Linux
python /home/macampbell2/pcangsd/pcangsd.py -beagle ./outputs/102/`basename $1 .bamlist`.beagle.gz -admix -o ./outputs/102/`basename $1 .bamlist`

# admixture proportions are in .qopt
# covariance matrix is .cov
