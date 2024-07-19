#the Pearson correlation coefficient is used to show the relation between the mean of SSR region and the genome size 
#excel file has two columns "Genome_size" and "mean" representing the genome size of the organism isolate and the mean of the
#SSR region respectively.
library(ggplot2)
library(ggpubr)
library(readxl)

ssr_mean_genome_size <- read_excel("ssr_mean_genome_size.xlsx")
ggscatter(ssr_mean_genome_size, x = "Genome_size", y = "mean",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE,  cor.coef.size = 4,  cor.method = "pearson",
          xlab = "Genome sizes", ylab = "Means of SSR lengths") +
  scale_y_continuous (breaks=seq(0,25,by=0.5)) +
  ggtitle("means of ssr lengths vs genome sizes (with Pearson's Correlation
  Coefficient added) ")

