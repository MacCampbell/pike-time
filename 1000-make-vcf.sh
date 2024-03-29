#! /bin/bash

#SBATCH -J angsd

#SBATCH --partition=bio
#SBATCH --ntasks=24
#SBATCH --tasks-per-node=24
#SBATCH --time=2-01:00:00 #run for two days and an hour
#If running on the bio or analysis queue add:
#SBATCH --mem=214G

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


#Printing individual genotypes
##4: print the called genotype as AA, AC, AG, ...

#Excluding triallelic SNPS and creating a .vcf.
/home/macampbell2/angsd/angsd  -P 24 -b bamlists/175.bamlist -out outputs/1000/175vcf -minMaf 0.05 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doGeno 4 -doPost 1 -postCutoff 0.95 -doVcf 1 > outputs/1000/1000.out 2> outputs/1000/1000.err

# -setMinDepthInd 5
/home/macampbell2/angsd/angsd  -P 24 -b bamlists/175.bamlist -out outputs/1000/175vcf-cov -minMaf 0.05 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doGeno 4 -doPost 1 -setMinDepthInd 5 -postCutoff 0.95 -doVcf 1 > outputs/1000/1000cov.out 2> outputs/1000/1000cov.err

#Excluding trialleic SNPS and creating a .geno.gz

/home/macampbell2/angsd/angsd -P 24 -b bamlists/175.bamlist -out outputs/1000/175geno -minMaf 0.05 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doGeno 4 -doPost 1 -postCutoff 0.95 > outputs/1000/1000.out 2> outputs/1000/1000.err

# -setMinDepthInd 5
/home/macampbell2/angsd/angsd -P 24 -b bamlists/175.bamlist -out outputs/1000/175geno-cov -minMaf 0.05 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -doGeno 4 -doPost 1 -setMinDepthInd 5 -postCutoff 0.95 > outputs/1000/1000.out 2> outputs/1000/1000.err

