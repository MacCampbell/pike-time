#! /usr/local/bin/Rscript
# Creates a file with population labels 

library(tidyverse)

bams <- read_tsv("./bamlists/test.txt", col_names = FALSE) %>%
  mutate(vcf_name = str_replace_all(X1, pattern = "^data/|AN1711171/|BK1703222/|_sorted.*$", "")) %>%
  mutate(index = 1:n())


#meta
load("outputs/101/samples-to-analyze.rda")
meta<-samples %>% mutate(vcf_name=`RAD identifier`)

# meta data in the order that the are in the bamlist
ad_meta <- left_join(bams, meta, by = "vcf_name")

# remove spaces
ad_meta <- ad_meta %>% mutate(NewPops = paste(gsub(Region, pattern=" ",
                                                   replacement=""), index, sep="_"))
write_csv(as.data.frame(ad_meta$NewPops), path="./outputs/201/popdata.txt",
          col_names=FALSE)
