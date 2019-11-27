#! /bin/bash
# Copied from chinook-wgs, 102-generate-folded-SFS.sh
# A gnu parallel compatible script
# ./902-compute-foldeded-sfs.sh jobs threads genome poplist
# ./902-compute-foldeded-sfs.sh 8 3 GCF_000721915.3_Eluc_V3_genomic.fna bamlist/poplist.txt

# poplist is a file with your pops of interest one to a line, one in bamlists/poplist.txt

jobs=$1
threads=$2
genome=$3
poplist=$4

# Make sure outputs/102 exists
mkdir /home/macampbell2/pike-time/outputs/902/ 2> /home/macampbell2/pike-time/err

# Read poplist, print commands to files

echo "# gnu parallel for saf" > temp1.txt
echo "# gnu parallel for sfs" > temp2.txt

cat $poplist | while IFS=$'\n' read -r line || [[ -n "$line" ]]; do
    echo "Reading poplist file: $line"
# saf line
    echo "/home/macampbell2/angsd/angsd -bam /home/macampbell2/pike-time/bamlists/pops/$line.bamlist -doSaf 1 -out /home/macampbell2/pike-time/outputs/902/$line -anc /home/macampbell2/pike-time/genome/$3 -GL 2 -fold 1 -nThreads $2 -minMapQ 30 -minQ 20" >> /home/macampbell2/pike-time/temp1.txt
# sfs line    
    echo "/home/macampbell2/angsd/misc/realSFS /home/macampbell2/pike-time/outputs/902/$line.saf.idx -maxIter 100 -P $2 > /home/macampbell2/pike-time/outputs/902/$line.sfs" >> /home/macampbell2/pike-time/temp2.txt
done

# kick off gnu parallel, except not on Chinook
bash /home/macampbell2/pike-time/temp1.txt
bash /home/macampbell2/pike-time/temp2.txt

# remove temporary files

"yes" | rm /home/macampbell2/pike-time/temp1.txt
"yes" | rm /home/macampbell2/pike-time/temp2.txt
"yes" | rm /home/macampbell2/pike-time/err
