library(here)
library(ggplot2)
library(dplyr)

data_subset <- readRDS(here("data", "processed_data", "filtered_data.rds"))

met<-data_subset %>% 
  filter(cancer_type=="metastatic")
pri <- data_subset %>%
  filter(cancer_type=="primary")

probeMeans <- c(rowMeans(as.data.frame(met$value), na.rm = T),rowMeans(as.data.frame(pri$value), na.rm = T)) 
plotDat <- data.frame(Beta = probeMeans,
                      Dataset = rep(c('met', 'pri')))

(ggplot(data = plotDat, aes(x = Beta, col = Dataset)) +
    geom_density() + 
    ggtitle("Average Beta value density of two types of cancer") + 
    xlab("Beta") + 
    ylab("Density") + 
    theme_bw()
  
)
ggsave(width=12, height=8, device = "png", here("results","final","beta_density_plot.png"))
