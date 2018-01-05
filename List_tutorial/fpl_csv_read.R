#Read CSV files using PURRR / LAPPLY
rm(list = setdiff(ls(), lsf.str())) #Clear All
#Packages
require("stringr")
require("ggplot2")
require("purrr")
require("tidyr")
require("dplyr")
require("stringr")
##
wd_now <-  paste(getwd(),"/FPL_16/", sep ="")
setwd(wd_now)
files <- list.files(pattern = "csv$") 
files <- files[1:3]
dat <- map(files, read.csv)
f1 <- gsub("FPL16-","", files)
f2 <- gsub("\\.csv", "", f1)
names(dat) <- f2

source("display_name.R")
# Combine Display Names
game_week <- lapply(dat, display_name)