library(adegenet)
library(tidyverse)
load(file="outputs/400/genMaf.rda")
genind<-genMaf
genind<-genind[genind@pop %in% c("MintoFlats", "YukonFlats", "Fairbanks","AnchorageBowl", "Kenai",
                                 "LakeClark","LakeNerka", "NorthSlope", "Selawik")]
#dapc<-dapc(genind, n.pca=175, var.contrib = TRUE, n.da=nPop(genind)-1)
#pdf("outputs/401/dapc-location-as-prior.pdf")
#scatter(dapc)
#dev.off()
pcs<-150
grp <- find.clusters(genind, max.n.clust = 20, n.pca=pcs)

assign<-dapc(genind, var.contrib = TRUE, n.pca=pcs, n.da=length(levels(grp$grp))-1, pop=grp$grp)

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

df2<-as_tibble(assign$posterior) %>% mutate(Population=genind@pop) %>% mutate(Individual = row_number())
df3<-df2 %>% arrange(Population) %>% mutate(Index= row_number()) %>% gather(K, Q, 1:4)
df3$Population<- factor(df3$Population, levels=c("AntlinRiver","EagleLake",
                                                         "MintoFlats","YukonFlats",
                                                         "Fairbanks", "AnchorageBowl",
                                                         "Kenai","LakeClark","LakeNerka",
                                                         "NorthSlope","Selawik"))
df4<-df3 %>% arrange(factor(Population, levels = c("AntlinRiver","EagleLake",
                                                   "MintoFlats","YukonFlats",
                                                   "Fairbanks", "AnchorageBowl",
                                                   "Kenai","LakeClark","LakeNerka",
                                                   "NorthSlope","Selawik")))
ggplot(df4)+geom_col(aes(x=Index, y=Q, fill=K))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  scale_fill_brewer(palette ="Spectral")+
  facet_wrap(. ~ Population, ncol=4, scales="free_x")

ggsave("outputs/400/posterior-plot.pdf")