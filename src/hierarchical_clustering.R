
#author: Almas K.
#date : 2020-04-02

'This script is for hierarchical clustering in R'



# Libraries

library(tidyverse)
library(reshape2)
library(stringr)
library(here)
library(tictoc)
library(ggdendro)
library(dendextend)
library(lumi)

## Load Data

raw_dat <- readRDS(here("data", "raw_data", "data.rds"))
filtered_metadata <- readRDS(here("data","processed_data","metadata.rds"))

## Filter Loaded Data:

male_metadata <- filtered_metadata %>%
  filter(sex=="Male")
rownames(male_metadata) <- male_metadata$sample
data_to_clust <- raw_dat
rownames(data_to_clust) <- data_to_clust$CG
data_to_clust <- data_to_clust %>%
  dplyr::select_if((names(.) %in% male_metadata$sample)) %>%
  drop_na() 

filt_data <- raw_dat %>%
  dplyr::select_if((names(.) %in% male_metadata$sample)|names(.)=="CG") %>%
  drop_na() 


## Convert beta to mvals

data_mval <- beta2m(data_to_clust)


## Hierarchical Clustering and Heatmap

#distance
D <- dist(t(data_to_clust)) 
# t flips the x and y dimensions, b/c the dist measure uses rows, and we want to look at column similarity we transpose,

# clustering
clust <- hclust(D,method="average")
dendo <- as.dendrogram(clust) 


# Generate Heatmap using Beta values and save 

## We can change the colours of the covariates
png( width = 1000, height = 800,here("results","final","heatmap_with_clusters.png") )
var1 = c("orange1", "darkred","purple","yellow")
names(var1) = levels(male_metadata$cancer)
var2 = c("grey", "black")
names(var2)= levels(male_metadata$cancer_type)
var3 = c("pink1", "pink3", "lightblue1", "blue3")
names(var3)=levels(male_metadata$smoking_status)
covar_color = list(cancer = var1, cancer_type = var2, smoking_status = var3)

clust_scale = "none"  
covar_color = list(cancer = var1, cancer_type= var2, smoking_status= var3)


heatmap <- pheatmap::pheatmap(as.matrix(D),cluster_rows = TRUE, scale = clust_scale, 
                              clustering_method = "average", clustering_distance_cols = "euclidean", 
                              show_rownames = FALSE, main = "Clustering heatmap", annotation = male_metadata[, 
                                                                                                              c("cancer", "cancer_type", "smoking_status")], annotation_colors = covar_color)
dev.off()


# Heatmpa using M-values

#distance
D_mval <- dist(t(data_mval)) 
# t flips the x and y dimensions, b/c the dist measure uses rows, and we want to look at column similarity we transpose
png( width = 1000, height = 800,here("results","scratch","Mvalue_heatmap_with_clusters.png") )
heatmap2 <- pheatmap::pheatmap(as.matrix(D_mval),cluster_rows = TRUE, scale = clust_scale, 
                               clustering_method = "average", clustering_distance_cols = "euclidean", 
                               show_rownames = FALSE, main = "Clustering heatmap using Mvalues ", annotation = male_metadata[, 
                                                                                                                             c("cancer", "cancer_type", "smoking_status")], annotation_colors = covar_color)

dev.off()
## Save metadata and file for limma use
write_csv(male_metadata,here("data","processed_data","male_metadata.csv"))

saveRDS(data_to_clust,here("data","raw_data","data_for_limma.rds"))



