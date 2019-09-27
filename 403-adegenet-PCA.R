library(adegenet)
library(tidyverse)
library(ggrepel)
library(poppr)
load(file="outputs/400/genind.rda")

#f1<-missingno(genind, type="loci")
#f2<-missingno(f1, type="genotype")
  
X <- tab(genind, NA.method="mean")

## make PCA
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE)

df<-as_tibble(cbind(pca1$li))
df$Pop<-genind@pop

df<- df %>% mutate(Region = ifelse(Pop == "AntlinRiver", "Southeast",
                              ifelse(Pop %in% c("AnchorageBowl", "Kenai"), "Southcentral",
                              ifelse(Pop == "EagleLake", "Midwest",
                              ifelse(Pop %in% c("Fairbanks", "MintoFlats","YukonFlats"), "Interior",
                              ifelse(Pop %in% c("LakeClark","LakeNerka"), "Southwest",
                              ifelse(Pop == "NorthSlope", "North",
                              ifelse(Pop == "Selawik", "Northwest", "NA" ))))))))

df$Region<- factor(df$Region, levels=c("Southeast","Southcentral", "Southwest", "Interior", "Northwest",
                                           "North","Midwest"))        


ggplot(df, aes(x = Axis2, y = Axis1, fill = Region, shape= Region)) +
  geom_point(size = 2) +
  scale_fill_discrete(na.value = "white") + 
  theme_bw()+
  theme(panel.grid=element_blank())+
  xlab("PC X")+
  ylab("PC Y")+
  scale_shape_manual(values=c(24,21,21,22,22,22,23))

ggsave("outputs/403/genotype-call-pca.pdf")
sub <- df %>% filter(Region =="Southwest") %>% mutate(Rank=row_number())

ggplot(sub, aes(x=Axis2, y=Axis1))+geom_point()+geom_label_repel(aes(label=Rank))

#Looks like samples 35 and 37 here are troublesome.