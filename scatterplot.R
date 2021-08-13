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

