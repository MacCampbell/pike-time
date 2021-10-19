#To plot FST heatmap
#Mac Campbell
#09102021

library(tidyverse)
library(viridis)

# data frame has na
#pike_FST <- read_tsv("outputs/1401/Alaska_pike_FST.txt") 
#write_tsv(drop_na(pike_FST), "outputs/1401/fst.tsv")

df<-read_tsv("outputs/1401/fst.tsv")

# pop1 and pop2 are characters so ggplot will plot them in alphabetical order, but we want the order in the text file

# as characters
unique(df$pop1)

df$pop1<-factor(df$pop1, levels=unique(df$pop1))

#as factors
unique(df$pop1)

#Explicitly

df$pop2<-factor(df$pop2, levels=c("B", "C", "G", "H", "I", "T", "R", "O", "Q", "S", "F", "D", "E", "J","U"))

ggplot(df,aes(pop2, pop1)) + 
  geom_tile(aes(fill=FST),color = "white") + 
  theme_minimal()+scale_fill_viridis(discrete=FALSE,option = "cividis",space = "Lab",direction = -1) + 
  theme_bw()+theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 10, hjust=1), 
                   panel.border = element_blank(), panel.grid.major = element_blank(), 
                   axis.title.y = element_blank(), axis.title.x = element_blank()) +
  scale_y_discrete(position = "left") + 
  theme(axis.text.y = element_text(size = 10)) + 
  geom_text(aes(label = round(FST,2)), size = 3.5,color = "white") + 
  ggtitle("Fst between populations of pike in Alaska") + 
  theme(plot.title = element_text(face = "bold", size = 16))

ggsave("outputs/1401/FST.jpg")

