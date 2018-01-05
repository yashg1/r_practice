# Tutorial from UVA : http://data.library.virginia.edu/getting-started-with-the-purrr-package-in-r/
rm(list = setdiff(ls(), lsf.str())) #Clear All

setwd("D:/Grad School/Coursework/Extra/R/Tutorials/r_practice/List_tutorial")
library("purrr")
library("tidyr")
library("dplyr")
URL <- "http://static.lib.virginia.edu/statlab/materials/data/stocks.zip"
download.file(url = URL, destfile = basename(URL))
unzip(basename(URL))
files <- list.files(pattern = "csv$") 
# read in data
dat <- lapply(files, read.csv)
names(dat) <- gsub("\\.csv", "", files) # remove file extension