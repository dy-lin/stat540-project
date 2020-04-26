# Project Proposal
This is the finalized project proposal for The Splice Girls.

## Table of Contents

1. [Motivation and Background](#motivation-and-background)
1. [Division of Labour](#division-of-labour)
1. [Dataset](#dataset)
1. [Aims and Methodology](#aims-and-methodology)
1. [References](#references)

## Motivation and Background
Late-stage Head and Neck Squamous Cell Carcinoma (HNSCC) is associated with high mortality rates. To improve this, it is crucial to develop methods to  differentiate between HNSCC lung metastases and primary squamous cell carcinoma (LUSC)- a different, highly-treatable type of cancer that is frequent in patients with HNSCC [1]. 
Previous studies have identified differentially methylated gene loci implicated in primary vs metastatic tumours in other cancer types [2].

The aim of our project is to identify differentially methylated CpGs which can be used to distinguish between HNSC lung metastases and primary LUSC. This will allow us to gain greater understanding of the differences in the genetic and epigenetic mechanisms between the two types of cancer which can aid in the development of  tools for more accurate differentiation and diagnosis.

## Division of Labour
We have assigned each step of our workflow to at least one group member:

Group Member|Background|Degree|Affiliation|Job Assignment
------------|----------|------|-----------|---------------
Diana Lin|BSc in Physiology|MSc in Bioinformatics|Birol Lab, Genome Sciences Centre, BC Cancer|Data and GitHub management, gene ontology and pathway analysis
Almas Khan|BSc in Microbiology and Immunology|MSc in Bioinformatics|Robinson Lab, BC Children's Hospital Research Center|Quality control of the raw data, data normalization
Denitsa Vasileva|BSc in Bioinformatics|MSc in Bioinformatics|Daley Lab, St. Paul's Hospital|`limma` for statistical analysis
Nairuz Elazzabi|BSc in Biological Sciences|MSc in Medical Genetics|Goldowitz Lab, BC Children's Hospital Research Center|`limma` for statistical analysis

## Dataset
We will be using a GEO [3] dataset ([GSE124052](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124052)) which has previously been used to train a machine learning classifier [4]. This dataset consists of  both raw and noob-normalized beta values measured from 51 male participants using  the Illumina Infinium MethylationEPIC BeadChip. Each of the participants was diagnosed with either primary LUSC or lung metastases from  HNSCC- ascertained using histopathological, clinical and radiological evidence. The male samples were between the ages of 45-80 years old and were either former or active smokers at the time of recruitment.

## Aims and Methodology

The specific research question we are addressing is: Are there individual CpG sites/islands with significant differences in methylation level in primary LUSC versus HNSCC metastases?  

To address this question, we will create a linear model with covariates for potential confounding factors such as age and smoking status. Methylation levels can be measured through either M-values or beta values [5]. M-values are a log<sub>2</sub> ratio of methylated vs unmethylated probe intensities and beta values are a ratio of the maximum methylated intensity over total intensities from both probes. However, Beta-value distribution is on the interval (0-1) which is not very compatible with the assumptions of linear models. Thus, M-values will be used for the differential analysis of methylation levels as they are more statistically valid [5]. This probe-wise analysis will be carried out using `minfi` [6] and `limma` [7].  However, since we are performing multiple hypothesis tests, the p-values for each CpG site will need to be adjusted for multiple testing bias using Bonferroni correction [8]. 

To understand the biological significance of the differentially methylated CpG sites, those sites will then be mapped to genes. Then, gene set enrichment analysis in Gene Ontology (GO) [9,10] and the Kyoto Encyclopedia of Genes and Genomes (KEGG) [11–13] will be performed to detect differences in the biological mechanisms behind the two types of cancer. In addition, we will focus on the two gene loci, `EBF3` and `TBC1D16`, which have been shown in a previous study to be differentially methylated in numerous metastatic cancer types when compared to their primary cancer type [2]. 

Thus, the general workflow we will use to address our research question is: 

1. Gather data, reshape it, and update GitHub repository 
1. Quality control of the raw data (`minfi` [6] package in R) 
    1. Confirm reported sex
    1. Technical QC of samples
1. Normalization of data (comparing methods such as noob and quantile normalization)
1. Use `limma` [7] to find the top 10 (or more) differentially methylated sites of statistical significance from the normalized data, while addressing covariates and potential confounding factors
1. Annotate top 10 (or more) methylation sites to their genes using `FDb.InfiniumMethylation.hg19` package [14]
1. Use gene ontology (GO) [9,10] and KEGG [11–13] analysis to understand biological significance of top differentially methylated sites 

## References

1. Pereira TC, Share SM, Magalhães AV, Silverman JF. Can we tell the site of origin of metastatic squamous cell carcinoma? An immunohistochemical tissue microarray study of 194 cases. Appl Immunohistochem Mol Morphol. 2011;19: 10–14.
1. Rodger EJ, Chatterjee A, Stockwell PA, Eccles MR. Characterisation of DNA methylation changes in EBF3 and TBC1D16 associated with tumour progression and metastasis in multiple cancer types. Clin Epigenetics. 2019;11: 1–11.
1. Barrett T, Wilhite SE, Ledoux P, Evangelista C, Kim IF, Tomashevsky M, et al. NCBI GEO: archive for functional genomics data sets--update. Nucleic Acids Res. 2013;41: D991–5.
1. Jurmeister P, Bockmayr M, Seegerer P, Bockmayr T, Treue D, Montavon G, et al. Machine learning analysis of DNA methylation profiles distinguishes primary lung squamous cell carcinomas from head and neck metastases. Sci Transl Med. 2019;11.
1. Du P, Zhang X, Huang C-C, Jafari N, Kibbe WA, Hou L, et al. Comparison of Beta-value and M-value methods for quantifying methylation levels by microarray analysis. BMC Bioinformatics. 2010;11: 587.
1. Aryee MJ, Jaffe AE, Corrada-Bravo H, Ladd-Acosta C, Feinberg AP, Hansen KD, et al. Minfi: a flexible and comprehensive Bioconductor package for the analysis of Infinium DNA methylation microarrays. Bioinformatics. 2014;30: 1363–1369.
1. Ritchie ME, Phipson B, Wu D, Hu Y, Law CW, Shi W, et al. limma powers differential expression analyses for RNA-sequencing and microarray studies. Nucleic Acids Res. 2015;43: e47.
1. Maksimovic J, Phipson B, Oshlack A. A cross-package Bioconductor workflow for analysing methylation array data. F1000Res. 2016;5: 1281.
1. Ashburner M, Ball CA, Blake JA, Botstein D, Butler H, Cherry JM, et al. Gene ontology: tool for the unification of biology. The Gene Ontology Consortium. Nat Genet. 2000;25: 25–29.
1. The Gene Ontology Consortium. The Gene Ontology Resource: 20 years and still GOing strong. Nucleic Acids Res. 2019;47: D330–D338.
1. Kanehisa M. KEGG: Kyoto Encyclopedia of Genes and Genomes. Nucleic Acids Research. 2000. pp. 27–30. doi:10.1093/nar/28.1.27
1. Kanehisa M, Sato Y, Furumichi M, Morishima K, Tanabe M. New approach for understanding genome variations in KEGG. Nucleic Acids Res. 2019;47: D590–D595.
1. Kanehisa M. Toward understanding the origin and evolution of cellular organisms. Protein Sci. 2019;28: 1947–1951.
1. Triche JT. FDb.InfiniumMethylation.hg19: Annotation package for Illumina Infinium DNA methylation probes. R package version 2.2.0. 2014.
