
#Libraries needed 
library(here)
library(tidyverse)
library(dplyr) 
library(reshape2)
library(knitr)
BiocManager::install("lumi")
library(lumi)
library(stringr)
library(tictoc)
library(ggdendro)
library(dendextend)
library(limma)

#Load the files/data 
exp_data <- readRDS(here("data", "raw_data", "data.rds"))
metadata <- readRDS(here("data","processed_data","metadata.rds"))
tsv_file <- read_tsv(here("data","raw_data","EPIC.hg38.manifest.tsv.gz")) 

#filtering the data 
#exclude females 
male_metadata <- metadata %>%
  filter(sex=="Male")
rownames(male_metadata) <- male_metadata$sample

str(male_metadata)
male_metadata <- male_metadata %>%
  mutate(which_cancer=if_else(cancer=="Pulmonary metastasis of head and neck squamous cell carcinoma","HNSC","Lung"))

male_metadata$cancer <- as.factor(male_metadata$cancer)
male_metadata$cancer_type <- as.factor(male_metadata$cancer_type)

#get limma data 
exp_data1 <- exp_data %>% column_to_rownames("CG") 
limma_data1 <- exp_data1 %>%
  dplyr::select_if((names(.) %in% male_metadata$sample)) 


#m-values
datamval1 <- beta2m(limma_data1)
(male_metadata$sample == names(datamval1)) %>% all()

#run limma cancer_type
#---------------get the limma metadata and exp data 
limma4_metaData <- male_metadata %>% dplyr::select (sample, cancer, sex, age, cancer_type)
limma4_metaData$cancer_type <- as.factor(limma4_metaData$cancer_type) 

#exp data 
limma4_expData <- datamval1 

#check the equivalence between metaData and expData 
(limma4_metaData$sample == names(limma4_expData)) %>% all()
#make sure age is a continouse numeric variable 
limma4_metaData$age <- as.numeric(limma4_metaData$age)

#------------------------------run limma
#design the model 
design4 <- model.matrix(~cancer_type , limma4_metaData)

#fit the model 
fit4 <- lmFit(limma4_expData, design4) %>% eBayes() 

#---------------------------------p-value histogram distribution 
pvalues4 <- topTable(fit4, number = Inf) 
pvalHistogram4 <- pvalues4 %>% 
  ggplot (aes(P.Value)) + geom_histogram()  
pvalHistogram4

#run limma cancer_type*age  
design5 <- model.matrix(~cancer_type*age , limma4_metaData)

#fit the model 
fit5 <- lmFit(limma4_expData, design5) %>% eBayes() 

#---------------------------------p-value histogram distribution 
pvalues5 <- topTable(fit5, number = Inf) 
pvalHistogram5 <- pvalues5 %>% 
  ggplot (aes(P.Value)) + geom_histogram() 
pvalHistogram5


