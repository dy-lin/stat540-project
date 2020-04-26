# Scripts 

## Fetching the data
**Script:** [`fetch_data.R`](fetch_data.R)<br/>
**Inputs:** None<br/>
**Outputs:** [`data/raw_data/metadata.rds`](../data/raw_data/metadata.rds), [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds), [`data/raw_data/data.rds`](../data/raw_data/data.rds), [`data/processed_data/data.rds`](../data/processed_data/data.rds), [`data/processed_data/combined_data.rds`](../data/processed_data/combined_data.rds), [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds)

Using [`fetch_data.R`](fetch_data.R), the GEO object will be fetched, and the following required `.rds` objects will be saved:
- the raw metadata from GEO: [`data/raw_data/metadata.rds`](../data/raw_data/metadata.rds)
- the processed metadata after cleaning the raw: [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds)
- the (raw) pre-normalized methylation data from GEO: [`data/raw_data/data.rds`](../data/raw_data/data.rds)
- the processed (reshaped) methylation data from GEO: [`data/processed_data/data.rds`](../data/processed_data/data.rds)
- the reshaped methylation data and cleaned metadata combined into one dataframe: [`data/processed_data/combined_data.rds`](../data/processed_data/combined_data.rds)
- the subsetted (filtered) combined dataframe (e.g. removing females, and irrelevant metadata): [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds)

## Principal Component Analysis

**Script:** [`PCA_final.R`](PCA_final.R)<br/>
**Inputs:** [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds), [`data/raw_data/data.rds`](../data/processed_data/metadata.rds)<br/>
**Outputs:** `results/final/PCA_manual_combined.png`

Using [`PCA_final.R`](PCA_final.R), various PCA plots are generated. These plots were placed in the [`data/revised/`](../data/revised/) and [`data/final`](../data/final/) directories. PCA was conducted to see if there was any underlying signal in the data, to see if there is any natural clustering. Both manual scaling (using `t(scale(t(data)))` and autoscaling (using `prcomp(data, scale = TRUE, center = TRUE`) were used. PCA was coloured by all covariates, and the final plots coloured by `cancer` and `cancer_type`. To see all the results, see [`docs/PCA.md`](../docs/PCA.md).

## Beta Density Plot

**Script**: [`beta_density_plot.R`](beta_density_plot.R)<br/> **Input**: [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds)<br/>**Output**: [`results/final/beta_density_plot.pdf`](../results/final/beta_density_plot.pdf)

Using [`beta_density_plot.R`](beta_density_plot.R), a density of the beta values by cancer type
was generated and placed in the [`results/final`](../results/final/) directory. The purpose of this 
plot was to examine the distribution of beta values in our samples and to see whether these distributions differ between the different cancer types. These differences
could have been caused by technical confounders and wwould have confounded our analysis. Our density plot does not show significant differences between the
density of beta values of cancer types. To see all the results, see [`docs/beta_density.Rmd`](../docs/beta_density.Rmd).

## Boxplot Distributions

**Script:** [`boxplot_final.R`](boxplot_final.R)<br/>**Inputs:** [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds)<br/>**Outputs:** [`results/final/boxplot_cancer_beta.png`](../results/final/boxplot_cancer_beta.png), [`results/final/boxplot_cancer_type_beta.png`](../results/final/boxplot_cancer_type_beta.png)

Using [`boxplot_final.R`](boxplot_final.R), various box plots were generated and placed in the [`data/scratch/`](../data/scratch/) and [`data/final`](../data/final/) directories. The boxplots were generated to see the distribution of beta values across all samples. There seemed to be no discernable pattern when coloured by `cancer_type`, `cancer`, and `cancer_loc` (cancer location). To see all the results, see [`docs/boxplots.md`](../docs/boxplots.md).

## P-Value Histograms 
**Script:** [`pValueHistogram.R`](pValueHistogram.R)<br/>
**Input:** [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds), [`data/raw_data/data.rds`](../data/processed_data/metadata.rds), 
[`data/raw_data/EPIC.hg38.manifest.tsv.gz`](../data/raw_data/EPIC.hg38.manifest.tsv.gz) (manual unzip)<br/>
**Outputs:** [`results/final/pValue-Histogram-cancerType-1.png`](../results/final/pValue-Histogram-cancerType-1.png), [`results/final/pValue-Histogram-cancerType-age-1.png`](../results/final/pValue-Histogram-cancerType-age-1.png)

Using [`pValueHistogram.R`](pValueHistogram.R), p-value histograms were generated for two different models: `cancer_type` and `cancer_type*age`.`model.matrix()` was used to design the models,`lmfit()` was used to fit the model, and `eBayes()` was used to compute moderated t-statistics. These three funcitions were loaded with the R package `limma`. The calculated p-values were retrieved using `topTable(number = inf)` and `geom_histogram()` was used generate a pValue histogram. To see all the results, see [`docs/pValue_Histogram.md`](../docs/pValue_Histogram.md).

## P-Value Density Plot
**Script:** [`pvalue_density_plot.R`](pvalue_density_plot.R)<br/>
**Inputs:** [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds) <br/>
**Outputs:** [`results/final/pvalue_density_plot.png`](../results/final/pvalue_density_plot.png)

Using [`pvalue_density_plot.R`](pvalue_density_plot.R), p-value density plot was generated using a two-sample t-test `summarize(pvalue = t.test(value ~ cancer_type)$p.value)`. This function computes the difference in mean methylation signal between two groups of samples `cancer_type$primary` (primary and secondary LSCC) and `cancer_type$metastatic` (pulmonary HNSC). `geom_density()` was used to generate p.value density plot. To see all the results, see [`docs/pValue_density.md`](../docs/pValue_density.md).

## Hierarchical Clustering
**Script:** [`hierarchical_clusting.R`](hierarchical_clustering.R)<br/>
**Inputs:** [`data/raw_data/data.rds`](../data/raw_data/data.rds), [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds)<br/>
**Outputs:** [`results/final/heatmap_with_clusters.png`](../results/final/heatmap_with_clusters.png),[`results/scratch/Mvalue_heatmap_with_clusters.png`](../results/scratch/Mvalue_heatmap_with_clusters.png), [`data/processed_data/male_metadata.csv`](../data/processed_data/male_metadata.csv),`data/raw_data/data_for_limma.rds`

Using the script [`hierarchical_clusting.R`](hierarchical_clustering.R),hierarchical clustering on beta and mvalues using Euclidean distance and average linkage was performed. Various metadata features(covariates) were coloured on the heatmap such as smoking, cancer_type (primary or metastatic), cancer (pulmonary metastatic HNSC, primary LUSC, primary second LUSC, primary HNSC). The heatmaps generated can be be found at [`results/final/heatmap_with_clusters.png`](../results/final/heatmap_with_clusters.png),[`results/scratch/Mvalue_heatmap_with_clusters.png`](../results/scratch/Mvalue_heatmap_with_clusters.png). Additionally, an updated metadata file containing only males,  [`data/processed_data/male_metadata.csv`](../data/processed_data/male_metadata.csv) and the data file for limma are generated for this script, making this script necessary to run before the limma one. Additionally, to see more detailed results, including more dendograms, see the md script
[`docs/scratch/hierarchical_clustering.md`](../docs/scratch/hierarchical_clustering.md) and the documentation [`docs/hierarchical_clustering.md`](docs/hierarchical_clustering.md).

## Linear Regression:
**Script:** [`linear_regression.R`](linear_regression.R)<br/>
**Inputs:** [`data/processed_data/male_metadata.csv`](../data/processed_data/male_metadata.csv),`data/raw_data/data_for_limma.rds`,  [`data/processed_data/metadata.rds`](../data/processed_data/metadata.rds),[`data/raw_data/EPIC.hg38.manifest.tsv.gz`](../data/raw_data/EPIC.hg38.manifest.tsv.gz.zip) (manual unzip)<br/>
**Outputs:** [`results/final/primary_topGenes_limma2.csv`](../results/final/primary_topGenes_limma2.csv),[`results/revised/age_top_genes_limma2.csv`](../results/revised/age_top_genes_limma2.csv),[`results/revised/ageandprimary_top_genes_limma2.csv`](../results/revised/ageandprimary_top_genes_limma2.csv)

Linear regression was run in  [`linear_regression.R`](linear_regression.R) on a combined additive and interaction model (`cancer_type*age`) with `cancer_type` being metastatic or primary. This was done using Limma and Ebayes, with top 10 genes found using TopTable and annotated using  [`data/raw_data/EPIC.hg38.manifest.tsv.gz`](../data/raw_data/EPIC.hg38.manifest.tsv.gz.zip) (manual unzip). The final tabular results can be found here: [`results/final/primary_topGenes_limma2.csv`](../results/final/primary_topGenes_limma2.csv),[`results/revised/age_top_genes_limma2.csv`](../results/revised/age_top_genes_limma2.csv),[`results/revised/ageandprimary_top_genes_limma2.csv`](../results/revised/ageandprimary_top_genes_limma2.csv). The output of this script, specifically the `primary_topGenes_limma2.csv`,  is used in downstream analysis. To see all the results, see [`docs/Linear_regression_results.md`](../docs/Linear_regression_results.md).

## Strip Plot
**Script:** [`strip_plot.R`](strip_plot.R)<br/>
**Inputs:** [`data/processed_data/filtered_data.rds`](../data/processed_data/filtered_data.rds), [`results/final/primary_topGenes_limma2.csv`](../results/final/primary_topGenes_limma2.csv)<br/>,[`data/raw_data/EPIC.hg38.manifest.tsv.gz`](../data/raw_data/EPIC.hg38.manifest.tsv.gz) (manual unzip),
**Outputs:** [`results/final/stripplot_beta_cancer_type_primary.png`](../results/final/stripplot_beta_cancer_type_primary.png)

Using [`strip_plot.R`](strip_plot.R), the beta values of the top 10 differentially methylated genes (using [`results/final/primary_topGenes_limma2.csv`](../results/final/primary_topGenes_limma2.csv)) were plotted between the two `cancer_types`: `primary` and `metastatic`. These plots can be found in [`results/final/`](../results/final/) and [`results/scratch/`](../results/scratch/). To see all the results, see [`docs/strip_plots.md`](../docs/strip_plots.md).

## Chromosome Plot
**Script:** [`chr_plot.R`](chr_plot.R)<br/>
**Inputs:** [`data/raw_data/EPIC.hg38.manifest.tsv.gz`](../data/raw_data/EPIC.hg38.manifest.tsv.gz) (manual unzip), [`results/final/primary_limma2.rds`](../results/final/primary_limma2.rds)<br/>
**Outputs:** [`results/final/chrplot.png`](../results/final/chrplot.png)

Using [`chr_plot.R`](chr_plot.R), the chromosome location of all probes belonging to the top 10 differentially methylated genes (using [`results/final/primary_topGenes_limma2.csv`](../results/final/primary_topGenes_limma2.csv) were plotted to visualize the differentially methylated regions along the chromosomes. This plot can be found in [`results/final/chrplot.png`](../results/final/chrplot.png). To see all the results, see [`docs/chr_plot.md`](../docs/chr_plot.md).
