Data Fetching
================

Load necessary packages:

``` r
library(GEOquery)
library(tidyverse)
library(reshape2)
library(stringr)
library(here)
library(tictoc)
```

Get the GEO dataset: `GSE124052`

``` r
tic.clearlog()
if (!exists("gds", inherit = FALSE)) {
    if (!file.exists(here("data", "raw_data", "gds.rds"))) {
        tic("Get GEO object using GEOquery")
        gds <- getGEO("GSE124052")[[1]]
        toc(log = TRUE) # 454.717 sec elapsed
        tic("Save GEO object as RDS")
        saveRDS(gds, file = here("data", "raw_data", "gds.rds"))
        toc(log = TRUE) # 52.746 sec elapsed
    } else {
        tic("Read RDS as GEO object")
        gds <- readRDS(file = here("data", "raw_data", "gds.rds"))
        toc(log = TRUE)
    }
}
```

    ## Read RDS as GEO object: 4.552 sec elapsed

Get appropriate data from the `gds` object:

``` r
tic("Get metadata from the GEO object")
metadata_master <- pData(gds) %>%
    rownames_to_column(var = "sample")
toc(log = TRUE) # 0.135 sec elapsed
```

    ## Get metadata from the GEO object: 0.127 sec elapsed

``` r
if (!file.exists(here("data", "raw_data", "metadata.csv"))) {
    tic("Write raw metadata to CSV")
    write_csv(
        data.frame(metadata_master),
        here("data", "raw_data", "metadata.csv"),
        col_names = TRUE
    )
    toc(log = TRUE) # 0.104 sec elapsed
    tic("Save raw metadata as RDS")
    saveRDS(data.frame(metadata_master), file = here("data", "raw_data", "metadata.rds"))
    toc(log = TRUE) # 0.048 sec elapsed
}

tic("Process the metadata")
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

# Make the cells neater
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

metadata_filtered$hpv <- str_replace(metadata_filtered$source, "Negativ", "Negative") %>%
    as.factor()
metadata_filtered$sex <- as.factor(metadata_filtered$sex)
metadata_filtered$age <- as.double(metadata_filtered$age)
metadata_filtered$hpv <- as.factor(metadata_filtered$hpv)
metadata_filtered$p16 <- as.factor(metadata_filtered$p16)
metadata_filtered$dna <- as.double(metadata_filtered$dna)
metadata_filtered[metadata_filtered == "Not applicable"] <- NA
metadata_filtered$origin <- str_replace(metadata_filtered$origin, "Tounge", "Tongue") %>%
    as.factor()

metadata_filtered <-
    rename(metadata_filtered,
           dna_ng = dna,
           tumour_percent = tumour)
metadata_filtered$sample <- as.factor(metadata_filtered$sample)
toc(log = TRUE) # 1.352 sec elapsed
```

    ## Process the metadata: 0.456 sec elapsed

``` r
if (!file.exists(here("data", "processed_data", "metadata.csv"))) {
    tic("Write processed metadata to CSV")
    write_csv(
        data.frame(metadata_filtered),
        here("data", "processed_data", "metadata.csv"),
        col_names = TRUE
    )
    toc(log = TRUE) # 0.085 sec elapsed
    tic("Save processed metadata as RDS")
    saveRDS(data.frame(metadata_filtered), file = here("data", "processed_data", "metadata.rds"))
    toc(log = TRUE) # 0.034 sec elapsed
}
```

Get the actual methylation data:

``` r
tic("Get methylation data from GEO object")
raw_data <- exprs(gds)
raw_data <- rownames_to_column(data.frame(raw_data), "CG")
toc(log = TRUE) # 85.018 sec elapsed
```

    ## Get methylation data from GEO object: 2.964 sec elapsed

``` r
if (!file.exists(here("data", "raw_data", "data.csv"))) {
    tic("Write raw methylation data as CSV")
    write_csv(raw_data, here("data", "raw_data", "data.csv"), col_names = TRUE)
    toc(log = TRUE) # 85.018 sec elapsed
    tic("Save raw methylation data as RDS")
    saveRDS(raw_data, file = here("data", "raw_data", "data.rds"))
    toc(log = TRUE) # 55.473 sec elapsed
}
tic("Process the methylation data")
shaped_data <- melt(raw_data, id.vars = c("CG"), var = "sample")
toc(log = TRUE) # 5.572 sec elapsed
```

    ## Process the methylation data: 3.474 sec elapsed

``` r
if (!file.exists(here("data", "processed_data", "data.csv"))) {
    tic("Write processed methylation data as CSV")
    write_csv(shaped_data,
              here("data", "processed_data", "data.csv"),
              col_names = TRUE)
    toc(log = TRUE) # 243.601 sec elapsed
    tic("Save processed methylation data as RDS")
    saveRDS(shaped_data, file = here("data", "processed_data", "data.rds"))
    toc(log = TRUE) # 157.253 sec elapsed
}
```

``` r
tic("Combine the metadata and methylation data")
data <- left_join(metadata_filtered, shaped_data, by = "sample")
toc(log = TRUE) # 41.319 sec elapsed
```

    ## Combine the metadata and methylation data: 36.209 sec elapsed

``` r
if (!file.exists(here("data", "processed_data", "combined_data.csv"))) {
    tic("Write combined data to CSV") 
    write_csv(data,
              here("data", "processed_data", "combined_data.csv"),
              col_names = TRUE)
    toc(log = TRUE) # 2320.143 sec elapsed # 1426.474 sec elapsed
    tic("Save combined data as RDS")
    saveRDS(data, file = here("data", "processed_data", "combined_data.rds"))
    toc(log = TRUE) # 560.374 sec elapsed # 382.216 sec elapsed
}
```

Get the relevant, smaller subset joined dataframe:

``` r
tic("Subset the combined data")
data_subset <- data %>%
        filter(sex == "Male") %>%
        select(c("sample", "source", "cancer", "age", "origin", "cancer_type", "CG", "value"))
toc(log = TRUE) # 25.829 sec elapsed
```

    ## Subset the combined data: 23.975 sec elapsed

``` r
if (!file.exists(here("data", "processed_data", "filtered_data.csv"))) {
    tic("Write subsetted combined data to CSV")
    write_csv(data_subset,
              here("data", "processed_data", "filtered_data.csv"),
              col_names = TRUE)
    toc(log = TRUE) # 1090.4 sec elapsed # 1063.896 sec elapsed # 831.255 sec elapsed
    tic("Save subsetted combined data to RDS")
    saveRDS(data_subset, file = here("data", "processed_data", "filtered_data.rds"))
    toc(log = TRUE) # 397.922 sec elapsed # 222.154 sec elapsed # 269.723 sec elapsed
} 
```

Subset of data:

``` r
tic.log(format = TRUE)
```

    ## [[1]]
    ## [1] "Read RDS as GEO object: 4.552 sec elapsed"
    ## 
    ## [[2]]
    ## [1] "Get metadata from the GEO object: 0.127 sec elapsed"
    ## 
    ## [[3]]
    ## [1] "Process the metadata: 0.456 sec elapsed"
    ## 
    ## [[4]]
    ## [1] "Get methylation data from GEO object: 2.964 sec elapsed"
    ## 
    ## [[5]]
    ## [1] "Process the methylation data: 3.474 sec elapsed"
    ## 
    ## [[6]]
    ## [1] "Combine the metadata and methylation data: 36.209 sec elapsed"
    ## 
    ## [[7]]
    ## [1] "Subset the combined data: 23.975 sec elapsed"

``` r
summary(data_subset)
```

    ##         sample                    source        
    ##  GSM3519721:  866091   Biopsy        : 1732182  
    ##  GSM3519722:  866091   Lung biopsy   : 9527001  
    ##  GSM3519723:  866091   Lung resection:27714912  
    ##  GSM3519724:  866091   Resection     : 6062637  
    ##  GSM3519725:  866091                            
    ##  GSM3519726:  866091                            
    ##  (Other)   :39840186                            
    ##                                                            cancer        
    ##  Primary head and neck squamous cell carcinoma                : 2598273  
    ##  Primary lung squamous cell carcinoma                         : 4330455  
    ##  Pulmonary metastasis of head and neck squamous cell carcinoma:24250548  
    ##  Second squamous cell carcinoma of the lung                   :13857456  
    ##                                                                          
    ##                                                                          
    ##                                                                          
    ##       age                origin             cancer_type      
    ##  Min.   :45.00   Hypopharynx: 4330455   metastatic:24250548  
    ##  1st Qu.:57.00   Larynx     : 5196546   primary   :20786184  
    ##  Median :62.50   Oral cavity: 9527001                        
    ##  Mean   :63.38   Oropharynx : 6928728                        
    ##  3rd Qu.:69.25   Tongue     :  866091                        
    ##  Max.   :83.00   NA's       :18187911                        
    ##                                                              
    ##       CG                value       
    ##  Length:45036732    Min.   :0.0022  
    ##  Class :character   1st Qu.:0.2150  
    ##  Mode  :character   Median :0.6306  
    ##                     Mean   :0.5434  
    ##                     3rd Qu.:0.8491  
    ##                     Max.   :0.9974  
    ##                     NA's   :1160
