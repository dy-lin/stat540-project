## Author: Diana Lin
## Date: March 30, 2020

library(tidyverse)
library(here)
library(glue)

# read in the data
expr <- readRDS(here("data","processed_data", "filtered_data.rds")) %>%
    mutate(cancer_loc= if_else(cancer == ("Pulmonary metastasis of head and neck squamous cell carcinoma"), "Metastatic HNSC",if_else( cancer== ("Primary head and neck squamous cell carcinoma"), "Primary HNSC","Primary Lung")))

# convert beta values to m values 
if (!file.exists(here("data","processed_data", "combined_mvals.rds"))) {
    mvals <- expr
    mvals$value <- beta2m(expr$value)
    
    saveRDS(mvals, filename = here("data","processed_data", "combined_mval_filtered.rds"))
} else {
    mvals <- readRDS(file = here("data","processed_data", "combined_mval_filtered.rds"))
}

# function for plotting strip plot
# creates two plots: one with beta values and one with m values
strip_plot <- function(path, name = "") {

    if (name != "") {
        propername <- str_replace_all(name, "_", " ")
        name <- glue("_{name}")
    } else {
        propername <- "All"
    }
    
    
    topten <- read_csv(path)
    topten_filtered <- topten %>%
        dplyr::select(c(probeID, gene, gene_HGNC)) %>%
        mutate(gene = str_replace_all(gene,";", " "), gene_HGNC = str_replace_all(gene_HGNC, ";", " "))
    
    expr_wrangled <- expr %>%
        rename(CG = "probeID") %>%
        semi_join(topten_filtered, by = "probeID") %>%
        left_join(topten_filtered, by = "probeID")
    
    mvals_wrangled <- mvals %>%
        rename(CG = "probeID") %>%
        semi_join(topten_filtered, by = "probeID") %>%
        left_join(topten_filtered, by = "probeID")
 
    expr_wrangled %>%
        ggplot(aes(x = cancer_loc, y = value, colour = cancer_loc)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe Beta Values Within Top 10 Differentially Methylated Genes", y = "Beta values", subtitle = glue("Limma Coefficient = {propername}")) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        scale_colour_discrete(name = "Cancer Location") +
        ggsave(width = 12, height = 8, device = "png", file = here("results", "scratch", glue("stripplot_beta_cancer_loc{name}.png")))
    
    expr_wrangled %>%
        ggplot(aes(x = cancer_type, y = value, colour = cancer_type)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe Beta Values Within Top 10 Differentially Methylated Genes", y = "Beta values", subtitle = glue("Limma Coefficient = {propername}")) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        scale_colour_discrete(name = "Cancer Type") +
        ggsave(width = 12, height = 8, device = "png", file = here("results", if_else(name == "_primary", "final", "scratch"), glue("stripplot_beta_cancer_type{name}.png")))

    expr_wrangled %>%
        ggplot(aes(x = cancer, y = value, colour = cancer)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe Beta Values Within Top 10 Differentially Methylated Genes", y = "Beta values", subtitle = glue("Limma Coefficient = {propername}")) +
        scale_x_discrete(name = "Cancer", labels = function(x) str_wrap(x, width = 20)) +
        scale_colour_discrete(labels = function(x) str_wrap(x, width = 20)) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        ggsave(width = 12, height = 8, device = "png", file = here("results", "scratch", glue("stripplot_beta_cancer{name}.png")))
    
    mvals_wrangled %>%
        ggplot(aes(x = cancer_loc, y = value, colour = cancer_loc)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe M Values Within Top 10 Differentially Methylated Genes", y = "M values", subtitle = glue("Limma Coefficient = {propername}")) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        scale_colour_discrete(name = "Cancer Location") +
        ggsave(width = 12, height = 8, device = "png", file = here("results", "scratch", glue("stripplot_mval_cancer_loc{name}.png")))
    
    mvals_wrangled %>%
        ggplot(aes(x = cancer_type, y = value, colour = cancer_type)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe M Values Within Top 10 Differentially Methylated Genes", y = "M values", subtitle = glue("Limma Coefficient = {propername}")) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        scale_colour_discrete(name = "Cancer Type") +
        ggsave(width = 12, height = 8, device = "png", file = here("results", "scratch", glue("stripplot_mval_cancer_type{name}.png")))

    mvals_wrangled %>%
        ggplot(aes(x = cancer, y = value, colour = cancer)) +
        geom_point() +
        facet_wrap(~gene, nrow = 2, labeller = labeller(gene = label_wrap_gen(10))) +
        stat_summary(fun.y = mean, aes(group = 1), geom = "line", color = "black") +
        labs(title = "Probe M Values Within Top 10 Differentially Methylated Genes", y = "M values", subtitle = glue("Limma Coefficient = {propername}")) +
        scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
        scale_colour_discrete(name = "Cancer", labels = function(x) str_wrap(x, width = 20)) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x = element_blank()) +
        ggsave(width = 12, height = 8, device = "png", file = here("results", "scratch", glue("stripplot_mval_cancer{name}.png")))
}

# function calls to plot dependent on which limma results used
strip_plot(here("results", "scratch", "metastatic_hnsc_limma.csv"), name = "metastatic_hnsc")

strip_plot(here("results", "scratch", "primary_lung_annotatedlimma.csv"), name = "primary_lung")

strip_plot(here("results", "scratch", "secondary_lung_annotatedlimma.csv"), name = "secondary_lung")

strip_plot(here("results", "scratch", "topTen_annotated_genes.csv"))

strip_plot(here("results", "scratch", "age_top_genes_limma2.csv"), name = "age")

strip_plot(here("results", "final", "primary_topGenes_limma2.csv"), name = "primary")