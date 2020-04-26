pca\_boxplot
================
Diana Lin
3/9/2020

## PCA

Load packages:

``` r
library(tidyverse)
library(here)
library(lumi)
```

Import the metadata and expression data:

``` r
if (!exists("metadata", inherits = FALSE) ) {
    metadata <-
        readRDS(file = here("data", "processed_data", "metadata.rds"))
}

if (!exists("expr", inherits = FALSE)) {
    expr <- readRDS(file = here("data","raw_data", "data.rds")) %>%
        column_to_rownames(var = "CG")
}

if(!exists("combined", inherits = FALSE)) {
    combined <- readRDS(file = here("data","processed_data","filtered_data.rds"))
}
```

PCA Bar Chart:

``` r
if (!exists("scaled", inherits = FALSE)) {
    if (file.exists(here("data", "processed_data", "scaled.rds"))) {
        scaled <- readRDS(file = here("data", "processed_data", "scaled.rds"))
    } else {
        scaled <- t(scale(t(expr)))
        saveRDS(scaled, file = here("data", "processed_data", "scaled.rds"))
    }
} 
pcs <- prcomp(na.omit(scaled), center = FALSE, scale = FALSE)
plot(pcs)
```

![](pca_boxplot_files/figure-gfm/pca-bar-1.png)<!-- -->

``` r
prinComp <-
    cbind(metadata, pcs$rotation[metadata$sample, 1:10]) %>% 
    dplyr::select(-sample)
    
plot(prinComp[, c("cancer", "PC1", "PC2", "PC3")], pch = 19, cex = 0.8)
```

![](pca_boxplot_files/figure-gfm/pca-1.png)<!-- -->

PCA for Source:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = source)) +
        ggtitle("PCA: Source")
```

![](pca_boxplot_files/figure-gfm/source-1.png)<!-- -->

PCA for Cancer:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer)) +
        ggtitle("PCA: Cancer")
```

![](pca_boxplot_files/figure-gfm/cancer-1.png)<!-- -->

PCA for Sex:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = sex)) +
        ggtitle("PCA: Sex")
```

![](pca_boxplot_files/figure-gfm/sex-1.png)<!-- -->

PCA for Age:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = age)) +
        ggtitle("PCA: Age")
```

![](pca_boxplot_files/figure-gfm/age-1.png)<!-- -->

PCA for Smoking status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = smoking_status)) +
        ggtitle("PCA: Smoking status")
```

![](pca_boxplot_files/figure-gfm/smoking-1.png)<!-- -->

PCA for Packs smoked per year:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = packs_per_year)) +
        ggtitle("PCA: Packs smoked per year")
```

![](pca_boxplot_files/figure-gfm/ppy-1.png)<!-- -->

PCA for HPV status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = hpv)) +
        ggtitle("PCA: HPV status")
```

![](pca_boxplot_files/figure-gfm/hpv-1.png)<!-- -->

PCA for p16:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = p16)) +
        ggtitle("PCA: p16")
```

![](pca_boxplot_files/figure-gfm/p16-1.png)<!-- -->

PCA for DNA quantity:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = dna_ng)) +
        ggtitle("PCA: DNA (ng)")
```

![](pca_boxplot_files/figure-gfm/DNA-1.png)<!-- -->

PCA for Tumour percentage:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = tumour_percent)) +
        ggtitle("PCA: Tumour percent")
```

![](pca_boxplot_files/figure-gfm/tumour-1.png)<!-- -->

PCA for Origin:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = origin)) +
        ggtitle("PCA: Origin")
```

![](pca_boxplot_files/figure-gfm/origin-1.png)<!-- -->

PCA for Cancer type:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer_type)) +
        ggtitle("PCA: Cancer type")
```

![](pca_boxplot_files/figure-gfm/cancer-type-1.png)<!-- -->

## Box Plot

``` r
combined %>%
    ggplot(aes(x = sample, y = value)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90))
```

    ## Warning: Removed 1160 rows containing non-finite values (stat_boxplot).

![](pca_boxplot_files/figure-gfm/boxplot-1.png)<!-- -->

``` r
combined %>%
    ggplot(aes(x = sample, y = value)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_y_continuous(trans = 'log2')
```

    ## Warning: Removed 1160 rows containing non-finite values (stat_boxplot).

![](pca_boxplot_files/figure-gfm/boxplot-2.png)<!-- -->

## PCA Plots with M values

``` r
if (!exists("expr_m", inherits = FALSE)) {
    if (file.exists(here("data","processed_data","mvals.rds"))) {
        expr_m <- readRDS(file = here("data", "processed_data", "mvals.rds"))
    } else {
        expr_m <- beta2m(expr)
        saveRDS(expr_m, file = here("data","processed_data", "mvals.rds"))
    }
}

pcs <- prcomp(na.omit(expr_m), center = FALSE, scale = FALSE)
plot(pcs)
```

![](pca_boxplot_files/figure-gfm/pca-mval-barchart-1.png)<!-- -->

``` r
prinComp <-
    cbind(metadata, pcs$rotation[metadata$sample, 1:10]) %>% 
    dplyr::select(-sample)
    
plot(prinComp[, c("cancer", "PC1", "PC2", "PC3")], pch = 19, cex = 0.8)
```

![](pca_boxplot_files/figure-gfm/pca-mval-1.png)<!-- -->

PCA for Source:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = source)) +
        ggtitle("PCA: Source")
```

![](pca_boxplot_files/figure-gfm/source-mval-1.png)<!-- -->

PCA for Cancer:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer)) +
        ggtitle("PCA: Cancer")
```

![](pca_boxplot_files/figure-gfm/cancer-mval-1.png)<!-- -->

PCA for Sex:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = sex)) +
        ggtitle("PCA: Sex")
```

![](pca_boxplot_files/figure-gfm/sex-mval-1.png)<!-- -->

PCA for Age:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = age)) +
        ggtitle("PCA: Age")
```

![](pca_boxplot_files/figure-gfm/age-mval-1.png)<!-- -->

PCA for Smoking status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = smoking_status)) +
        ggtitle("PCA: Smoking status")
```

![](pca_boxplot_files/figure-gfm/smoking-mval-1.png)<!-- -->

PCA for Packs smoked per year:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = packs_per_year)) +
        ggtitle("PCA: Packs smoked per year")
```

![](pca_boxplot_files/figure-gfm/ppy-mval-1.png)<!-- -->

PCA for HPV status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = hpv)) +
        ggtitle("PCA: HPV status")
```

![](pca_boxplot_files/figure-gfm/hpv-mval-1.png)<!-- -->

PCA for p16:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = p16)) +
        ggtitle("PCA: p16")
```

![](pca_boxplot_files/figure-gfm/p16-mval-1.png)<!-- -->

PCA for DNA quantity:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = dna_ng)) +
        ggtitle("PCA: DNA (ng)")
```

![](pca_boxplot_files/figure-gfm/DNA-mval-1.png)<!-- -->

PCA for Tumour percentage:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = tumour_percent)) +
        ggtitle("PCA: Tumour percent")
```

![](pca_boxplot_files/figure-gfm/tumour-mval-1.png)<!-- -->

PCA for Origin:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = origin)) +
        ggtitle("PCA: Origin")
```

![](pca_boxplot_files/figure-gfm/origin-mval-1.png)<!-- -->

PCA for Cancer type:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer_type)) +
        ggtitle("PCA: Cancer type")
```

![](pca_boxplot_files/figure-gfm/cancer-type-mval-1.png)<!-- -->

## PCA Plots with Scaled M values

``` r
if (!exists("expr_m_scaled", inherits = FALSE)) {
    if (file.exists(here("data","processed_data","mvals_scaled.rds"))) {
        expr_m_scaled <- readRDS(file = here("data", "processed_data", "mvals_scaled.rds"))
    } else {
        expr_m_scaled <- t(scale(t(expr_m)))
        saveRDS(expr_m_scaled, file = here("data", "processed_data", "mvals_scaled.rds"))
    }
}
pcs <- prcomp(na.omit(expr_m_scaled), center = FALSE, scale = FALSE)
plot(pcs)
```

![](pca_boxplot_files/figure-gfm/pca-mval-scaled-barchart-1.png)<!-- -->

``` r
prinComp <-
    cbind(metadata, pcs$rotation[metadata$sample, 1:10]) %>% 
    dplyr::select(-sample)
    
plot(prinComp[, c("cancer", "PC1", "PC2", "PC3")], pch = 19, cex = 0.8)
```

![](pca_boxplot_files/figure-gfm/pca-mval-scaled-1.png)<!-- -->

PCA for Source:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = source)) +
        ggtitle("PCA: Source")
```

![](pca_boxplot_files/figure-gfm/source-mval-scaled-1.png)<!-- -->

PCA for Cancer:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer)) +
        ggtitle("PCA: Cancer")
```

![](pca_boxplot_files/figure-gfm/cancer-mval-scaled-1.png)<!-- -->

PCA for Sex:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = sex)) +
        ggtitle("PCA: Sex")
```

![](pca_boxplot_files/figure-gfm/sex-mval-scaled-1.png)<!-- -->

PCA for Age:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = age)) +
        ggtitle("PCA: Age")
```

![](pca_boxplot_files/figure-gfm/age-mval-scaled-1.png)<!-- -->

PCA for Smoking status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = smoking_status)) +
        ggtitle("PCA: Smoking status")
```

![](pca_boxplot_files/figure-gfm/smoking-mval-scaled-1.png)<!-- -->

PCA for Packs smoked per year:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = packs_per_year)) +
        ggtitle("PCA: Packs smoked per year")
```

![](pca_boxplot_files/figure-gfm/ppy-mval-scaled-1.png)<!-- -->

PCA for HPV status:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = hpv)) +
        ggtitle("PCA: HPV status")
```

![](pca_boxplot_files/figure-gfm/hpv-mval-scaled-1.png)<!-- -->

PCA for p16:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = p16)) +
        ggtitle("PCA: p16")
```

![](pca_boxplot_files/figure-gfm/p16-mval-scaled-1.png)<!-- -->

PCA for DNA quantity:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = dna_ng)) +
        ggtitle("PCA: DNA (ng)")
```

![](pca_boxplot_files/figure-gfm/DNA-mval-scaled-1.png)<!-- -->

PCA for Tumour percentage:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = tumour_percent)) +
        ggtitle("PCA: Tumour percent")
```

![](pca_boxplot_files/figure-gfm/tumour-mval-scaled-1.png)<!-- -->

PCA for Origin:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = origin)) +
        ggtitle("PCA: Origin")
```

![](pca_boxplot_files/figure-gfm/origin-mval-scaled-1.png)<!-- -->

PCA for Cancer type:

``` r
ggplot(prinComp, aes(x = PC1, y = PC2)) +
        geom_point(aes(colour = cancer_type)) +
        ggtitle("PCA: Cancer type")
```

![](pca_boxplot_files/figure-gfm/cancer-type-mval-scaled-1.png)<!-- -->
<!--
## Boxplot with M values


-->
