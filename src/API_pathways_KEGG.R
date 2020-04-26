# Script for performance of pathway enrichment analysis in KEGG using PathDIP portal (Rahmati et al., 2016) API 
# For more information: http://ophid.utoronto.ca/pathDIP/API.jsp



library(httr)
library(tidyverse)
library(here)

# const values
url <- "http://ophid.utoronto.ca/pathDIP/Http_API"




searchOnGenesymbols <- function(IDs, component, sources) {
  
  parameters <- list(
    typeChoice = "Gene Symbol",
    IDs = IDs,
    TableName = component,
    DataSet = sources
  )
  
  # ... send http POST
  res <- POST(url, body = parameters, encode = "form", verbose())
}





# make results-map as keyword - value
makeMap <- function(res) {
  
  ENTRY_DEL = "\001"
  KEY_DEL = "\002"
  
  response = content(res, "text")
  
  arr = unlist(strsplit(response, ENTRY_DEL, fixed = TRUE))
  
  list_map <- list("")
  vec_map_names <- c("");
  
  for (str in arr) {
    arrKeyValue = unlist(strsplit(str, KEY_DEL, fixed = TRUE));
    
    if (length(arrKeyValue) > 1) {
      list_map[length(list_map) + 1] <- arrKeyValue[2]
      vec_map_names[length(vec_map_names) + 1] <- arrKeyValue[1]
    }
  }
  
  names(list_map) <- vec_map_names
  
  list_map
}



#####################################
# Example of search on Gene Symbols #
#####################################

# Gene Symbols
# - Comma delimited.
# - Mind case.

genes <- read.csv(here("results","final","primary_topGenes_limma2.csv"))
IDs <- toString(genes$gene)


# Data component
# - Uncomment the only one of those five:
# component <- "Literature curated (core) pathway memberships"
component <- "Extended pathway associations. Protein interaction set: Experimentally detected PPIsMinimum confidence level for predicted associations: 0.99"
# component <- "Extended pathway associations. Protein interaction set: Experimentally detected PPIsMinimum confidence level for predicted associations: 0.95"
# component <- "Extended pathway associations. Protein interaction set: Experimentally detected and computationally predicted PPIs (full IID)Minimum confidence level for predicted associations: 0.99"
# component <- "Extended pathway associations. Protein interaction set: Experimentally detected and computationally predicted PPIs (full IID)Minimum confidence level for predicted associations: 0.95"


# Data sources
# - Use some or all of those:
#       BioCarta, EHMN, HumanCyc, INOH, IPAVS, KEGG, NetPath, OntoCancro, PharmGKB, PID, RB - Pathways, Reactome, stke, systems - biology.org, Signalink, SIGNOR, SMPDB, Spike, UniProt_Pathways, WikiPathways
# - Comma delimited.
# - Mind exact spelling.
#sources <- "BioCarta,EHMN,HumanCyc,INOH,IPAVS,KEGG,NetPath,OntoCancro,PharmGKB,PID,RB-Pathways,Reactome,stke,systems-biology.org,Signalink,SIGNOR,SMPDB,Spike,UniProt_Pathways,WikiPathways";

# Soureces specifically set to KEGG for our pathway enrichment analysis
sources<- "KEGG"
res <- searchOnGenesymbols(IDs, component, sources)

responseCode = status_code(res)
if (responseCode != 200) {
  
  cat("Error: Response Code : ", responseCode, "\r\n")
} else {
  
  list_map <- makeMap(res)
  
  # print results
  cat("\r\n", "Search on Uniprot IDs:", "\r\n")
  
  cat("Generated at: ", unlist(list_map["GeneratedAt"]), "\r\n")
  cat("IDs: ", unlist(list_map["IDs"]), "\r\n")
  cat("DataComponent: ", unlist(list_map["TableName"]), "\r\n")
  cat("Sources: ", unlist(list_map["DataSet"]), "\r\n")
  
  cat("\r\n", "Summary size: ", unlist(list_map["SummarySize"]), "\r\n")
  sm <- unlist(list_map["Summary"])
  cat("Summary: \r\n", sm, "\r\n") # formatted as tab - delimited spreadsheet
  
  cat("\r\n", "Details size: ", unlist(list_map["DetailsSize"]), "\r\n")
  dl <- unlist(list_map["Details"])
  cat("Details: \r\n", dl, "\r\n") # formatted as tab - delimited spreadsheet
  
  df.Summary <- read_tsv(sm)
  df.Details <- read_tsv(dl)
  write.csv(df.Details,here("results","final","pathway_KEGG_primary_genes"))
}