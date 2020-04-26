#author: Almas K.
#date : 2020-04-02

'This script is for linear regression in R'

## Libraries

library(tidyverse)
library(reshape2)
library(stringr)
library(here)
library(lumi)
library(limma)
library(FDb.InfiniumMethylation.hg19)

## Import Data

male_metadata <- read_csv(here("data","processed_data","male_metadata.csv"))
data_limma <- readRDS(here("data","raw_data","data_for_limma.rds"))
tsv_file <- read_tsv(here("data","raw_data","EPIC.hg38.manifest.tsv.gz")) #annotation file

## Convert Betas to M values

data_mval <- beta2m(data_limma)

## Edit Metadata
male_metadata$cancer <- as.factor(male_metadata$cancer)
male_metadata$cancer_type <- as.factor(male_metadata$cancer_type)

##Custom Annotation Function for limma:

genes_annotator <- function(t_tab){
  annotated <-tsv_file %>%
    filter(probeID %in% rownames(t_tab)) %>%
    dplyr::select(CpG_chrm,probeID,gene,gene_HGNC)
  
  t_table_joined <-t_tab %>%
    mutate(probeID=rownames(t_tab)) %>%
    left_join(.,annotated, by="probeID")
  
  t_table_joined
}
## Limma using Primary vs Metastatic cancer and age
d_matrix2 <- model.matrix(~cancer_type*age,male_metadata)
lm_fit2 <- lmFit(data_mval,d_matrix2)
eBayes2 <- eBayes(lm_fit2)

## Annotate Limma Results 
v2_t_table <- topTable(eBayes2,coef = "cancer_typeprimary") ## Primary genes coefficient
v2_t_table <- genes_annotator(v2_t_table)
knitr::kable(v2_t_table)
v2_t_table2 <- topTable(eBayes2,coef = "cancer_typeprimary:age")
v2_t_table2 <- genes_annotator(v2_t_table2)
knitr::kable(v2_t_table2)
v2_t_table3 <- topTable(eBayes2,coef = "age")
v2_t_table3 <- genes_annotator(v2_t_table3)
knitr::kable(v2_t_table3)

## Look for missing gene names in v2_t_table using the 450K annotation and find them
hm450 <-  getPlatform(platform='HM450', genome='hg19')
annot450 <- FDb.InfiniumMethylation.hg19::getNearestGene(hm450)
annot450 <- annot450 %>% mutate(probeID=rownames(annot450))
NA_genes <- v2_t_table %>%
  filter(is.na(gene))
found_gene <- annot450 %>%
  filter(probeID %in%(NA_genes$probeID)) ## only found label for one of them
v2_t_table <- v2_t_table %>%
  mutate(gene=(if_else(probeID %in% found_gene$probeID,found_gene$nearestGeneSymbol,gene)))

## Saving the Csv results for Annotated top table genes
write_csv(v2_t_table,here("results","final","primary_topGenes_limma2.csv"))
write_csv(v2_t_table3,here("results","revised","age_top_genes_limma2.csv"))
write_csv(v2_t_table2,here("results","revised","ageandprimary_top_genes_limma2.csv"))