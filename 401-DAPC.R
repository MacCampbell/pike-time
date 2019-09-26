library(adegenet)
library(tidyverse)
load(file="outputs/400/genind.rda")

dapc<-dapc(genind, n.pca=175, var.contrib = TRUE, n.da=nPop(genind)-1)
pdf("outputs/401/dapc-location-as-prior.pdf")
scatter(dapc)
dev.off()

grp <- find.clusters(genind, max.n.clust = 30, n.pca=125)

assign<-dapc(genind, n.pca=175, var.contrib = TRUE, n.da=length(levels(grp$grp))-1, pop=grp$grp)

pdf("outputs/401/assign-plot.pdf", height=20, width=11)
assignplot(assign)
dev.off()

table.value(table(assign$assign, pop(genind)), col.lab=levels(pop(genind)))
df<-as.data.frame(table(assign$assign, pop(genind)), col.lab=levels(pop(genind))) %>% filter(Freq > 0)

df$Var2<- factor(df$Var2, levels=c("AntlinRiver","EagleLake", "AnchorageBowl", "Kenai",
                                       "Fairbanks","MintoFlats","YukonFlats", "Selawik",
                                       "NorthSlope","LakeClark", "LakeNerka"))        
ggplot(df, aes(Var1, Var2))+
  theme(axis.title.y = element_text(size = rel(2)))+
  theme(axis.title.x = element_text(size = rel(2)))+
  theme(axis.text.x = element_text(angle = 90))+
  labs(x="\nInferred Group", y="Sampling Location\n")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  theme(text=element_text(family='Times'))+
  theme(axis.text.x= element_text(face="bold", size=10, vjust = 0.5))+
  theme(axis.text.y= element_text(face="bold", size=10))+
  geom_point(aes(x=Var1, y=Var2, size=Freq))+
  scale_size_area(limits=c(1,50), breaks=c(1,5,10,25,50))+
  labs(size="Number\nof Individuals")

ggsave("outputs/401/assign-plot-ggplot.pdf")