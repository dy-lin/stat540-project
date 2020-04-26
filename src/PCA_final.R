## Author: Diana Lin
## Date: March 30, 2020

library(tidyverse)
library(here)
library(glue)
library(cowplot)

# read in the metadata rds
metadata <-
  readRDS(file = here("data", "processed_data", "metadata.rds"))

# read in the raw normalized data
expr <- readRDS(file = here("data","raw_data", "data.rds")) %>%
  column_to_rownames(var = "CG")

# PCA: with automatic scalling using prcomp
pcs <- prcomp(na.omit(expr), center = TRUE, scale = TRUE)

# save scree plot
png(filename = here("results","scratch", "PCA_auto_scree.png"))
plot(pcs)
dev.off()

# binds metadata to pcs rotations
prinComp <- 
  cbind(metadata, pcs$rotation[metadata$sample, 1:10]) %>%
  dplyr::select(-sample)

# save scatter plot
png(filename = here("results", "scratch", "PCA_auto_scatter.png"))
plot(prinComp[, c("cancer", "cancer_type", "PC1", "PC2", "PC3")], pch = 19, cex = 0.8)
dev.off()

# function to plot PC1 vs PC2 by different characters
gen_pca <- function(var = "cancer_type") {
  ggplot(prinComp, aes(x = PC1, y = PC2)) +
    geom_point(aes(colour = !!sym(var))) +
    labs(title = glue("PCA: {var}"),
         subtitle = "scaled and recentered with prcomp") +
    ggsave(here("results", "scratch", glue("PCA_auto_{var}.png")),width = 12, height = 8, device = "png")
}

# PCA, with manual scaling using scale
if (!file.exists(here("data", "processed_data", "scaled.rds"))) {
  expr_scaled <- t(scale(t(expr)))
  saveRDS(expr_scaled, file =  here("data", "processed_data", "scaled.rds"))
} else {
  expr_scaled <- readRDS(here("data", "processed_data", "scaled.rds"))
}
# do same thing but with manual scaled 
pcs_scaled <- prcomp(na.omit(expr_scaled), center = FALSE, scale = FALSE)

# save scree plot 
png(filename = here("results","scratch", "PCA_manual_scree.png"))
plot(pcs_scaled)
dev.off()

# bind to metadata
prinComp_scaled <-
  cbind(metadata, pcs_scaled$rotation[metadata$sample, 1:10]) %>% 
  dplyr::select(-sample)

# save scatter plot
png(filename = here("results", "scratch", "PCA_manual_scatter.png"))
plot(prinComp_scaled[, c("cancer", "cancer_type", "PC1", "PC2", "PC3")], pch = 19, cex = 0.8)
dev.off()

# function for plotting PC1 and PC2 
gen_pca_scaled <- function(var = "cancer_type") {
  ggplot(prinComp_scaled, aes(x = PC1, y = PC2)) +
    geom_point(aes(colour = !!sym(var))) +
    labs(title = glue("PCA: {var}"),
         subtitle = "manually scaled") +
    ggsave(here("results", "scratch", glue("PCA_manual_{var}.png")),width = 12, height = 8, device = "png")
}

# calls to the function with different covariates
gen_pca("cancer_type")
gen_pca_scaled("cancer_type")

gen_pca("cancer")
gen_pca_scaled("cancer")

gen_pca("source")
gen_pca_scaled("source")

gen_pca("sex")
gen_pca_scaled("sex")

gen_pca("age")
gen_pca_scaled("age")

gen_pca("smoking_status")
gen_pca_scaled("smoking_status")

gen_pca("packs_per_year")
gen_pca_scaled("packs_per_year")

gen_pca("hpv") 
gen_pca_scaled("hpv") 

gen_pca("p16")
gen_pca_scaled("p16")

gen_pca("dna_ng")
gen_pca_scaled("dna_ng")

gen_pca("tumour_percent")
gen_pca_scaled("tumour_percent")

gen_pca("origin")
gen_pca_scaled("origin")

## PCA combined plot
pca <- function(pc1 = "PC1", pc2 = "PC2", var = "cancer_type") {
  ggplot(prinComp_scaled, aes(x = !!sym(pc1), y = !!sym(pc2))) +
    geom_point(aes(colour = !!sym(var))) +
    labs(title = var,
         subtitle = glue("{pc1} and {pc2}")) +
    #    scale_colour_discrete(labels = function(x) str_wrap(x, width = 13)) +
    #   guides(colour = guide_legend(nrow = 2)) +
    theme_cowplot(12) #+
#    xlim(c(-0.4,0.4))
}

# plot the PCA plots
p1 <- pca(pc1 = "PC1", pc2 = "PC2", var = "cancer_type") 
p2 <- pca(pc1 = "PC1", pc2 = "PC3", var = "cancer_type")
p3 <- pca(pc1 = "PC2", pc2 = "PC3", var = "cancer_type") 

p4 <- pca(pc1 = "PC1", pc2 = "PC2", var = "cancer") 
p5 <- pca(pc1 = "PC1", pc2 = "PC3", var = "cancer")
p6 <- pca(pc1 = "PC2", pc2 = "PC3", var = "cancer") 

# combine the three cancer_type ones
p7 <- plot_grid(
  p1 + theme(legend.position = 'none'),
  p2 + theme(legend.position = 'none'),
  p3 + theme(legend.position = 'none'),
  labels =  c('A', 'B', 'C'),
  align = 'h',
  nrow = 1)

# combine the three cancer ones
p8 <- plot_grid(
  p4 + theme(legend.position = 'none'),
  p5 + theme(legend.position = 'none'),
  p6 + theme(legend.position = 'none'),
  labels = c('D', 'E', 'F'),
  align = 'h',
  nrow = 1
)

# get the legend from the cancer_type plots
legend1 <- get_legend(
  p1 + theme(legend.box.margin = margin(0, 0, 0, 12),
             legend.title = element_blank()) 
)

# get the legend from the cancer plots
legend2 <- get_legend(
  p4 + theme(legend.box.margin = margin(0, 0, 0, 12),
             legend.title = element_blank()) + 
    scale_colour_discrete(labels = function(x) str_wrap(x, width = 20))# + 
  #    guides(colour = guide_legend(nrow = 2))
)

# plots + legend
p9 <- plot_grid(p7, legend1, rel_widths = c(3, 1.5))
p10 <- plot_grid(p8, legend2, rel_widths = c(3, 1.5))

# main title
title <- ggdraw() + 
  draw_label(
    "PCA of Differential Methylation Beta-values",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme(
    plot.margin = margin(0, 0, 0, 7)
  )

# final combined plot
final <- plot_grid(title, p9, p10, ncol = 1, rel_heights = c(0.1, 1,1))

ggsave(plot = final, filename = here("results","final", "PCA_manual_combined.png"), width = 12, height = 8, device = "png")


## the same as above, but with the auto-scaled PCA
pca <- function(pc1 = "PC1", pc2 = "PC2", var = "cancer_type") {
  ggplot(prinComp, aes(x = !!sym(pc1), y = !!sym(pc2))) +
    geom_point(aes(colour = !!sym(var))) +
    labs(title = var,
         subtitle = glue("{pc1} and {pc2}")) +
    #    scale_colour_discrete(labels = function(x) str_wrap(x, width = 13)) +
    #   guides(colour = guide_legend(nrow = 2)) +
    theme_cowplot(12) #+
    #xlim(c(-0.4,0.4))
}
p1 <- pca(pc1 = "PC1", pc2 = "PC2", var = "cancer_type") 
p2 <- pca(pc1 = "PC1", pc2 = "PC3", var = "cancer_type")
p3 <- pca(pc1 = "PC2", pc2 = "PC3", var = "cancer_type") 

p4 <- pca(pc1 = "PC1", pc2 = "PC2", var = "cancer") 
p5 <- pca(pc1 = "PC1", pc2 = "PC3", var = "cancer")
p6 <- pca(pc1 = "PC2", pc2 = "PC3", var = "cancer") 

p7 <- plot_grid(
  p1 + theme(legend.position = 'none'),
  p2 + theme(legend.position = 'none'),
  p3 + theme(legend.position = 'none'),
  labels =  c('A', 'B', 'C'),
  align = 'h',
  nrow = 1)

p8 <- plot_grid(
  p4 + theme(legend.position = 'none'),
  p5 + theme(legend.position = 'none'),
  p6 + theme(legend.position = 'none'),
  labels = c('D', 'E', 'F'),
  align = 'h',
  nrow = 1
)
legend1 <- get_legend(
  p1 + theme(legend.box.margin = margin(0, 0, 0, 12),
             legend.title = element_blank()) 
)

legend2 <- get_legend(
  p4 + theme(legend.box.margin = margin(0, 0, 0, 12),
             legend.title = element_blank()) + 
    scale_colour_discrete(labels = function(x) str_wrap(x, width = 20))# + 
  #    guides(colour = guide_legend(nrow = 2))
)

p9 <- plot_grid(p7, legend1, rel_widths = c(3, 1.5))
p10 <- plot_grid(p8, legend2, rel_widths = c(3, 1.5))

title <- ggdraw() + 
  draw_label(
    "PCA of Differential Methylation Beta-values",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme(
    plot.margin = margin(0, 0, 0, 7)
  )

final <- plot_grid(title, p9, p10, ncol = 1, rel_heights = c(0.1, 1,1))

ggsave(plot = final, filename = here("results","scratch", "PCA_auto_combined.png"), width = 12, height = 8, device = "png")