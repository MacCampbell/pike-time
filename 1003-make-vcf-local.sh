#! /bin/bash

#On my mac mini: 

angsd -P 4 -b bamlists/175.bamlist -minInd 157 -out outputs/1000/175 -doVcf 1 \
-doMajorMinor 1 -doPost 1 -GL 1 -doMaf 1 \
-minMaf 0.05 -minMapQ 30 -minQ 20  \
-SNP_pval 1e-6 -doGeno 4  -postCutoff 0.95 \
> outputs/1000/vcf.out \
2> outputs/1000/vcf.err

