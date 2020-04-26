Linear\_regression\_results
================
Almas K.
2020-04-02

This Rmd is just to view the results for the limma outputs:

Libraries
---------

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
    ## ✓ tibble  3.0.0     ✓ dplyr   0.8.5
    ## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.5.0

    ## ── Conflicts ────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(here)
```

    ## here() starts at /Users/almas/Documents/GitHub/Repo_team_The-Splice-Girls_W2020

Viewing Results:
----------------

``` r
primary_cancer <- read_csv(here("results","final","primary_topGenes_limma2.csv"))
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
knitr::kable(primary_cancer)
```

|       logFC|     AveExpr|          t|    P.Value|  adj.P.Val|          B| probeID    | CpG\_chrm | gene              | gene\_HGNC        |
|-----------:|-----------:|----------:|----------:|----------:|----------:|:-----------|:----------|:------------------|:------------------|
|  -10.483327|   1.8382332|  -4.884865|  0.0000103|  0.9999983|  -4.566179| cg14493612 | chrX      | TBC1D25           | TBC1D25           |
|   -8.285716|   1.1302900|  -4.724597|  0.0000179|  0.9999983|  -4.567570| cg21255171 | chr17     | CDC6              | CDC6              |
|    7.989844|   2.5223011|   4.653218|  0.0000229|  0.9999983|  -4.568192| cg10716343 | chr3      | ISY1-RAB43        | ISY1-RAB43        |
|  -14.166308|   1.6504860|  -4.486938|  0.0000403|  0.9999983|  -4.569649| cg08216425 | chr1      | NA                | NA                |
|   13.613897|  -0.8997396|   4.389732|  0.0000559|  0.9999983|  -4.570503| cg11713274 | chr12     | CBX5              | NA                |
|    9.835627|   2.0167416|   4.382352|  0.0000573|  0.9999983|  -4.570568| cg04788627 | chr1      | NME7              | NME7              |
|   10.760075|   0.1177430|   4.146364|  0.0001252|  0.9999983|  -4.572648| cg04015541 | chr9      | OLFML2A           | OLFML2A           |
|    6.817195|  -2.6327299|   4.140904|  0.0001275|  0.9999983|  -4.572696| cg27100229 | chr3      | CCK;RP11-333B11.1 | CCK;RP11-333B11.1 |
|   10.084826|  -1.3323905|   4.100775|  0.0001453|  0.9999983|  -4.573050| cg00937982 | chr21     | SIM2              | SIM2              |
|   10.710299|  -3.6467685|   3.999830|  0.0002016|  0.9999983|  -4.573940| cg18108623 | chr17     | SLFN11            | SLFN11            |

``` r
age_factor <- read_csv(here("results","revised","age_top_genes_limma2.csv"))
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
knitr::kable(age_factor)
```

|       logFC|     AveExpr|          t|   P.Value|  adj.P.Val|         B| probeID    | CpG\_chrm | gene          | gene\_HGNC    |
|-----------:|-----------:|----------:|---------:|----------:|---------:|:-----------|:----------|:--------------|:--------------|
|   0.1348537|   2.0167416|   5.110502|  4.70e-06|  0.9999926|  4.050716| cg04788627 | chr1      | NME7          | NME7          |
|   0.1069939|   2.7445276|   4.988810|  7.20e-06|  0.9999926|  3.652740| cg02666119 | chr8      | NA            | NA            |
|  -0.1230650|   1.8382332|  -4.877346|  1.06e-05|  0.9999926|  3.290912| cg14493612 | chrX      | TBC1D25       | TBC1D25       |
|   0.1522211|   1.5439517|   4.871637|  1.08e-05|  0.9999926|  3.272451| cg01425892 | chr1      | RGS7          | RGS7          |
|   0.1142168|  -3.8613887|   4.684763|  2.06e-05|  0.9999926|  2.672470| cg26647139 | chr11     | CADM1         | CADM1         |
|   0.0851221|   2.4806221|   4.566243|  3.08e-05|  0.9999926|  2.296512| cg08370869 | chr1      | RP11-21J7.1   | RP11-21J7.1   |
|  -0.0686233|   4.2941993|  -4.533869|  3.44e-05|  0.9999926|  2.194481| cg21286010 | chr6      | TNFRSF21      | TNFRSF21      |
|   0.0583051|   1.5321162|   4.507798|  3.76e-05|  0.9999926|  2.112526| cg24456744 | chr13     | RASA3         | RASA3         |
|   0.1139034|   0.7850097|   4.440785|  4.71e-05|  0.9999926|  1.902772| cg12110659 | chr18     | CDH7          | CDH7          |
|   0.0890349|   1.4520021|   4.400346|  5.39e-05|  0.9999926|  1.776836| cg04839683 | chr11     | RP11-396O20.2 | RP11-396O20.2 |

``` r
age_primary_cancer_interaction <- read_csv(here("results","revised","ageandprimary_top_genes_limma2.csv"))
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
knitr::kable(age_primary_cancer_interaction)
```

|       logFC|     AveExpr|          t|    P.Value|  adj.P.Val|         B| probeID    | CpG\_chrm | gene              | gene\_HGNC        |
|-----------:|-----------:|----------:|----------:|----------:|---------:|:-----------|:----------|:------------------|:------------------|
|   0.1805352|   1.8382332|   5.372693|  0.0000019|  0.9999942|  4.816586| cg14493612 | chrX      | TBC1D25           | TBC1D25           |
|  -0.1146655|  -2.6327299|  -4.448349|  0.0000459|  0.9999942|  1.940922| cg27100229 | chr3      | CCK;RP11-333B11.1 | CCK;RP11-333B11.1 |
|   0.1219558|   1.1302900|   4.441340|  0.0000470|  0.9999942|  1.919840| cg21255171 | chr17     | CDC6              | CDC6              |
|  -0.2140912|  -0.8997396|  -4.408910|  0.0000524|  0.9999942|  1.822479| cg11713274 | chr12     | NA                | NA                |
|   0.1434685|   1.7587250|   4.317601|  0.0000711|  0.9999942|  1.549951| cg00508817 | chr2      | ACYP2;TSPYL6      | ACYP2;TSPYL6      |
|  -0.1158399|   2.5223011|  -4.308736|  0.0000733|  0.9999942|  1.523621| cg10716343 | chr3      | ISY1-RAB43        | ISY1-RAB43        |
|   0.2112294|   1.6504860|   4.272917|  0.0000825|  0.9999942|  1.417472| cg08216425 | chr1      | NA                | NA                |
|  -0.1499242|   2.0167416|  -4.266323|  0.0000843|  0.9999942|  1.397971| cg04788627 | chr1      | NME7              | NME7              |
|   0.1582793|   0.9903225|   4.204029|  0.0001036|  0.9999942|  1.214419| cg26621491 | chr7      | NA                | NA                |
|  -0.1707916|   0.1177430|  -4.203349|  0.0001038|  0.9999942|  1.212423| cg04015541 | chr9      | OLFML2A           | OLFML2A           |
