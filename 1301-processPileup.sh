#! /bin/bash 


#SBATCH --partition=t1standard
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --time=08:00:00

#If running on the bio or analysis queue add:
##SBATCH --mem=214G

#SBATCH --mail-user=macampbell2@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


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


for line in $(cat ${1}) ;
  do
    echo $line;
#Maybe we don't need all the columns, only 1-4 look useful to me now
#In fact, samtools depth may do the same thing minus the base.
    samtools mpileup -f ${2} $line | cut -f 1-4 > outputs/1300/"`basename $line .sorted.bam`.pileup"
done

for f in outputs/1300/*.pileup;
  do
	  	awk -v thresh=10 '$4 >= thresh {if(on==1) {sum+=$4; n++; next;}  start = $2; on = 1; sum=$4; n=1;} $4<thresh {if(on==0) next; on=0; print $1, start, $2, sum/n}' $f > outputs/1300/"`basename $f .pileup`.dat"
  done


