## Author: Diana Lin
## Date: March 30, 2020

library(tidyverse)
library(here)
library(lumi)

# read in the data
data <- readRDS(file = here("data", "processed_data", "filtered_data.rds")) %>%
    mutate(cancer_loc= if_else(cancer == ("Pulmonary metastasis of head and neck squamous cell carcinoma"), "Metastatic HNSC",if_else( cancer== ("Primary head and neck squamous cell carcinoma"), "Primary HNSC","Primary Lung")))

# plot cancer boxplot using beta values
data %>%
    ggplot(aes(x = sample, y = value, fill = cancer)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer") +
    ggtitle("Distribution of Beta Values Across Cancer") +
    ggsave(width = 12, height = 8, file = here("results", "final", "boxplot_cancer_beta.png"), device = "png")

# plot cancer type boxplot using beta values
data %>%
    ggplot(aes(x = sample, y = value, fill = cancer_type)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer Type") +
    ggtitle("Distribution of Beta Values Across Cancer Types") +
    ggsave(width = 12, height = 8, file = here("results", "final", "boxplot_cancer_type_beta.png"), device = "png")

# plot cancer_loc beta
data %>%
    ggplot(aes(x = sample, y = value, fill = cancer_loc)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer Location") +
    ggtitle("Distribution of Beta Values Across Cancer Locations") +
    ggsave(width = 12, height = 8, file = here("results", "scratch", "boxplot_cancer_loc_beta.png"), device = "png") 

# use m-values instead of beta values 

if (!file.exists(here("data","processed_data", "combined_mvals.rds"))) {
    m_data <- data
    
    m_data$value <- beta2m(m_data$value)
    saveRDS(m_data, filename = here("data","processed_data", "combined_mval_filtered.rds"))
} else {
    m_data <- readRDS(file = here("data","processed_data", "combined_mval_filtered.rds"))
}

# cancer
m_data %>%
    ggplot(aes(x = sample, y = value, fill = cancer)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer") +
    ggtitle("Distribution of M Values Across Cancers") +
    ggsave(width = 12, height = 8, file = here("results", "scratch", "boxplot_cancer_m.png"), device = "png")

# cancer type
m_data %>%
    ggplot(aes(x = sample, y = value, fill = cancer_type)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer Type") +
    ggtitle("Distribution of M Values Across Cancer Types") +
    ggsave(width = 12, height = 8, file = here("results", "scratch", "boxplot_cancer_type_m.png"), device = "png")

# cancer loc 
m_data %>%
    ggplot(aes(x = sample, y = value, fill = cancer_loc)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_fill_discrete(name = "Cancer Location") +
    ggtitle("Distribution of M Values Across Cancer Locations") +
    ggsave(width = 12, height = 8, file = here("results","scratch", "boxplot_cancer_loc_m.png"), device = "png") 