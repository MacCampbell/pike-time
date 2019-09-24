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
#Including triallelic SNPS and creating a .vcf 
angsd -P 24 -b bamlists/177.bamlist -ref genome/GCF_000721915.3_Eluc_V3_genomic.fna -dovcf 1 -out outputs/301/177-vcf -minMapQ 30 -minQ 20 -minInd 159 -GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 0 -SNP_pval 1e-6 -doGeno 4 -doPost 1 > outputs/301/301.out 2> outputs/301/301.err





