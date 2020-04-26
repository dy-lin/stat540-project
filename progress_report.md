# Progress Report

## What has changed based on the final proposal? (2 pt.)

### Did your dataset change? If so, why?

Our dataset has not changed since the finalized proposal.

### Have you decided to do a different analysis than what was mentioned in your proposal? If so, Why?

Our analysis has largely remained unchanged from the one outlined in our proposal.
However, due to computational power limitations, it might be necessary to subset the dataset as to reduce the number of 
probes (CG sites). Currently, our dataset consists of  just over 850K CpG sites.

### Are there any changes in task assignments of group members?

Based on comments from Sina about our task assignments in the finalized proposal, we have adjusted the work so that 
every group member runs some aspect of the statistical analysis. 

Here is an updated table:

Group Member|Background|Degree|Affiliation|Job Assignment
------------|----------|------|-----------|---------------
Diana Lin|BSc in Physiology|MSc in Bioinformatics|Birol Lab, Genome Sciences Centre, BC Cancer|PCA analysis, box plot distributions,gene ontology and pathway analysis
Almas Khan|BSc in Microbiology and Immunology|MSc in Bioinformatics|Robinson Lab, BC Children's Hospital Research Center|hierarchical clustering, interaction plot, heatmap, Beta density per sample plot
Denitsa Vasileva|BSc in Bioinformatics|MSc in Bioinformatics|Daley Lab, St. Paul's Hospital|Density plot
Nairuz Elazzabi|BSc in Biological Sciences|MSc in Medical Genetics|Goldowitz Lab, BC Children's Hospital Research Center|p-value histogram, filtering, `limma` for statistical analysis, heatmap clustering for top CpG


## What is the progress of the analyses (5 pts.)

### Briefly and concisely explain your methodology and progress for the aims you have investigated so far.

- **Quality control**: once the data was imported into R, we evaluated its quality by computing p-values for every probe in every sample. This serves as an indication of the quality of the methylation signal of each probe. Small p-values (below 0.05) are indicative of a reliable signal while larger p-value (>0.05) indicate a poor quality signal. Once p-values are calculated, we generated a p-value histogram to obtain an estimate of the overall signal quality. 
- **Normalization**: the dataset was already normalized using noob.

- **Exploratory analysis**: 
  - **PCA plots**: To identify the primary determinants of variance in methylation signal, we performed principal component analysis.  
  - **Box plots**: To screen for potential problems with our dataset, we generated box plots as we are expecting certain CpG to be differentially methylated across some cancer types, but we are not expecting all the CpGs in a few particular samples to differ from all other samples. 
p-values histogram, 
  - **Average beta value density plots**: Beta values represent the ratio of probe intensities. They range between 0 and 1 and are used as a proxy to estimate methylation levels. A value of 0 indicates that all copies of the CpG site are completely unmethylated and a value of 1 indicates that every copy of the site is methylated. A density plot of average beta values allows us to show the distribution of beta values in each type of cancer -i.e. metastatic vs primary. The density plot was generated using only the 10,000 (out of 860,000) CpGs due to memory and computational constraints. 
  - **Beta value density plot per sample** : Beta value density plots for each sample were also calculated. There was generally little difference between the beta value density of metastatic cancer samples compared to primary cancer samples. In addition, within each type of cancer, beta densities of samples tend to overlap which indicates that beta values are fairly homogeneous within samples of the same cancer type. This used all 860,000 CpG sites.
  - **Hierarchical clustering**: To look at patterns within the data, hierarchical clustering was performed using the Euclidean distance and average linkage methods.The dendrogram was generated to look at the overall clustering for the different samples as well as the features associated with these samples. Additionally, the tree was divided into 10 clusters. 
  - **Heatmap**: To look at the top differentially methylated CpG sites, a heatmap was then generated using the same Euclidean distance as the hierarchical clustering. 
 
- **Filtering**: to reduce the number of statistical tests and multiple testing penalty, we filtered out poor performing probes prior to differential methylation analysis. The filtering was done on the basis of CpG p-values. More specifically, CpG probes with p-values less than 0.05 we kept while the rest were filtered out.   

### Which parts were modified and which parts remained the same?

The exploratory analysis (box plots, p-value histograms, etc). was not part of our original workflow. 
We may have to add filtering to deal with the large dataset. Everything else remains the same.

### What R packages or other tools are you using for your analyses? You do not need to provide your scripts in your report.

library(GEOquery)

library(tidyverse)

library(reshape2)

library(limma)

library(minfi) 

library(lumi)

library (IlluminaHumanMethylationEPICmanifest)

library (corrplot)

### Provide the links to any markdown reports within your repo to refer to the relevant analysis. Provide references.

Due to our large datasets, we were unable to successfully knit some of our Rmarkdown files, 
using R scripts instead in the end. 
We have generated two markdown reports: [PCA/Boxplots](src/pca-boxplot.md) and [Hierarchical Clustering](src/hierarchical_clustering.md). 
Although we have these two markdown reports, most of our analysis is actually done in this progress report right now.


## Results

### What are your primary results?

- **PCA plots**: The PCA plots did not show any clustering by any covariate.
- **Box plots**: Each sample shows a similar distribution of beta values.
- **Hierarchical clustering**: Overall, we saw that in many cases the same type of cancer (origin from the same tissue like lung or primary head and neck) tended to cluster together. 
When generating 10 clusters and looking at the metadata associated with the samples in the cluster, we found no additional meaningful patterns.
From the dendrograms, multiple clusters are fused through the splitting of the horizontal line into 2 horizontal lines. In addition, the distance between every two clusters is very small as shown by short vertical bars. Also, there are barely any distinct outliers found at much higher distances. Altogether, the agglomerative hierarchical clustering show that the data is very similar and that variables such as smoking status, cancer type (primary vs metastatic), and cancer origin fail to cluster and define similarity patterns within the dataset.    

- **Heatmap**:  The heatmap shows a number of CpG sites within the samples that were differentially methylated and that we would be interested in potentially exploring further. 
- **P-value histogram**: Due to large data size and computational constraints, a random, smaller subset was created (10,000 CpGs) and used to generate a p-value histogram. One sample t-tests were applied to each CpG probe; the resulting p-values were visualized with ggplot2 histogram plot. In the histogram, the p-values appear to be relatively uniform except for the clear overabundance of very low p-values. The flat uniform distribution along the bottom between 0 and 1 is all the null p-values while the peak close to 0 dictates alternative hypotheses along with possible false positives.
- **Average beta density plot**: Due to constraints in computational power, this plot was only done using 10,000 CpGs (rather than the full set of 850K). Nevertheless, the plot showed that the density of the average beta values in the metastatic cancer cases is generally similar to that of the primary cancer samples and the two plots tend to overlap. This pattern may change when all CpG sites are included in the diagram. 

### Were you able to answer your hypothesis?

We were unable to answer our hypothesis at this point in our analyses.

### Did you have any positive results? If no, postulate a discussion as to why that may be.

We have not been able to obtain any positive results at this stage. The hierarchical clustering did not show any biologically meaningful pattern to differentiate methylation patterns in primary vs metastatic cancer. Rather, samples appear to cluster based on their tissue of origin- e.g. all head and neck cancers cluster together. This points to the need for use of other clustering methods such as K-means.

### Provide plots and/or tables to present your results.
[Clustering heatmap](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/Clustering_Heatmap.pdf)

[Hierarchical Clustering Plot for Cancer Origin by Tissue](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/hierarchical_clustering_files/figure-markdown_github/unnamed-chunk-9-3.png)

[Folder for hierarchical clustering plots](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/tree/master/src/hierarchical_clustering_files/figure-markdown_github)

[Folder for PCA plots](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/tree/master/src/pca_boxplot_files/figure-gfm)

[PCA plot for Metastatic Cancer](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/pca_boxplot_files/figure-gfm/cancer-type-1.png)

[P value Histogram](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/pvalueHistogram.pdf])

[Beta by sample](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/beta_by_sample_files/figure-markdown_github/unnamed-chunk-4-3.png)

[Beta Density-Average](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/blob/master/src/beta_density.pdf)

### List some challenges that you encountered? How will you address them?

The (large) dataset was harder to work with than anticipated-- it would repeatedly crash the RStudio on our laptops, 
so some scripts had to be run on a high performance computing cluster at the GSC. 
Additionally `minfi` only works on `idat` files, so we will have to go back and do the normalization and 
annotation ourselves using the raw data.



