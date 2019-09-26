library(tidyverse)
library(ggtree)

tree<-read.tree(file="outputs/302/177.phy.con.tree")

df<-as_tibble(as.data.frame(cbind(tree$tip.label))) %>%
  rename(Tip = V1) %>%
  mutate(Region = gsub("_\\d+", "", Tip))

# get meta
load("outputs/103/pca-meta.rda")
bams <- read_tsv("bamlists/177.bamlist", col_names = FALSE) %>%
  mutate(vcf_name = str_replace_all(X1, pattern = "^data/|AN1711171/|BK1703222/|_sorted.*$", "")) %>%
  mutate(index = 1:n())
ad_meta <- left_join(bams, pca_meta)

# remove spaces
ad_meta <- ad_meta %>% mutate(Tip = paste(gsub(Region, pattern=" ",
                                                   replacement=""), index, sep="_"))

df<-left_join(df, ad_meta)

t1<-ggtree(tree, layout="equal_angle") 

#Reordering for plotting
df$Region<- factor(df$Region, levels=c("Southeast","Southcentral", "Southwest", "Interior", "Northwest",
                                                   "North","Midwest"))        

 


t1 %<+% df + geom_tippoint(aes(shape=Region, angle=angle, fill=Region), cex=4) +  scale_shape_manual(values=c(24,21,22,22,22,22,23)) +
  geom_treescale(x=0, y=-.1)
ggsave("outputs/303/iqtree.pdf")

ggtree(tree) %<+% df + geom_tippoint(aes(shape=Region, angle=angle, fill=Region), cex=4) +
                       geom_tiplab(aes(label=Site), align=TRUE, linetype = "dashed", linesize=0.3, size=3) +
                       scale_shape_manual(values=c(24,21,22,22,22,22,23)) + geom_nodelab2() +
                       xlim(0,0.25)+
                       geom_treescale()

ggsave("outputs/303/iqtree.rectangular.pdf", width=11, height=22)
