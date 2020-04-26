Data Exploration
================

Load packages:

``` r
library(tidyverse)
library(here)
library(knitr)
```

Load the
metadata:

``` r
metadata <- read_csv(here("data","processed_data","metadata.csv"), col_types = cols(
    sample = col_factor(),
    source = col_factor(),
    cancer = col_factor(),
    sex = col_factor(),
    age = col_double(),
    smoking_status = col_factor(),
    packs_per_year = col_double(),
    hpv = col_factor(),
    p16 = col_factor(),
    dna_ng = col_double(),
    tumour_percent = col_double(),
    origin = col_factor()
))

kable(metadata)
```

| sample     | source         | cancer                                                        | sex    | age | smoking\_status | packs\_per\_year | hpv          | p16      | dna\_ng | tumour\_percent | origin         |
| :--------- | :------------- | :------------------------------------------------------------ | :----- | --: | :-------------- | ---------------: | :----------- | :------- | ------: | --------------: | :------------- |
| GSM3519721 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  64 | Active          |               60 | NA           | Negative |     144 |              90 | Larynx         |
| GSM3519722 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  64 | Active          |               40 | NA           | Positive |     500 |              90 | Hypopharynx    |
| GSM3519723 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  57 | Active          |               NA | NA           | Negative |     500 |              90 | Hypopharynx    |
| GSM3519724 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  66 | Former          |              120 | HPV16        | Positive |     500 |              90 | Oropharynx     |
| GSM3519725 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  59 | Active          |               NA | NA           | Positive |     400 |              90 | Oral cavity    |
| GSM3519726 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  59 | Active          |               50 | Negative     | Negative |     500 |              80 | Hypopharynx    |
| GSM3519727 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  45 | Former          |               50 | HPV6, HPV 16 | Positive |     500 |             100 | Hypopharynx    |
| GSM3519728 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  49 | Active          |               30 | NA           | Negative |     200 |              90 | Oral cavity    |
| GSM3519729 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  61 | Active          |              100 | NA           | Negative |     500 |              90 | Larynx         |
| GSM3519730 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  68 | Former          |               50 | NA           | Negative |     500 |              90 | Oral cavity    |
| GSM3519731 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  57 | Active          |               NA | Negative     | Positive |     130 |              70 | Oral cavity    |
| GSM3519732 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  55 | Former          |               40 | Negative     | Negative |     240 |              90 | Oral cavity    |
| GSM3519733 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Female |  56 | Former          |               40 | NA           | Positive |     500 |              90 | Oropharynx     |
| GSM3519734 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  64 | NA              |               NA | Negative     | Negative |     400 |              90 | Larynx         |
| GSM3519735 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  69 | Active          |               50 | HPV16        | Positive |     500 |              90 | Oropharynx     |
| GSM3519736 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  63 | Former          |               60 | HPV11        | Positive |     500 |              80 | Oral cavity    |
| GSM3519737 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  46 | Former          |                6 | HPV16        | Positive |     500 |              80 | Oropharynx     |
| GSM3519738 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  58 | Active          |               80 | NA           | Positive |     500 |              90 | Oropharynx     |
| GSM3519739 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  58 | Active          |               NA | NA           | Negative |     500 |              90 | Oral cavity    |
| GSM3519740 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  49 | Former          |               NA | NA           | Negative |     500 |              80 | Tounge         |
| GSM3519741 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Female |  53 | Former          |               NA | NA           | Negative |     500 |              90 | Oral cavity    |
| GSM3519742 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  52 | Former          |              120 | NA           | Positive |     200 |              90 | Oropharynx     |
| GSM3519743 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  55 | NA              |               NA | HPV16, HPV18 | Negative |     500 |              90 | Oropharynx     |
| GSM3519744 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  71 | Active          |               50 | NA           | Negative |     500 |             100 | Hypopharynx    |
| GSM3519745 | Lung resection | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  64 | Former          |               NA | NA           | Positive |     500 |              90 | Larynx         |
| GSM3519746 | Lung biopsy    | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  52 | Active          |               NA | Negativ      | Negative |     120 |              90 | Oral cavity    |
| GSM3519747 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  56 | Active          |               80 | NA           | Negative |     500 |              80 | Not applicable |
| GSM3519748 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  59 | Active          |               50 | Negativ      | Negative |     500 |              90 | Not applicable |
| GSM3519749 | Biopsy         | Second squamous cell carcinoma of the lung                    | Male   |  73 | Former          |               55 | NA           | Positive |     500 |              90 | Not applicable |
| GSM3519750 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  75 | Former 100 py   |               NA | Negativ      | Negative |     480 |              90 | Not applicable |
| GSM3519751 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  65 | Active          |               NA | Negativ      | Positive |     110 |              80 | Not applicable |
| GSM3519752 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  77 | Active          |               60 | NA           | Negative |     500 |              70 | Not applicable |
| GSM3519753 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  83 | NA              |               NA | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519754 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  63 | Active          |               40 | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519755 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  59 | Active          |               40 | NA           | Positive |     500 |             100 | Not applicable |
| GSM3519756 | Lung resection | Second squamous cell carcinoma of the lung                    | Female |  51 | Active          |               40 | Negativ      | Positive |     400 |              90 | Not applicable |
| GSM3519757 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  55 | Active          |               NA | HPV16        | Positive |     480 |              90 | Not applicable |
| GSM3519758 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  56 | Active          |               60 | NA           | Positive |     500 |              90 | Not applicable |
| GSM3519759 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  78 | Active          |               50 | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519760 | Lung resection | Second squamous cell carcinoma of the lung                    | Male   |  57 | Active          |               NA | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519761 | Lung biopsy    | Second squamous cell carcinoma of the lung                    | Male   |  81 | NA              |               NA | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519762 | Lung biopsy    | Second squamous cell carcinoma of the lung                    | Male   |  62 | Former          |               30 | NA           | Negative |     500 |              80 | Not applicable |
| GSM3519763 | Lung biopsy    | Second squamous cell carcinoma of the lung                    | Female |  62 | NA              |               NA | Negative     | Positive |     500 |              80 | Not applicable |
| GSM3519764 | Lung biopsy    | Second squamous cell carcinoma of the lung                    | Female |  65 | Active          |               20 | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519765 | Resection      | Primary head and neck squamous cell carcinoma                 | Male   |  62 | Active          |               10 | NA           | Positive |     500 |              80 | Oral cavity    |
| GSM3519766 | Resection      | Primary head and neck squamous cell carcinoma                 | Female |  60 | NA              |               NA | NA           | Positive |     500 |              70 | Oral cavity    |
| GSM3519767 | Resection      | Primary head and neck squamous cell carcinoma                 | Male   |  59 | NA              |               NA | NA           | Negative |     500 |              90 | Oropharynx     |
| GSM3519768 | Resection      | Primary head and neck squamous cell carcinoma                 | Female |  72 | Active          |              100 | NA           | Negative |     500 |              90 | Larynx         |
| GSM3519769 | Resection      | Primary head and neck squamous cell carcinoma                 | Male   |  69 | Active          |               40 | NA           | Negative |     500 |              70 | Larynx         |
| GSM3519770 | Lung resection | Primary lung squamous cell carcinoma                          | Male   |  63 | NA              |               NA | NA           | Negative |     500 |              80 | Not applicable |
| GSM3519771 | Lung resection | Primary lung squamous cell carcinoma                          | Male   |  83 | Former          |               30 | NA           | Negative |     500 |              80 | Not applicable |
| GSM3519772 | Lung resection | Primary lung squamous cell carcinoma                          | Male   |  58 | Active          |               10 | NA           | Negative |     500 |              80 | Not applicable |
| GSM3519773 | Lung resection | Primary lung squamous cell carcinoma                          | Male   |  82 | Active          |               NA | NA           | Negative |     500 |              90 | Not applicable |
| GSM3519774 | Lung resection | Primary lung squamous cell carcinoma                          | Male   |  70 | Former          |               40 | NA           | Positive |     500 |              90 | Not applicable |
| GSM3780872 | Resection      | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  69 | Active          |               60 | NA           | Negative |     500 |              80 | Oral cavity    |
| GSM3780873 | Resection      | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  74 | Former          |               40 | NA           | Positive |     500 |              80 | Larynx         |
| GSM3780874 | Biopsy         | Pulmonary metastasis of head and neck squamous cell carcinoma | Female |  66 | Active          |               80 | NA           | Negative |     500 |              90 | Oral cavity    |
| GSM3780875 | Biopsy         | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  61 | Active          |              100 | NA           | Negative |     500 |              90 | Oral cavity    |
| GSM3780876 | Resection      | Pulmonary metastasis of head and neck squamous cell carcinoma | Male   |  71 | Former          |               30 | NA           | Positive |     500 |              90 | Oropharynx     |
| GSM3780877 | Resection      | Second squamous cell carcinoma of the lung                    | Male   |  71 | Active          |               40 | NA           | Negative |     500 |              80 | Not applicable |
| GSM3780878 | Resection      | Second squamous cell carcinoma of the lung                    | Female |  60 | Never           |               NA | NA           | Negative |     500 |              80 | Not applicable |

``` r
summary(metadata)
```

    ##         sample              source  
    ##  GSM3519721: 1   Lung biopsy   :14  
    ##  GSM3519722: 1   Lung resection:34  
    ##  GSM3519723: 1   Biopsy        : 3  
    ##  GSM3519724: 1   Resection     :10  
    ##  GSM3519725: 1                      
    ##  GSM3519726: 1                      
    ##  (Other)   :55                      
    ##                                                            cancer       sex    
    ##  Pulmonary metastasis of head and neck squamous cell carcinoma:31   Male  :52  
    ##  Second squamous cell carcinoma of the lung                   :20   Female: 9  
    ##  Primary head and neck squamous cell carcinoma                : 5              
    ##  Primary lung squamous cell carcinoma                         : 5              
    ##                                                                                
    ##                                                                                
    ##                                                                                
    ##       age               smoking_status packs_per_year             hpv    
    ##  Min.   :45.00   Active        :34     Min.   :  6.00   HPV16       : 4  
    ##  1st Qu.:57.00   Former        :17     1st Qu.: 40.00   Negative    : 5  
    ##  Median :62.00   Former  100 py: 1     Median : 50.00   HPV6, HPV 16: 1  
    ##  Mean   :62.97   Never         : 1     Mean   : 52.59   HPV11       : 1  
    ##  3rd Qu.:69.00   NA's          : 8     3rd Qu.: 60.00   HPV16, HPV18: 1  
    ##  Max.   :83.00                         Max.   :120.00   Negativ     : 5  
    ##                                        NA's   :22       NA's        :44  
    ##        p16         dna_ng      tumour_percent              origin  
    ##  Negative:37   Min.   :110.0   Min.   : 70.00   Larynx        : 7  
    ##  Positive:24   1st Qu.:500.0   1st Qu.: 80.00   Hypopharynx   : 5  
    ##                Median :500.0   Median : 90.00   Oropharynx    : 9  
    ##                Mean   :455.8   Mean   : 86.56   Oral cavity   :14  
    ##                3rd Qu.:500.0   3rd Qu.: 90.00   Tounge        : 1  
    ##                Max.   :500.0   Max.   :100.00   Not applicable:25  
    ##
