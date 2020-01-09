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

angsd -P 24 -b bamlists/175.bamlist -out outputs/700/175 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doVcf 1 -doPost 1 -postCutoff 0.95 > outputs/700/700.1.out 2> outputs/700/700.1.err


angsd -P 24 -b bamlists/175.bamlist -out outputs/700/175maf -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doVcf 1 -doPost 1 -minMaf 0.05 -postCutoff 0.95  > outputs/700/700.1.maf.out 2> outputs/700/700.1.maf.err
