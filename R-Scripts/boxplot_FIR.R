#the script creates a boxplot of all the column values in dataset 


library(ggplot2)

fill <- "gold1"
line <- "goldenrod2"

ggplot(stack(X2speed), aes(x = ind, y = values)) +
  geom_boxplot(width=0.25, fill = fill, colour = line) +
  theme(axis.text=element_text(size=15, face="bold"), axis.title=element_text(size=17,face="bold"), axis.text.x = element_text( angle = 90, hjust=1))+
  labs(x = " ") +
  scale_y_continuous(breaks=seq(0,14000,by=1000), limits = c(0, 14000))

 


