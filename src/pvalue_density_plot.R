library(here)
library(tidyverse)

data_subset <- readRDS(here("data", "processed_data", "filtered_data.rds"))

data_subset %>%
  group_by(CG)%>%
  summarize( pvalue = t.test(value ~ cancer_type)$p.value) %>%
  ggplot(aes(x =pvalue)) + 
  geom_density() +
  labs(title = "Density of P-values in DNA Methylation", subtitle = "Beta values ~ Cancer Type T-Test") +
  ggsave(width=12, height=8, device = "png", here("src","pvalue_density_plot.png"))
