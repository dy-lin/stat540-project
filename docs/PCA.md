PCA
================
Diana Lin
March 30, 2020

### Final Results

PCA (scaled and recentered with `prcomp()`), combined with `cancer` and
`cancer_type`:

![](../results/final/PCA_manual_combined.png)

### Revised Results

Revised results use the built in scaling and recentering with
`prcomp(center = TRUE, scale = TRUE)` to rule out manual scaling error
(which uses `t(scale(t(data)))`.

#### Cancer Type

![](../results/revised/PCA_cancer_type.png)

#### Cancer

![](../results/revised/PCA_cancer.png)

#### Source

![](../results/revised/PCA_source.png)

#### Sex

![](../results/revised/PCA_sex.png)

#### Age

![](../results/revised/PCA_age.png)

#### Smoking Status

![](../results/revised/PCA_smoking_status.png)

#### Packs Per Year

![](../results/revised/PCA_packs_per_year.png)

#### HPV

![](../results/revised/PCA_hpv.png)

#### p16

![](../results/revised/PCA_p16.png)

#### DNA (ng)

![](../results/revised/PCA_dna_ng.png)

#### Tumour Percent

![](../results/revised/PCA_tumour_percent.png)

#### Origin

![](../results/revised/PCA_origin.png)

### Scratch Results

PCA (scaled with `t(scale(t(data)))`), combined with `cancer` and
`cancer_type`:

![](../results/scratch/PCA_auto_combined.png)

#### Autoscaled Results

PCA (scaled and recentered with `prcomp()`), scatterplot:

![](../results/scratch/PCA_auto_scatter.png)

PCA (scaled and recentered with `prcomp()`), scree plot:

![](../results/scratch/PCA_auto_scree.png)

PCA (scaled and recentered with `prcomp()`), coloured by `age`:

![](../results/scratch/PCA_auto_age.png)

PCA (scaled and recentered with `prcomp()`), coloured by `cancer`:

![](../results/scratch/PCA_auto_cancer.png)

PCA (scaled and recentered with `prcomp()`), coloured by `cancer_type`:

include\_graphics(here(“results”, “scratch”,
"PCA\_auto\_cancer\_type.png)

PCA (scaled and recentered with `prcomp()`), coloured by `dna_ng`:

![](../results/scratch/PCA_auto_dna_ng.png)

PCA (scaled and recentered with `prcomp()`), coloured by `hpv`:

![](../results/scratch/PCA_auto_hpv.png)

PCA (scaled and recentered with `prcomp()`), coloured by `origin`:

![](../results/scratch/PCA_auto_origin.png)

PCA (scaled and recentered with `prcomp()`), coloured by `p16`:

![](../results/scratch/PCA_auto_p16.png)

PCA (scaled and recentered with `prcomp()`), coloured by
`packs_per_year`:

![](../results/scratch/PCA_auto_packs_per_year.png)

PCA (scaled and recentered with `prcomp()`), coloured by `sex`:

![](../results/scratch/PCA_auto_sex.png)

PCA (scaled and recentered with `prcomp()`), coloured by
`smoking_status`:

![](../results/scratch/PCA_auto_smoking_status.png)

PCA (scaled and recentered with `prcomp()`), coloured by `source`:

![](../results/scratch/PCA_auto_source.png)

PCA (scaled and recentered with `prcomp()`), coloured by
`tumour_percent`:

![](../results/scratch/PCA_auto_tumour_percent.png)

#### Manual Scale

PCA (scaled with `t(scale(t(data)))`), scatterplot:

![](../results/scratch/PCA_manual_scatter.png)

PCA (scaled with `t(scale(t(data)))`), scree rplot:

![](../results/scratch/PCA_manual_scree.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `age`:

![](../results/scratch/PCA_manual_age.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `cancer`:

![](../results/scratch/PCA_manual_cancer.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `cancer_type`:

![](../results/scratch/PCA_manual_cancer_type.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `dna_ng`:

![](../results/scratch/PCA_manual_dna_ng.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `hpv`:

![](../results/scratch/PCA_manual_hpv.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `origin`:

![](../results/scratch/PCA_manual_origin.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `p16`:

![](../results/scratch/PCA_manual_p16.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `packs_per_year`:

![](../results/scratch/PCA_manual_packs_per_year.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `sex`:

![](../results/scratch/PCA_manual_sex.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `smoking_status`:

![](../results/scratch/PCA_manual_smoking_status.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `source`:

![](../results/scratch/PCA_manual_source.png)

PCA (scaled with `t(scale(t(data)))`), coloured by `tumour_percent`:

![](../results/scratch/PCA_manual_tumour_percent.png)
