#!/usr/bin/env r
##
##  Convert a DOI to it bibtext field
##
##  Copyright (C) 2024  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)
##
##  With thanks to https://bsky.app/profile/rmcelreath.bsky.social/post/3knkqvogwbc25

## load docopt package from CRAN
library(docopt)
library(httr)

## configuration for docopt
doc <- "Usage: doi2bib.r [-h] [-x] DOI

-h --help             show this help text
-x --usage            show help and short example usage"

opt <- docopt(doc)          # docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  doi2bib..r 10.1002/evan.10110

doi2bib.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

res <- GET(paste0("https://doi.org/", opt$DOI),
           add_headers(Accept="application/x-bibtex"))
cat(rawToChar(res$content))
