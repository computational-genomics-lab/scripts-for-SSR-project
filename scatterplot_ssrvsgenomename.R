#a scatterplot of mean length of SSR vs the genome name of the 128 isolates was plotted. Each of the 128 genomic isolates were 
#coloured differently on the basis of the clade to which they belong
library(ggplot2)
install.packages("RColorBrewer")
library(RColorBrewer)
ggplot(ssr, aes(x=Genome_name,mean)) +
  geom_point(aes(colour =as.factor(Clade_Name))) +
  theme(axis.text.x = element_text(angle = 90, vjust=1, hjust=1)) +
  
  scale_y_continuous (name = "mean of SSR lengths",
                      breaks=seq(0,25,by=0.5)) +
  labs(colour = "CLADE NAME")+
  scale_color_brewer(palette = "Paired")+
  theme(legend.direction = "horizontal", legend.position = "top")

