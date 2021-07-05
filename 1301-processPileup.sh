#! /bin/bash 


#Setting up for Chinook
#It may be best to read in a bamlist, then do the processes and make the genome general.
# 1301-processPileup.sh bamlist.bamlist genome.fasta
# 1301-processPileup.sh bamlists/36.bamlist genome/GCF_000721915.3_Eluc_V3_genomic.fna

list=$1
ref=$2

#for f in *.sorted.bam;
#	do
#		samtools mpileup -f /home/mac/data/OmyGenomeV06/omyV6Chr.fasta  $f > "`basename $f .sorted.bam`.pileup"
#	done
for line in $1 ;
do 
  samtools mpileup -f ${2} $line > outputs/1300/"`basename $line .sorted.bam`.pileup"
done

#for f in *.pileup;
#	do
#		awk -v thresh=10 '$4 >= thresh {if(on==1) {sum+=$4; n++; next;}  start = $2; on = 1; sum=$4; n=1;} $4<thresh {if(on==0) next; on=0; print $1, start, $2, sum/n}' $f > "`basename $f .pileup`.dat"
#	done


