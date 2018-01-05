#Read CSV files using PURRR / LAPPLY
rm(list = setdiff(ls(), lsf.str())) #Clear All
#Packages
require("stringr")
require("ggplot2")
require("purrr")
require("tidyr")
require("dplyr")
require("stringr")

source("D:/Grad School/Coursework/Extra/R/Tutorials/r_practice/display_name.R")

##
wd_now <-  paste(getwd(),"/FPL_16/", sep ="")
#setwd(wd_now)
files <- list.files(pattern = "csv$") 
#files <- files[1:6]
dat <- map(files, read.csv)
f1 <- gsub("FPL16-","", files)
f2 <- gsub("\\.csv", "", f1)
names(dat) <- f2

# Combine Display Names
game_week <- lapply(dat, display_name)
# game_week$GW05[game_week$GW05$Surname %in% "Cech","TotalPoints"]

points_data <- lapply(game_week,function(x) x[x$Surname %in% "Xhaka",8])
points_df <- data.frame(unlist(points_data))
p <- ggplot(points_df, aes(names(points_data),points_df[[1]]))
p + geom_bar(stat = "identity")
               