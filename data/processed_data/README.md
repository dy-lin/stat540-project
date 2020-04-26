# Processed Data

## In this repository
- [`metadata.rds`](metadata.rds): the processed metadata after cleaning the raw, generated using [`src/fetch_data.R`](../../src/fetch_data.R)
- [`male_metadata.csv`](male_metadata.csv): the processed metadata, filtered for males only, generated using [`src/hierarchical_clustering.R`](../../src/hierarchical_clustering.R) and used by [`src/linear_regression.R`](../../src/linear_regression.R)

## Not in this repository
- `data.rds`: the processed (reshaped) methylation data from GEO, generated using [`src/fetch_data.R`](../../src/fetch_data.R)
- `combined_data.rds`: the reshaped methylation data and cleaned metadata combined into one dataframe, generated using [`src/fetch_data.R`](../../src/fetch_data.R)
- `filtered_data.rds`: the subsetted (filtered) combined dataframe (e.g. removing females, and irrelevant metadata), generated using [`src/fetch_data.R`](../../src/fetch_data.R)
- `combined_mval_filtered.rds`: the reshaped filered methlyation data, transformed to m values, generated using [`src/boxplot_final.R`](../../src/boxplot_final.R) or [`src/strip_plot.R`](../../src/strip_plot.R)
- `scaled.rds`: the scaled beta values used for PCA, generated using [`src/PCA_final.R`](../../src/PCA_final.R)
