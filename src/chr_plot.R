## Author: Diana Lin
## Date: March 30, 2020

library(tidyverse)
library(here)
library(FDb.InfiniumMethylation.hg19)
library(limma)

# get hg19 information and set up chromosomes
data("seqinfo.hg19")
chrlen <-  as.data.frame(seqinfo.hg19)

chrlen$chr <- as.character(rownames(chrlen))
chrlen <- chrlen[chrlen$chr %in% c("chrX",paste("chr",1:22,sep="")),]

# get anotation of 850K
annotation <- read_tsv(here("data","raw_data","EPIC.hg38.manifest.tsv.gz"))

# get the three relevant columns
chr <- annotation[,c("CpG_chrm","CpG_beg","probeID")]

# rename the columns
colnames(chr) <- c("chr","coord","Probe_ID")

# merge chr and chrlen
coord_big <- merge(chr, chrlen, by="chr")

# add rownames
rownames(coord_big) = coord_big$Probe_ID

# filter for two columns, and convert Probe_ID to name 
coord <- coord_big[,c("chr","coord")] %>%
    rownames_to_column(var = "Probe_ID")

# read in the limma toptable results
toptable <- readRDS(here("results", "final", "primary_limma2.rds")) %>%
    rownames_to_column(var = "probeID")

# filter for probes that were differentially methylated
coordDMRprobe <- coord %>%
    filter(Probe_ID %in% toptable$probeID)

# convert into character
coordDMRprobe$chr <- as.character(coordDMRprobe$chr)

# plot the chromosomes!
ggplot(data = coordDMRprobe) + 
        geom_linerange(aes(x=chr, ymin = 0, ymax = seqlengths), data = chrlen, alpha = 0.5) + 
        geom_point(aes(x = chr, y = coord),
                   position = position_jitter(width = 0.03), na.rm = T) + 
        ggtitle("DMR positions on chromosomes") + 
        ylab("Position of DMRs") +
        xlab("chr") +
        coord_flip() + 
        theme_bw() +
    ggsave(width=12, height=8, device = "png", file = here("results", "final", "chrplot.png"))