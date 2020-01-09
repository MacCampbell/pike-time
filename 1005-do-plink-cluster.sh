#! /bin/bash

#This one is to just make a single *.vcf file.

#SBATCH -J plink1

#SBATCH --partition=bio
#SBATCH --ntasks=24
#SBATCH --tasks-per-node=24
#SBATCH --time=8:00:00 #run for eight hours
#If running on the bio or analysis queue add:
#SBATCH --mem=214G

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

$HOME/angsd/angsd -P 24 -b $HOME/pike-time/bamlists/175.bamlist -minInd 157  -out $HOME/pike-time/outputs/1000/175-plink1 \
-minMaf 0.05 -minMapQ 30 -minQ 20 -GL 1 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-6 -doGeno 4 -doPost 1 -postCutoff 0.95 -doPlink 1 > $HOME/pike-time/outputs/1000/plink1.out \
2> $HOME/pike-time/outputs/1000/plink1.err

#Then maybe I can recode
# https://www.cog-genomics.org/plink/1.9/data#recode
# plink --ped my.ped --map my.map \
#      --recode vcf \
 #     --out my
