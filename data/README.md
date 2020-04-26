About the Data
================

The directory [`raw_data/`](raw_data/) consists of data downloaded
directly from the source (e.g. GEO), while the
[`processed_data/`](processed_data/) directory consists of the wrangled
and reshaped data. Each subdirectory has its own `README.md` with more
information.

## Table of Contents

1.  [Metadata](#metadata)
    1.  [Metadata Characteristics](#metadata-characteristics)
        1.  [Metadata Summary](#metadata-summary)
    2.  [Filtered Metadata](#filtered-metadata)
        1.  [Filtered Metadata Summary](#filtered-metadata-summary)
2.  [Methylation Data](#methylation-data)
3.  [Combining Metadata and Methylation
    Data](#combining-the-metadata-and-methylation-data)
4.  [Experimental Design](#experimental-design)

Our dataset is a publicly available methylation dataset from
[GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124052).

## Metadata

### Metadata Characteristics

Our full metadata (including corresponding author, etc.) can be found
here in [`raw_data/metadata.rds`](raw_data/metadata.rds). However, for
the purposes of this document, we will be talking about the
characterstics only, which are found in
[`processed_data/metadata.rds`](processed_data/metadata.rds).

``` r
metadata <- readRDS(file = here("data","processed_data", "metadata.rds"))
```

The characteristics given for our dataset
    are:

``` r
colnames(metadata)
```

    ##  [1] "sample"         "source"         "cancer"         "sex"           
    ##  [5] "age"            "smoking_status" "packs_per_year" "hpv"           
    ##  [9] "p16"            "dna_ng"         "tumour_percent" "origin"        
    ## [13] "cancer_type"

Our metadata shows that are 61 samples in this dataset:

``` r
nrow(metadata)
```

    ## [1] 61

So our metadata is a 61x12 dataframe:

``` r
ncol(metadata)
```

    ## [1] 13

##### Metadata Summary

Here is a summary of the metadata:

``` r
summary(metadata)
```

    ##         sample              source  
    ##  GSM3519721: 1   Biopsy        : 3  
    ##  GSM3519722: 1   Lung biopsy   :14  
    ##  GSM3519723: 1   Lung resection:34  
    ##  GSM3519724: 1   Resection     :10  
    ##  GSM3519725: 1                      
    ##  GSM3519726: 1                      
    ##  (Other)   :55                      
    ##                                                            cancer       sex    
    ##  Primary head and neck squamous cell carcinoma                : 5   Female: 9  
    ##  Primary lung squamous cell carcinoma                         : 5   Male  :52  
    ##  Pulmonary metastasis of head and neck squamous cell carcinoma:31              
    ##  Second squamous cell carcinoma of the lung                   :20              
    ##                                                                                
    ##                                                                                
    ##                                                                                
    ##       age        smoking_status packs_per_year               hpv    
    ##  Min.   :45.00   Active :34     Min.   :  6.00   Biopsy        : 3  
    ##  1st Qu.:57.00   Former :18     1st Qu.: 40.00   Lung biopsy   :14  
    ##  Median :62.00   NA     : 8     Median : 50.00   Lung resection:34  
    ##  Mean   :62.97   Never  : 1     Mean   : 52.59   Resection     :10  
    ##  3rd Qu.:69.00                  3rd Qu.: 60.00                      
    ##  Max.   :83.00                  Max.   :120.00                      
    ##                                 NA's   :22                          
    ##        p16         dna_ng      tumour_percent           origin  
    ##  Negative:37   Min.   :110.0   Min.   : 70.00   Hypopharynx: 5  
    ##  Positive:24   1st Qu.:500.0   1st Qu.: 80.00   Larynx     : 7  
    ##                Median :500.0   Median : 90.00   Oral cavity:14  
    ##                Mean   :455.8   Mean   : 86.56   Oropharynx : 9  
    ##                3rd Qu.:500.0   3rd Qu.: 90.00   Tongue     : 1  
    ##                Max.   :500.0   Max.   :100.00   NA's       :25  
    ##                                                                 
    ##      cancer_type
    ##  metastatic:31  
    ##  primary   :30  
    ##                 
    ##                 
    ##                 
    ##                 
    ## 

#### Filtered Metadata

##### Filtered Metadata Summary

In our analysis, we will only be looking at `males` as there is a huge
imbalance of 52 males to 9 females. Here is the summary if we exclude
females:

``` r
metadata %>%
    filter(sex == "Male") %>%
    summary()
```

    ##         sample              source  
    ##  GSM3519721: 1   Biopsy        : 2  
    ##  GSM3519722: 1   Lung biopsy   :11  
    ##  GSM3519723: 1   Lung resection:32  
    ##  GSM3519724: 1   Resection     : 7  
    ##  GSM3519725: 1                      
    ##  GSM3519726: 1                      
    ##  (Other)   :46                      
    ##                                                            cancer       sex    
    ##  Primary head and neck squamous cell carcinoma                : 3   Female: 0  
    ##  Primary lung squamous cell carcinoma                         : 5   Male  :52  
    ##  Pulmonary metastasis of head and neck squamous cell carcinoma:28              
    ##  Second squamous cell carcinoma of the lung                   :16              
    ##                                                                                
    ##                                                                                
    ##                                                                                
    ##       age        smoking_status packs_per_year               hpv    
    ##  Min.   :45.00   Active :30     Min.   :  6.00   Biopsy        : 2  
    ##  1st Qu.:57.00   Former :16     1st Qu.: 40.00   Lung biopsy   :11  
    ##  Median :62.50   NA     : 6     Median : 50.00   Lung resection:32  
    ##  Mean   :63.38   Never  : 0     Mean   : 52.09   Resection     : 7  
    ##  3rd Qu.:69.25                  3rd Qu.: 60.00                      
    ##  Max.   :83.00                  Max.   :120.00                      
    ##                                 NA's   :18                          
    ##        p16         dna_ng      tumour_percent           origin  
    ##  Negative:32   Min.   :110.0   Min.   : 70.00   Hypopharynx: 5  
    ##  Positive:20   1st Qu.:500.0   1st Qu.: 80.00   Larynx     : 6  
    ##                Median :500.0   Median : 90.00   Oral cavity:11  
    ##                Mean   :450.1   Mean   : 86.73   Oropharynx : 8  
    ##                3rd Qu.:500.0   3rd Qu.: 90.00   Tongue     : 1  
    ##                Max.   :500.0   Max.   :100.00   NA's       :21  
    ##                                                                 
    ##      cancer_type
    ##  metastatic:28  
    ##  primary   :24  
    ##                 
    ##                 
    ##                 
    ##                 
    ## 

Here is a brief glimpse into our metadata:

``` r
head(metadata, n = 2L) %>%
    kable()
```

| sample     | source      | cancer                                                        | sex  | age | smoking\_status | packs\_per\_year | hpv         | p16      | dna\_ng | tumour\_percent | origin      | cancer\_type |
| :--------- | :---------- | :------------------------------------------------------------ | :--- | --: | :-------------- | ---------------: | :---------- | :------- | ------: | --------------: | :---------- | :----------- |
| GSM3519721 | Lung biopsy | Pulmonary metastasis of head and neck squamous cell carcinoma | Male |  64 | Active          |               60 | Lung biopsy | Negative |     144 |              90 | Larynx      | metastatic   |
| GSM3519722 | Lung biopsy | Pulmonary metastasis of head and neck squamous cell carcinoma | Male |  64 | Active          |               40 | Lung biopsy | Positive |     500 |              90 | Hypopharynx | metastatic   |

## Methylation Data

Our full methylation data can be found in `raw_data/data.csv`, which is
too large to be uploaded to the GitHub repository. Here we show the
column names of our methylation data:

``` r
methylation_full <- readRDS(here("data","raw_data","data.rds"))
colnames(methylation_full)
```

    ##  [1] "CG"         "GSM3519721" "GSM3519722" "GSM3519723" "GSM3519724"
    ##  [6] "GSM3519725" "GSM3519726" "GSM3519727" "GSM3519728" "GSM3519729"
    ## [11] "GSM3519730" "GSM3519731" "GSM3519732" "GSM3519733" "GSM3519734"
    ## [16] "GSM3519735" "GSM3519736" "GSM3519737" "GSM3519738" "GSM3519739"
    ## [21] "GSM3519740" "GSM3519741" "GSM3519742" "GSM3519743" "GSM3519744"
    ## [26] "GSM3519745" "GSM3519746" "GSM3519747" "GSM3519748" "GSM3519749"
    ## [31] "GSM3519750" "GSM3519751" "GSM3519752" "GSM3519753" "GSM3519754"
    ## [36] "GSM3519755" "GSM3519756" "GSM3519757" "GSM3519758" "GSM3519759"
    ## [41] "GSM3519760" "GSM3519761" "GSM3519762" "GSM3519763" "GSM3519764"
    ## [46] "GSM3519765" "GSM3519766" "GSM3519767" "GSM3519768" "GSM3519769"
    ## [51] "GSM3519770" "GSM3519771" "GSM3519772" "GSM3519773" "GSM3519774"
    ## [56] "GSM3780872" "GSM3780873" "GSM3780874" "GSM3780875" "GSM3780876"
    ## [61] "GSM3780877" "GSM3780878"

Here we show the number of methylated sites in our dataset
(corresponding to the number of rows in the data frame):

``` r
(num_sites <- nrow(methylation_full))
```

    ## [1] 866091

The first column of this data frame contain our 866091 methylation
sites:

``` r
head(methylation_full[1])
```

    ##           CG
    ## 1 cg00000029
    ## 2 cg00000103
    ## 3 cg00000109
    ## 4 cg00000155
    ## 5 cg00000158
    ## 6 cg00000165

And, as expected, the number of columns in this data frame is the same
as the number of samples we have (excluding the first column which is
the methylation site names):

``` r
ncol(methylation_full[-1])
```

    ## [1] 61

Our methylation data is a 866091x61 dataframe. Here is a glimpse into
it:

``` r
head(methylation_full, n = 2L) %>%
    kable()
```

| CG         | GSM3519721 | GSM3519722 | GSM3519723 | GSM3519724 | GSM3519725 | GSM3519726 | GSM3519727 | GSM3519728 | GSM3519729 | GSM3519730 | GSM3519731 | GSM3519732 | GSM3519733 | GSM3519734 | GSM3519735 | GSM3519736 | GSM3519737 | GSM3519738 | GSM3519739 | GSM3519740 | GSM3519741 | GSM3519742 | GSM3519743 | GSM3519744 | GSM3519745 | GSM3519746 | GSM3519747 | GSM3519748 | GSM3519749 | GSM3519750 | GSM3519751 | GSM3519752 | GSM3519753 | GSM3519754 | GSM3519755 | GSM3519756 | GSM3519757 | GSM3519758 | GSM3519759 | GSM3519760 | GSM3519761 | GSM3519762 | GSM3519763 | GSM3519764 | GSM3519765 | GSM3519766 | GSM3519767 | GSM3519768 | GSM3519769 | GSM3519770 | GSM3519771 | GSM3519772 | GSM3519773 | GSM3519774 | GSM3780872 | GSM3780873 | GSM3780874 | GSM3780875 | GSM3780876 | GSM3780877 | GSM3780878 |
| :--------- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| cg00000029 |  0.1044517 |  0.0725438 |  0.2677439 |  0.1797545 |  0.2271358 |  0.2880918 |  0.1625456 |  0.0805968 |  0.1476610 |  0.1589205 |  0.2850968 |  0.2080084 |  0.4296394 |  0.2000484 |  0.2870668 |  0.3198260 |  0.2757844 |  0.2741061 |  0.1340148 |  0.2449842 |  0.1859119 |  0.3050228 |  0.2320988 |  0.1548861 |  0.1163593 |  0.1709576 |  0.1762531 |  0.1909022 |  0.0889536 |  0.2083362 |  0.2109437 |  0.4442220 |  0.4600122 |  0.4341254 |  0.3140812 |  0.2348603 |  0.2444569 |  0.1769643 |  0.1638668 |  0.3395768 |  0.7086727 |  0.5292324 |  0.1204668 |  0.3441164 |  0.2402373 |  0.3796932 |  0.3515815 |  0.3003914 |  0.4769060 |  0.2481000 |  0.2113113 |  0.2432431 |  0.1952987 |  0.1498887 |  0.4310292 |  0.2085837 |  0.1570698 |  0.1874514 |  0.1094695 |  0.1854513 |  0.3313222 |
| cg00000103 |  0.3390574 |  0.2372246 |  0.5005105 |  0.2294367 |  0.3676609 |  0.1013536 |  0.4625099 |  0.3900498 |  0.1856561 |  0.2783753 |  0.7311612 |  0.3496134 |  0.5535337 |  0.3889719 |  0.6878807 |  0.4525018 |  0.4993886 |  0.6270920 |  0.4353365 |  0.4897687 |  0.3414484 |  0.7671468 |  0.4629957 |  0.2658764 |  0.2580858 |  0.5187599 |  0.5979366 |  0.1123411 |  0.3426119 |  0.3277110 |  0.3048478 |  0.8931651 |  0.8096334 |  0.8255197 |  0.6729100 |  0.3581399 |  0.5548114 |  0.3005408 |  0.5940992 |  0.6467736 |  0.4534488 |  0.8391552 |  0.3942488 |  0.7578044 |  0.5346393 |  0.8192842 |  0.6059300 |  0.7468224 |  0.8214903 |  0.6749695 |  0.2321659 |  0.7771561 |  0.7202347 |  0.3996608 |  0.7023380 |  0.4176353 |  0.3140819 |  0.4440374 |  0.7912650 |  0.4592620 |  0.6902227 |

## Combining the Metadata and Methylation Data

When combining our metadata and methylation data, the dataset looks like
this (with reduced number of characteristics):

``` r
combined <- readRDS(here("data", "processed_data", "filtered_data.rds"))
head(combined, n = 2L) %>%
    kable()
```

| sample     | source      | cancer                                                        | age | origin | cancer\_type | CG         |     value |
| :--------- | :---------- | :------------------------------------------------------------ | --: | :----- | :----------- | :--------- | --------: |
| GSM3519721 | Lung biopsy | Pulmonary metastasis of head and neck squamous cell carcinoma |  64 | Larynx | metastatic   | cg00000029 | 0.1044517 |
| GSM3519721 | Lung biopsy | Pulmonary metastasis of head and neck squamous cell carcinoma |  64 | Larynx | metastatic   | cg00000103 | 0.3390574 |

## Experimental Design

The experimental design of the
[paper](https://www.ncbi.nlm.nih.gov/pubmed/31511427) where we obtained
this dataset was to classify cancers as primary or metastatic cancers
based on their methylation profiles. Our [male
subset](#filtered-metadata-summary) consists of both raw and
noob-normalized beta values measured from 51 male participants using the
Illumina Infinium MethylationEPIC BeadChip. Each of the participants was
diagnosed with either primary LUSC or lung metastases from HNSCC. The
type of cancer was ascertained using histopathology as well as clinical
and radiological evidence from an expert panel. The male samples were
between the ages of 45-80 years old and were either former or active
smokers at the time of recruitment. For information on the full dataset
(including females), see the summary [above](#metadata-summary).
