## Author: Diana Lin
## Date: January 26, 2020

library(GEOquery)
library(tidyverse)
library(reshape2)
library(here)

# if an RDS object already exists, do not fetch again, read the RDS
if (!file.exists(here("data", "raw_data", "gds.rds"))) {
    gds <- getGEO("GSE124052")[[1]]
    saveRDS(gds, file = here("data", "raw_data", "gds.rds"))
} else {
    gds <- readRDS(file = here("data", "raw_data", "gds.rds"))
}

# metadata from the raw normalized data
metadata_master <- pData(gds) %>%
    rownames_to_column(var = "sample")

# save as RDS
if (!file.exists(here("data", "raw_data", "metadata.rds"))) {
    saveRDS(data.frame(metadata_master), file = here("data", "raw_data", "metadata.rds"))
}

# Filter the metadata
metadata_filtered <- metadata_master %>%
    select(
        sample,
        source = source_name_ch1,
        cancer = title,
        sex = `gender:ch1`,
        age = `age:ch1`,
        smoking = `smoking status (pack years):ch1`,
        hpv = `hpv genotyping:ch1`,
        p16 = `p16 immunohistochemistry:ch1`,
        dna = `dna input [ng]:ch1`,
        tumour = `tumor cell content (%):ch1`,
        origin = `hnsc site of origin:ch1`
    ) %>%
    mutate(cancer_type = case_when(
        str_detect(cancer, "metastasis") ~ "metastatic",
        TRUE ~ "primary"
    ))

# Neaten the values to be consistent, etc. 
metadata_filtered$cancer <-
    str_remove(metadata_filtered$cancer, ".+: ") %>%
    str_remove(" ..$") %>%
    as.factor()
metadata_filtered$cancer_type <- as.factor(metadata_filtered$cancer_type)
metadata_filtered$tumour <- metadata_filtered$tumour %>%
    str_remove(fixed("%")) %>%
    as.double()

metadata_filtered <- metadata_filtered %>%
    separate(smoking,
             into = c("smoking_status", "packs_per_year"),
             sep = "\\(")

metadata_filtered$smoking_status <-
    str_remove(metadata_filtered$smoking_status, "smoker") %>%
    str_remove("  100 py") %>% 
    str_replace("Former\\s*","Former") %>%
    as.factor()

metadata_filtered$packs_per_year <-
    str_remove(metadata_filtered$packs_per_year, fixed("py)")) %>%
    str_remove(fixed(")")) %>% 
    as.double()

metadata_filtered$source <-
    str_replace(metadata_filtered$source, "Biospy", "Biopsy") %>%
    as.factor()

metadata_filtered$hpv <- str_replace(metadata_filtered$hpv, "Negativ", "Negative") %>%
    str_replace("Negativee", "Negative") %>%
    as.factor()
metadata_filtered$sex <- as.factor(metadata_filtered$sex)
metadata_filtered$age <- as.double(metadata_filtered$age)
metadata_filtered$hpv <- as.factor(metadata_filtered$hpv)
metadata_filtered$p16 <- as.factor(metadata_filtered$p16)
metadata_filtered$dna <- as.double(metadata_filtered$dna)
metadata_filtered[metadata_filtered == "Not applicable"] <- NA
metadata_filtered$origin <- str_replace(metadata_filtered$origin, "Tounge", "Tongue") %>%
    as.factor()

# Process the metadata and save it 
metadata_filtered <-
    rename(metadata_filtered,
           dna_ng = dna,
           tumour_percent = tumour)
metadata_filtered$sample <- as.factor(metadata_filtered$sample)

if (!file.exists(here("data", "processed_data", "metadata.rds"))) {
    saveRDS(data.frame(metadata_filtered), file = here("data", "processed_data", "metadata.rds"))
}

# extract the methylation data from the GEO object
if (!file.exists(here("data", "raw_data", "data.rds"))) {
    raw_data <- exprs(gds)
    raw_data <- rownames_to_column(data.frame(raw_data), "CG")
    saveRDS(raw_data, file = here("data", "raw_data", "data.rds"))
} else {
    raw_data <- readRDS(file = here("data", "raw_data", "data.rds"))
}

# write the processed data out into an RDS or load one in 
if (!file.exists(here("data", "processed_data", "data.rds"))) {
    shaped_data <- melt(raw_data, id.vars = c("CG"), var = "sample")
    saveRDS(shaped_data, file = here("data", "processed_data", "data.rds"))
} else {
    shaped_data <- readRDS(file = here("data", "processed_data", "data.rds"))
}

# Combine the metadata and methylation data 
if (!file.exists(here("data", "processed_data", "combined_data.rds"))) {
    data <- left_join(metadata_filtered, shaped_data, by = "sample")
    saveRDS(data, file = here("data", "processed_data", "combined_data.rds"))
} else {
    data <- readRDS(file = here("data", "processed_data", "combined_data.rds"))
}

# Subset the combined data
if (!file.exists(here("data", "processed_data", "filtered_data.rds"))) {
    data_subset <- data %>%
        filter(sex == "Male") %>%
        select(c("sample", "source", "cancer", "age", "origin", "cancer_type", "CG", "value"))
    saveRDS(data_subset, file = here("data", "processed_data", "filtered_data.rds"))
} else {
    data_subset <- readRDS(file = here("data", "processed_data", "filtered_data.rds"))
}

summary(data_subset)