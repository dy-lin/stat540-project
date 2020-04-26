Gene Set Enrichment
================
Almas K.
2020-03-31

## Libraries

``` r
library(tidyverse)
```

    ## ── Attaching packages ───────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
    ## ✓ tibble  3.0.0     ✓ dplyr   0.8.5
    ## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.5.0

    ## ── Conflicts ──────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(ermineR)
library(reshape2)
```

    ## 
    ## Attaching package: 'reshape2'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     smiths

``` r
library(devtools)
```

    ## Loading required package: usethis

``` r
library(here)
```

    ## here() starts at /Users/dianalin/Repo_team_The-Splice-Girls_W2020

## Data

``` r
geneList <- read_csv(here("results", "final","primary_topGenes_limma2.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   logFC = col_double(),
    ##   AveExpr = col_double(),
    ##   t = col_double(),
    ##   P.Value = col_double(),
    ##   adj.P.Val = col_double(),
    ##   B = col_double(),
    ##   probeID = col_character(),
    ##   CpG_chrm = col_character(),
    ##   gene = col_character(),
    ##   gene_HGNC = col_character()
    ## )

``` r
 annotation_v <-  read_csv(here("results", "scratch", "TopTen_GOterms.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   hgnc_symbol = col_character(),
    ##   go_id = col_character(),
    ##   name_1006 = col_character()
    ## )

``` r
# download the latest GO.xml file if it doesn't already exist
if (!file.exists(here("results", "scratch", "GO.xml"))) { goToday("GO.xml") }
```

``` r
ermineInputGeneScores <- geneList %>% 
  mutate(absolute_logFC = abs(logFC)) %>% 
  dplyr::select(gene, absolute_logFC) %>% 
  na.omit() %>% 
  as.data.frame() %>% 
  arrange(desc(absolute_logFC)) %>% 
  column_to_rownames("gene")

head(ermineInputGeneScores) # print the first few rows
```

    ##         absolute_logFC
    ## CBX5         13.613897
    ## OLFML2A      10.760075
    ## SLFN11       10.710299
    ## TBC1D25      10.483327
    ## SIM2         10.084825
    ## NME7          9.835627

``` r
enrichmentResult <- precRecall(scores = ermineInputGeneScores, 
                               scoreColumn = 1, # column 1 is the scores 
                               bigIsBetter = TRUE, # larger logFC should be ranked higher
                               annotation = annotation_v, # ask ermineJ to use the Generic_human annotation file (will automatically download)
                               aspects = "B", # look at only biological processes 
                               iterations = 10000, # 10K sampling iterations so that results are stable
                               geneSetDescription = "GO.xml") # use the GO XML file in current directory
```

### Error Message

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
