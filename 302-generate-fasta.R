library(tidyverse)

genos<-read_tsv(file="outputs/301/177-vcf.geno.gz", col_names = FALSE)
#Load pca_meta
labels<-read_tsv(file="outputs/201/popdata.txt", col_names = FALSE)

seq<-select(genos, -1:-2)
colnames(seq)<-labels$X1
seq<-seq[1:177]

#Hmm, I can do this with lapply tediously...

seq<-lapply(seq, function(x) { gsub("AA", "A", x) } )
seq<-lapply(seq, function(x) { gsub("GG", "G", x) } )
seq<-lapply(seq, function(x) { gsub("CC", "C", x) } )
seq<-lapply(seq, function(x) { gsub("TT", "T", x) } )

#IUPAC Ambigs 
#M	A or C
seq<-lapply(seq, function(x) { gsub("AC", "M", x) } )
seq<-lapply(seq, function(x) { gsub("CA", "M", x) } )

#R	A or G	
seq<-lapply(seq, function(x) { gsub("AG", "R", x) } )
seq<-lapply(seq, function(x) { gsub("GA", "R", x) } )

#W	A or T	
seq<-lapply(seq, function(x) { gsub("AT", "W", x) } )
seq<-lapply(seq, function(x) { gsub("TA", "W", x) } )

#S	C or G	
seq<-lapply(seq, function(x) { gsub("CG", "S", x) } )
seq<-lapply(seq, function(x) { gsub("GC", "S", x) } )

#Y	C or T	
seq<-lapply(seq, function(x) { gsub("CT", "Y", x) } )
seq<-lapply(seq, function(x) { gsub("TC", "Y", x) } )

#K	G or T
seq<-lapply(seq, function(x) { gsub("GT", "K", x) } )
seq<-lapply(seq, function(x) { gsub("TG", "K", x) } )

conv<-as.data.frame(seq)
trans<-t(conv)
rownames(trans)<-paste(paste(rownames(trans), "\t", sep="\t"))

write.table(trans, file="outputs/302/177.phy", quote = FALSE, sep="", row.names = TRUE, col.names=FALSE)

#Does require a little annotation to get the final phylip format (inds/sites)