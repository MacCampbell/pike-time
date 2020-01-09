#! /bin/bash
angsd -P 4 -b bamlists/test.bamlist -minInd 3  -out outputs/1000/plink \
-minMaf 0.05 -minMapQ 30 -minQ 20 -GL 1 -doMajorMinor 1 -doMaf 1 \
-SNP_pval 1e-6 -doGeno 4 -doPost 1 -postCutoff 0.95 -doPlink 2 > outputs/1000/test.out \
2> outputs/1000/test.err