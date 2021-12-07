library(ggplot2)
library(RColorBrewer)
ggplot(ssr_mean_clade_info, aes(x=Clade_Name,mean)) +
  geom_point(aes(colour =as.factor(Clade_Name))) +
  theme(axis.text.x = element_text(angle = 90, vjust=1, hjust=1)) +
  scale_x_continuous(name = "clade name", breaks = seq(0,10,by =1))+
  
  scale_y_continuous (name = "mean of SSR lengths",
                      breaks=seq(0,25,by=0.5)) +
  scale_color_brewer(palette = "Paired")+
  labs(colour = "CLADES") +
  theme(legend.direction = "horizontal", legend.position = "top")
