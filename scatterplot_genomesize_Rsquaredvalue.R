library(ggplot2)
library(ggpmisc)
my.formula <- y ~ x
ggplot(ssr_mean_genome_size, aes(Genome_size,mean)) +
  geom_smooth(method = "lm", se=FALSE, color="black", formula = my.formula) +
  stat_poly_eq(formula = my.formula, 
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               parse = TRUE) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, vjust=1, hjust=1)) +
  scale_y_continuous (name = "mean of SSR lengths",
                      breaks=seq(0,25,by=0.5))
  
                      