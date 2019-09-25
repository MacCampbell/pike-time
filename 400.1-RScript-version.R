#! /usr/local/bin/RScript

#Running the creation of a genind object as a script


library(tidyverse)
library(adegenet)
library(poppr)
library(pegas)
library(genetics)
library(hierfstat)

# Let's load in some data!

genos<-read_tsv(file="outputs/301/177-vcf.geno.gz", col_names = FALSE)
data <-as_tibble(t(genos[3:179]))
loci <- genos %>% dplyr::select(X1, X2) 
loci$X1<-gsub("\\.","_", loci$X1)
loci$X1<-gsub("_","", loci$X1)

loci<- loci %>% dplyr::mutate(Locus=paste(X1, X2, sep="-"))

# We need to include individual/population names
load("outputs/103/pca-meta.rda")
bams <- read_tsv("bamlists/177.bamlist", col_names = FALSE) %>%
  mutate(vcf_name = str_replace_all(X1, pattern = "^data/|AN1711171/|BK1703222/|_sorted.*$", "")) %>%
  mutate(index = 1:n())
ad_meta <- left_join(bams, pca_meta)

# remove spaces
ad_meta <- ad_meta %>% mutate(Name = paste(gsub(Region, pattern=" ",
                                                replacement=""), index, sep="_"))
# Separate Kenai
ad_meta <- ad_meta %>% mutate(Population = ifelse(Site == "StormyLake", "Kenai",
                                                  ifelse(Site == "TinyLake", "Kenai",
                                                         ifelse(Site %in% c("Tyonek", "ShellLake", "AndersonLake",
                                                                            "OtterLake", "BulchitnaLake",
                                                                            "AlexanderLake",
                                                                            "YentnaIndianCreek", "DeshkaRiver"), 
                                                                "AnchorageBowl",
                                                                Site)
                                                  )))

colnames(data)<-loci$Locus


#Make a genind
gdf<-as.loci(data, sep="/", ploidy=2)
genind<-df2genind(gdf, sep="/")
genind@pop<-as.factor(ad_meta$Population)
save(genind, file="outputs/400/genind.rda")