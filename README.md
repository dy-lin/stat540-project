# The Splice Girls
## Table of Contents
1. [Team Members](#team-members)
1. [Project Proposal](#project-proposal)
1. [Dataset](#dataset)
1. [Presentation](#presentation)
1. [Summary](#summary)
    1. [Data Retrieval](#data-retrieval)
    1. [Principal Component Analysis](#principal-component-analysis)
    1. [Beta Density Plot](#beta-density-plot)
    1. [Box Plots](#box-plots)
    1. [P-value Histograms](#p-value-histograms)
    1. [P-value Density Plot](#p-value-density-plot)
    1. [Hierarchical Clustering](#hierarchical-clustering)
    1. [Linear Regression](#linear-regression)
    1. [Strip Plots](#strip-plots)
    1. [Chromosome Plot](#chromosome-plot)
    1. [Pathway Analysis](#pathway-analysis)
    1. [Gene Set Enrichment Analysis](#gene-set-enrichment-analysis)
1. [Division of Labour](#division-of-labour)

## Team Members
| Name | Department/Program | Expertise/Interests |GitHub ID | 
| ------------- | ------------- | ------------- | ------------- |
| Diana Lin | Bioinformatics | Genome/Transcriptome Assembly, Bioinformatics Pipeline Development, Mammalian Physiology, Datamining | [@dy-lin](https://github.com/dy-lin) |
| Almas Khan | Bioinformatics  | Epigenetics, mammalian biology, microbiology  |[@almas2019](https://github.com/almas2019) |
| Denitsa Vasileva | Bioinformatics  | Gene Set Enrichment Analysis, Epigenetics, PPI Networks  |[@Deni678](https://github.com/Deni678)|
| Nairuz Elazzabi | Medical Genetics | Neurodevelopmental Genetics, Epigenetics, Transcriptome Profiling | [@Nayrouz109](https://github.com/Nayrouz109)|


## Project Proposal
Our project proposal can be viewed [here](project_proposal.md).

## Progress Report
Our progress report can be found [here](progress_report.md).

## Dataset
* [GSE124052](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124052)

## Presentation
Our presentation slides can be found [here](presentation.pptx).

Our presentation document can be found [here](presentation_document.docx).

## Summary

### Data Retrieval
**Aims:** to retrieve the GEO dataset and output it in a readily usable form (i.e. reshaped, filtered, wrangled, etc.), using [`src/fetch_data.R`](src/fetch_data.R).<br/>
**Conclusions:** there are a lot of `.rds` objects written by the script but are not present in the repository due to the GitHub file size limit. Those that are present can be found in [`data/raw_data/`](data/raw_data/) and [`data/processed_data/`](data/processed_data/).

### Principal Component Analysis 
**Aims:** to see if there is an underlying signal that causes the data to cluster in a certain way, using [`src/PCA_final.R`](src/PCA.final.R).<br/>
**Results**: results can be found in the [`results/final/`](results/final/) directory as well as in the documentation [`docs/PCA.md`](docs/PCA.md).<br/>
**Conclusions:** the data for PC1 vs PC2; PC2 vs PC3; PC1 vs PC3; does not cluster by any of the covariates.<br/>

### Box Plots
**Aims:** to discern any patterns in beta value distribution across the various samples, using [`src/boxplot_final.R`](`src/boxplot_final.R`).<br/>
**Results**: results can be found in the [`results/final/`](results/final) directory as well as in the documentation [`docs/boxplots.md`](docs/boxplots.md).<br/>
**Conclusions:** there is no discernable pattern in the distribution of beta values across the samples.

### P-value Histograms 
**Aims:** To visualize p-value distribtuin for two different models `cancer_type*age` and `cancer_type`, using [`src/pValueHistogram.R`](src/pValueHistogram.R).<br/> 
**Results:** results can be found in [`results/final/`](results/final/) directory as well as in the documentation [`docs/pValue_Histogram.md`](docs/pValue_Histogram.md).<br/> 
**Conclusions:** The model `cancer_type*age` does not produce enough statisitical power as pvalues are "uniformally" distributed and thus we cannot reject the null hypothesis that the interaction between cancerType and age does not affect methylation signal. However, the model `cancer_type` produces some statistical power as many pvalues appear as a peak near 0 and thus providing enough evidence to reject the null hypothesis.  

### P-value Density Plot
**Aims:** To compute and visualize p-value density estimates. pValues were generated using a two-sample t-test of the two samples `cancer_type$primary` and `cancer_type*metastatics`, using [`src/pvalue_density_plot.R`](src/pvalue_density_plot.R).<br/> 
**Results:** results can be found in [`results/final/`](results/final/) directory, as well as in the documentation [`docs/pValue_density.md`](docs/pValue_density.md).<br/> 
**Conclusions:** The difference in mean methylation signal between the two samples `cancer_type$primary` and `cancer_type$metastatic`seems to be significant enough to reject the null hypothesis as many small pvalues are displayed in the plot. 

### Beta Density Plot
**Aims:** to examine the density of beta values across two different cancer types
using the [`src/beta_density_plot.R`](src/beta_density_plot.R) script.<br/>
**Results:** results can be found in [`results/final/`](results/final/) directory as well as in the documentation [`docs/beta_density.md`](docs/beta_density.md).<br/>
**Conclusions:** no significant difference in the density distribution of beta values in the different cancer types

### Hierarchical Clustering 
**Aims:** To perform hierarchical clustering of beta values to see if there is a pattern of certain samples clustering together, using [`src/hierarchical_clustering.R`](src/hierarchical_clustering.R).<br/>
**Results:** results can be found in the [`results/final/`](results/final/) directory, as well as in the documentation [`docs/hierarchical_clustering.md`](docs/hierarchical_clustering.md).<br/>
**Conclusions:** No common patterns of clusters was seen when colouring covariates.

### Linear Regression
**Aims:** To perform linear regression to get a better understanding of differentially methylated genes across a variety of conditions using the script  [`src/linear_regression.R`](src/linear_regression.R).The conditions were age, cancer_type (primary vs metastatic) and an interaction term of cancer_type:age.<br/>
**Results:** results can be found in the [`results/final/`](results/final/) and [`results/revised/`](results/revised/)directory, as well as in the documentation [`docs/Linear_regression_results.md`](docs/Linear_regression_results.md).<br/>
**Conclusions:** Based on the high adjusted p values (calculated using B-H method of multiple test correction), there was no signficantly differentially methylated genes in any of the conditions mentioned above. 
### Strip Plots
**Aims:** to visualize the distribution of beta values across all samples faceted by the top ten genes, using [`src/strip_plot.R`](src/strip_plot.R).<br/>
**Results:** results can be found in the [`results/final/`](results/final) directory as well as in the documentation [`docs/strip_plots.md`](docs/strip_plots.md).<br/>
**Conclusions:** the top 10 genes include those that are positively differentially methylated in `primary` cancers, as well as genes that are negatively differentially methylated in `primary` cancers.

### Chromosome Plot
**Aims:** to visualize the differentially methylated regions along all the chromosomes, using [`src/chr_plot.R`](src/chr_plot.R).<br/>
**Results:** results can be found in the [`results/final/`](results/final/) directory as well as in the documentation [`docs/chr_plot.md`](docs/chr_plot.md).<br/>
**Conclusions:** there are differentially methylated regions along every single chromosome.

### Pathway Analysis
**Aims:** To identify KEGG pathways that the genes identified by limma are
enriched in,using  [`src/API_pathways_KEGG.R`](src/API_pathway_KEGG.R).<br/>
**Results:** results can be found in the [`results/final/`](results/final/) directory as well as in the documentation [`docs/pathway_KEGG_top_genes.md`](docs/pathway_KEGG_top_genes.md).<br/>
**Conclusions:** Genes in KEGG pathways that have been previously implicated in HNSCC in the literature were shown to be enriched in our analysis.

### Gene Set Enrichment Analysis
**Aims:** To identify gene sets enriched for the top  genes identified by 
the limma analysis,using [`docs/gene_set_enrichment.md`](docs/gene_set_enrichment.md)  <br/>
**Results:** The script [`docs/gene_set_enrichment.md`](docs/gene_set_enrichment.md) displayed the following error message:
```
Error in (function (annotation = NULL, aspects = c("Molecular Function", : Something went wrong. 
Blame the dev 
INFO: Data directory is /Users/almas/ermineJ.data 
DEBUG: Custom gene sets directory is /Users/almas/ermineJ.data/genesets 
DEBUG: Setting score start column to 2 
INFO: Gene symbols for each term will be output Reading GO descriptions from /Users/almas/Documents/GitHub/Repo_team_The-Splice-Girls_W2020/src/GO.xml ... 
INFO: Could not locate aspect for GO:0018704: obsolete 5-chloro-2-hydroxymuconic semialdehyde dehalogenase activity
INFO: Could not locate aspect for GO:0006494: obsolete protein amino acid terminal glycosylation 
INFO: Could not locate aspect for GO:0006496: obsolete protein amino acid terminal N-glycosylation 
INFO: Could not locate aspect for GO:0090413: obsolete negative regulation of transcription from RNA polymerase II promoter involved in fatty acid biosynthetic process 
INFO: Could not locate aspect for GO:0090412: obsolete positive regulation of transcription from RNA polymerase II promoter involved in fatty acid biosynthet
```
**Conclusions:** Software incompatibility prevented us from running this analysis.

## Division of Labour

Group Member | Scripts | Other
-------------|---------|---------
Diana Lin | [`src/fetch_data.R`](src/fetch_data.R), [`src/PCA_final.R`](src/PCA_final.R), [`src/PCA_revised.R`](src/PCA_revised.R), [`src/boxplot_final.R`](src/boxplot_final.R), [`src/strip_plot.R`](src/strip_plot.R), [`src/chr_plot.R`](src/chr_plot.R)| GitHub management (directory structure, READMEs, general issues), administrative tasks (deliverable submission)
Almas Khan | [`src/hierarchical_clustering.R`](src/hierarchical_clustering.R), [`src/linear_regression.R`](src/linear_regression.R)| GitHub Management (moving files, editing READMEs)
Denitsa Vasileva | [`src/beta_density_plot.R`](src/beta_density_plot.R), [`src/API_pathways_KEGG.R`](src/API_pathways_KEGG.R) | GitHub management (editing READMEs), administrative tasks (deliverable submission)
Nairuz Elazzabi | [`src/pValueHistogram.R`](src/pValueHistogram.R), [`src/pvalue_density_plot.R`](src/pvalue_density_plot.R), [`src/pValHistogram_Revised.R`](src/pValHistogram_Revised.R) | GitHub management (editing READMEs) 
