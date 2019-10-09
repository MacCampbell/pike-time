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
/home/macampbell2/bin/paup4a166_centos64 /home/macampbell2/pike-time/data/175.nex
/home/macampbell2/bin/paup4a166_centos64 /home/macampbell2/pike-time/data/175maf.nex