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
/home/macampbell2/pike-time//902-compute-foldeded-sfs.sh 8 3 GCF_000721915.3_Eluc_V3_genomic.fna bamlist/poplist.txt