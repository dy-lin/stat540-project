# Final Results

This directory will hold all the generated plots used in our final presentation.

## PCA
The PCA plots used in the presentation are in the file [`PCA_manual_combined.png`](PCA_manual_combined.png). To view all the plots together, see the documentation in [`docs/PCA.md`](../../docs/PCA.md). In the final PCA, there was no discernable clustering between PC1 and PC2; PC2 and PC3; PC1 and PC3, by `cancer_type` or `cancer`.

## Beta Density Plots
The beta density plot used in the presentation can be found at [`beta_density_plot.pdf`](beta_density_plot.pdf). This plot allows us to examine the density distrinutions
of beta values between `primary` and `metastatic` cancer. This is to show
that there are no significant differences in the density of beta values which would
point to technical confounders.

## Box Plots
The boxplots used in the presentation are in [`boxplot_cancer_beta.png`](boxplot_cancer_beta.png) and [`boxplot_cancer_type_beta.png`](boxplot_cancer_type_beta.png). To view all the plots together, see the documentation in [`docs/PCA.md`](../../docs/PCA.md). In the final boxplots, there were no discernable patterns regarding the distribution of beta-values across samples, coloured by `cancer_type` or `cancer`.

## P-value Histograms
The p-value histograms used in the presentation are in [`pValue-Histogram-cancerType-1.png`](pValue-Histogram-cancerType-1.png) and [`pValue-Histogram-cancerType-age-1.png`](pValue-Histogram-cancerType-age-1.png). To view all the plots together, see the documentation in [`docs/pValue_Histogram.md`](../../docs/pValue_Histogram.md). In the final p-value histogram for the model `cancer_type*age`, pvalues are "uniformally" distributed and thus there seems to be no significant statistical power to reject the null hypothesis. In the final p-value histogram for the model `cancer_type`, many small pvalues appear as a peak near 0 indicating enough statisitical power to reject the null hypothesis. 

## P-value Density Plots
The p-value density plot used in the presentation is in [`pvalue_density_plot.png`](pvalue_density_plot.png). To see all the plots together, see documentation in [`docs/pValue_density.md`](../../docs/pValue_density.md). In the final p-value density plot, many small pvalues can be observed suggesting that the difference in mean methylation signal between `cancer_type$primary` and `cancer_type$metastatic` is significant enough to reject the null hypothesis. 

## Hierarchical Clustering
The hierarchical clustering heatmap used in the presentation is in [`heatmap_with_clusters.png`](heatmap_with_clusters.png). To view all the plots together, see the documentation in [`docs/hierarchical_clustering.md`](../../docs/hierarchical_clustering.md). In the final heatmap, when the covariates `smoking_status`, `cancer_type` and `cancer` were coloured, there was no obvious pattern of clustering.

## Linear Regression
The linear regression tables used in the presentation are in [`primary_topGenes_limma2.csv`](primary_topGenes_limma2.csv) and [`primary_limma2.rds`](primary_limma2.rds). To view these tables, see the documentation [`docs/Linear_regression_results.md`](../../docs/Linear_regression_results.md). In the tables, we can see that although top differentially methylated genes were generated for all coefficients including the interaction term, the adjusted p value of around 0.99 meant that this differentially methylation was not significant enough and thus we fail to reject the null hypothesis for these genes. 

## Strip Plots
The strip plot used in the presentation is in [`stripplot_beta_cancer_type_primary.png`](stripplot_beta_cancer_type_primary.png). To view all the plots together, see the documentation in [`docs/strip_plots.md`](../../docs/strip_plots.md). In the final strip plot, it is evident that our top 10 differentially methylated genes are positively methylated in `primary` cancers, others positively methylated in `metastatic` cancers.

## Chromosome Plot
The chromosome plot used in the presentation is in [`chrplot.png`](chrplot.png). To see all the plots together, see the documentation [`docs/chr_plot.md`](../../docs/chr_plot.md). This plot helps visualize the differentially methylated regions along each chromsome. In this case, all probes belonging to differentially methylated genes were plotted. 

## Pathway Analysis
The pathway analysis tables used in the presentation is in [`KEGG_pathways_top10_genes`](KEGG_pathways_top10_genes) and [`pathway_KEGG_primary_genes`](pathway_KEGG_primary_genes). To see these tables, see the documentation [`docs/pathway_KEGG_top_genes.md`](../../docs/pathway_KEGG_top_genes.md). In the tables, we can see that the top pathways implicated
in our analysis are pathways such as alcoholism and viral carcinogenesis which
have been previously implicated in HNSCC.

