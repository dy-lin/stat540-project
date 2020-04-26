# Raw Data

## In this repository
- [`metadata.rds`](metadata.rds): the raw metadata from GEO, generated using `src/fetch_data.R`
- [`EPIC.hg38.manifest.tsv.gz.zip`](EPIC.hg38.manifest.tsv.gz.zip): the annotation manifest from [Zhou et al. (2017)](https://zwdzwd.github.io/InfiniumAnnotation), used in [`src/linear_regression.R`](../../src/linear_regression.R)and [`src/chr_plot.R`](../../src/chr_plot.R)

## Not in this repository
- `data.rds`: the (raw) pre-normalized methylation data from GEO, generated using `src/fetch_data.R`
- `data_for_limma.rds`: data for `limma`
