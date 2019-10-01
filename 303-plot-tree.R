library(tidyverse)
library(ggtree)

tree<-read.tree(file="outputs/302/175.phy.con.tree")

df<-as_tibble(as.data.frame(cbind(tree$tip.label))) %>%
  rename(Tip = V1) %>%
  mutate(Region = gsub("_\\d+", "", Tip))

# get meta
load("outputs/103/pca-meta.rda")
bams <- read_tsv("bamlists/175.bamlist", col_names = FALSE) %>%
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


#dtree<-ggtree(tree, layout="daylight")
#save(dtree, file="outputs/303/dtree.rda")

load(file="outputs/303/dtree.rda")
d <- dtree$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label > 90,]

dt<-dtree %<+% df + geom_point(data=d, alpha=0.5, cex=3) +
  geom_tippoint(aes(shape=Region, angle=angle, fill=Region), cex=4) +
  scale_shape_manual(values=c(24,21,21,22,22,22,23)) 

ggsave("outputs/303/iqtree.daylight.pdf", width=7, height=5.5)