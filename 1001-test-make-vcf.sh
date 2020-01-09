#! /bin/bash

#Here is a file to see if I can make a *.vcf locally
#Using angsd version: 0.921-11-g20b0655

#Three tester bams
#A-026_sorted.bam
#B-021_sorted.bam
#C-021_sorted.bam

angsd -P 4 -b bamlists/test.bamlist -minInd 3  -out outputs/1000/test \
-minMaf 0.05 -minMapQ 30 -minQ 20 -GL 1 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-6 -doGeno 4 -doPost 1 -postCutoff 0.95 -doVcf 1 > outputs/1000/test.out \
2> outputs/1000/test.err

#it works, muahhahahahahaha