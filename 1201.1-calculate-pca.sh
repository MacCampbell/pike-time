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
mkdir /home/macampbell2/pike-time/outputs/1201


# Step two
# The only input PCAngsd needs and accepts are genotype likelihoods in Beagle format.
# ANGSD can be easily be used to compute genotype likelihoods and output them in the
# required Beagle format {says the manual}.

#Do the calculations (putting in absolute paths). Making sure sites are present in 90% of individuals.
#Considering -P flag here, not sure how to set --ntasks --tasks-per-node and -P here for best performance on Chinook
/home/macampbell2/angsd/angsd -minInd 322 -GL 1 -out /home/macampbell2/pike-time/outputs/1201/358 -nThreads 24 -doGlf 2 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -bam /home/macampbell2/pike-time/bamlists/358.bamlist

# Step 3
# Generate a covariance matrix and calculate kinship coefficient
# For Linux
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/358.beagle.gz  -kinship -admix -o /home/macampbell2/pike-time/outputs/1201/358 -threads 24
#Can do like this:
#srun -p t1small -t 1:00:00 --mem=8G --nodes=1 python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/358.beagle.gz  -kinship -admix -o /home/macampbell2/pike-time/outputs/1201/358 -threads 5


# admixture proportions are in .qopt
# covariance matrix is .cov
# kinship matrix is .kinship.npy

# Step 4 point to kinship and do it again
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/358.beagle.gz  \
-relate /home/macampbell2/pike-time/outputs/1201/358.kinship.npy  -admix -o /home/macampbell2/pike-time/outputs/1201/358-relate -threads 24

# Step 5 check out an altered minMaf
python /home/macampbell2/pcangsd/pcangsd.py -beagle /home/macampbell2/pike-time/outputs/1201/358.beagle.gz  \
-relate /home/macampbell2/pike-time/outputs/1201/358.kinship.npy  -admix -o /home/macampbell2/pike-time/outputs/1201/358-relate-minmaf01 -threads 24 -minMaf .01
