## Author: Diana Lin
## Date: April 3, 2020

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(cowplot))

# read in the metadata
metadata <-
    readRDS(file = here("data", "processed_data", "metadata.rds"))

# read in the normalized beta values
expr <- readRDS(file = here("data","raw_data", "data.rds")) %>%
    column_to_rownames(var = "CG")

# perform the PCA
pcs <- prcomp(na.omit(expr), center = TRUE, scale = TRUE)

# bind the metadata
prinComp <- 
    cbind(metadata, pcs$rotation[metadata$sample, 1:10]) %>%
    dplyr::select(-sample)

# function to plot PCA of all combinations among the first 10 components
# and then colour by selected covariate
pca <- function(var = "cancer_type") {
    # create an empty list for the plots
    p <- list()
    
    # get the first ten PCs as a vector
    pc <- c(paste0("PC",1:10))
    
    # counter to keep track of how many plots
    count <- 1
    
    # for loop to loop from PC1 to PC9
    for (i in 1:(length(pc)-1)) {
        # for loop to loop from i+1 to PC10
        for(j in (i+1):(length(pc))) {
            
            # plot PCA and add to list p 
            p[[count]] <- ggplot(prinComp, aes(x = !!sym(pc[i]), y = !!sym(pc[j]))) +
                geom_point(aes(colour = !!sym(var)), shape = 20, alpha = 0.5) +
                theme(legend.position = "none",
                      axis.text.x = element_text(angle = 90)) 
            
            # for the first plot of each, but do not remove the legend
            # for legend extraction later
            if (i == 1) {
                plot <- ggplot(prinComp, aes(x = !!sym(pc[i]), y = !!sym(pc[j]))) +
                    geom_point(aes(colour = !!sym(var)))
            }
            
            # increment counter
            count <- count + 1
        }
    }
    
    # combine all the plots in list p into 1 plot
    combined <- plot_grid(plotlist = p, ncol = 9)
    
    # draw the title 
    title <- ggdraw() + 
        draw_label(
            glue("PCA: {var}"),
            fontface = 'bold',
            x = 0,
            hjust = 0
        ) +
        theme(
            plot.margin = margin(0, 0, 0, 7)
        )
    
    # extract legend from the first plot
    legend <- get_legend(
        if (var == "cancer") {
            plot + theme(
                # add margin to top of legend
                legend.box.margin = margin(0.1, 0, 0, 0),
                # remove legend title
                legend.title = element_blank()
            ) + # wrap the long legend for cancer
                scale_colour_discrete(
                    labels = function(x)
                        str_wrap(x, width = 20)
                ) + # keep legend in 1 row at the bottom
                guides(colour = guide_legend(nrow = 1))
        } else if( var %in% c("dna_ng", "packs_per_year", "age", "tumour_percent")) {
            plot + 
               scale_colour_continuous(guide = guide_colourbar(direction = "horizontal", title = NULL))
        } else {
            plot + theme(
                # add margin to top of legend
                legend.box.margin = margin(0.1, 0, 0, 0),
                # remove legend title
                legend.title = element_blank()
            ) + # keep legend in 1 row at the bottom 
            guides(colour = guide_legend(nrow = 1))
        }
        
    )
    
    # combine the plot and legend (bottom)
    legended <- plot_grid(combined, legend, ncol = 1, rel_heights = c(1,0.1))
    
    # combine title and legended plot
    final <- plot_grid(title, legended, ncol = 1, rel_heights = c(0.1, 1))
    # save the plot in the revised directory
    ggsave(plot = final, filename = here("results","revised", glue("PCA_{var}.png")), width = 12, height = 8, device = "png")
}

# get covariates
covariates <- colnames(prinComp)[1:12]

# call function pca on all covariates
purrr::map(covariates, pca)