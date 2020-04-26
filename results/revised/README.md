# Revised Results

This directory will hold results derived from the questions asked in issue [#38](https://github.com/STAT540-UBC/Repo_team_The-Splice-Girls_W2020/issues/38).

#### Question 1: Since you have found that the first PCs are not related to the cancer_type, did you check if the first PCs are related to other covariates in data? If not, do you think if removing the first PCs from the data can improve the results?

PC1 vs PC2 coloured by other covariates were generated using [`src/PCA_final.R`](../../src/PCA_final.R) as part of the initial analysis. These plots can be viewed together in [`docs/PCA.md`](../../docs/PCA.md) under the `Scratch Results` section and are in [`results/scratch/`](../../results/scratch/). 

The new plots, plotting PC1 to PC10 across all covariates, were generated using [`src/PCA_revised.R`](../../src/PCA_revised.R) can be found in [`docs/PCA.md`](../../docs/PCA.md) under the `Revised Results` section, as well as in the current directory.


#### Question 4: Do slide 11 (left) and slide 12 show the same density of p-values? Please explain. In addition, a more comparable plot for the right panel of slide 11 might be to include only the p-values in the model for the cancer_type coefficient (and likewise only for age) separately - you can control this with the coef argument to topTable.
I revised the pvalue histograms for the model `cancer_type*age` where I inlcuded only pvalues for `cancer_type` coefficient and `age` seperately. The script for those revised histograms can be found here: [`src/pValHistogram_Revised.R`](../../src/pValHistogram_Revised.R). 


#### Question 5: What was the model used for results shown in slides 16-17? Why did you decide to proceed with the interaction model with age, rather than an additive model? Was a coefficient for primary vs metastatic included? It seems like some slides refer to a model with only cancer type, and others with primary cancer. Please explain.

The results from the other 2 coefficients in limma were included, age and age:primary_cancer(the interaction) as `csv` files to clarify that we used an `cancer_type*age` model and all of its results. The limma result of main coefficient of just primary cancer is found in [`results/final/`](../../results/final/).
