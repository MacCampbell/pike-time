#! /bin/bash 
# The goal is generate a phylogenetic tree of all our populations 
# Starting with ngsDist
# https://github.com/fgvieira/ngsDist
# Following a tutorial
# https://github.com/mfumagalli/ngsTools/blob/master/TUTORIAL.md
# needed FastME
# conda config --add channels bioconda
# conda install fastme

# working test command
# ./106-tree.sh 3 all-pops ./genome/Otsh_v1.0_genomic.fna 2
# ./201-fastme.sh 4 177 genome/GCF_000721915.3_Eluc_V3_genomic.fna 100
threads=$1
bamlist=$2
reference=$3
bootreps=$4 # we'd probably like this to be 1000 

mkdir ./outputs/201/

# Need a pop label file. This can be generated from a .bamlist and metadata, note this is hard coded.
Rscript 201.1-generate-poplabels.R $bamlist

# Genotype probabilities (probably is redundant and time consuming, but
# let's do it like they do at first).
#  Working command to do one chromo
#angsd -P 3 -b ./bamlists/test.bamlist -r NC_025968.3: -ref genome/GCF_000721915.3_Eluc_V3_genomic.fna -out outputs/201/test -minMapQ 30 -minQ 20 -minInd 5 -GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 1 -SNP_pval 1e-6 -doGeno 8 -doPost 1 &> /dev/null

#
#angsd -P $threads -b bamlists/$bamlist.bamlist -ref $reference -out outputs/201/$bamlist -minMapQ 30 -minQ 20 -minInd 159 -GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 1 -SNP_pval 1e-6 -doGeno 8 -doPost 1 &> /dev/null

# How many sites?
# sites=`zcat ./outputs/106/$bamlist.mafs.gz | tail -n+2 | wc -l`
# On my Mac
sites=`gzcat ./outputs/201/$bamlist.mafs.gz | tail -n+2 | wc -l`
echo $sites

# How many individuals?
a=($(wc ./outputs/201/popdata.txt))
inds=${a[0]}
echo $inds

# Compute pairwise distances
ngsDist -verbose 1 -geno ./outputs/201/$bamlist.geno.gz -probs -n_ind $inds -n_sites $sites -labels ./outputs/201/popdata.txt -o ./outputs/201/$bamlist.dist -n_threads $threads &> /dev/null

# Make a tree 
fastme -D 1 -i ./outputs/201/$bamlist.dist -o ./outputs/201/$bamlist.tree -m n -n b &> /dev/null

## Bootstrap
# not sure what to do about this option at the moment -boot_block_size 20
ngsDist -verbose 1 -geno ./outputs/201/$bamlist.geno.gz -probs -n_ind $inds -n_sites $sites -labels ./outputs/201/popdata.txt -o ./outputs/201/$bamlist.boot.dist -n_threads $threads -n_boot_rep $bootreps -boot_block_size 20 &> /dev/null
