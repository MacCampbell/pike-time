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

#Printing individual genotypes
##4: print the called genotype as AA, AC, AG, ...
#Including triallelic SNPS and creating a .vcf.
#Experience seg fault. Removing -doVcf 1 and just using -doGeno 4 
angsd -P 24 -b bamlists/175.bamlist -ref genome/GCF_000721915.3_Eluc_V3_genomic.fna -out outputs/301/175 -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 0 -SNP_pval 1e-6 -doGeno 4 -doPost 1 > outputs/301/301.out 2> outputs/301/301.err

# -setMinDepthInd 5
angsd -P 24 -b bamlists/175.bamlist -ref genome/GCF_000721915.3_Eluc_V3_genomic.fna -out outputs/301/175cov -minMapQ 30 -minQ 20 -minInd 157 -GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 0 -SNP_pval 1e-6 -doGeno 4 -doPost 1 -setMinDepthInd 5 > outputs/301/301cov.out 2> outputs/301/301cov.err




