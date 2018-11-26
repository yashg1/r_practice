# Read multipled CSV files and convert to a list
rm(list = setdiff(ls(), lsf.str())) #Clear All
#Packages
library("stringr")
library("ggplot2")
##
filepath_1 <-  paste(getwd(),"/FPL_16/", sep ="")
fileappend <- "FPL16-GW"
#fileiter <- 37
fileext <- ".csv"
file_vec_1 <- c(filepath_1,fileappend,"05",fileext)
file_vec_2 <- c(filepath_1,fileappend,"06",fileext)
file_vec_3 <- c(filepath_1,fileappend,"37",fileext)
##
myfilename_1 <- paste(file_vec_1,collapse = "")
myfilename_2 <- paste(file_vec_2,collapse = "")
myfilename_3 <- paste(file_vec_3,collapse = "")
myfilename <- c(myfilename_1,myfilename_2,myfilename_3)
names(myfilename) <- c("f1","f2","f3")
##
gw5 <- read.csv(myfilename[1], header= TRUE )
gw6 <- read.csv(myfilename[2], header= TRUE)
gw7 <- read.csv(myfilename[3], header= TRUE)
game_week <- list(gw5,gw6,gw7)
names(game_week) <- c('gw-5','gw-6','gw-7')
source("display_name.R")
# web_name = list(wn1 = rep("0",nrow(gw5)),
#                       wn2 = rep("0",nrow(gw6) ),
#                       wn3 = rep("0",nrow(gw7))
# )
# game_week <- display_name(players$p1)
# web_name$wn2 <- display_name(players$p2)
# web_name$wn3 <- display_name(players$p3)
#extra_elem_index <- which(!web_name$wn3 %in% web_name$wn1)

# Open Multiple CSV files
# filepath_2 <-  paste(getwd(),"/FPL_16/", sep ="")
# temp = list.files(filepath_2,pattern="*.csv")
# myfiles = lapply(temp[1:3], read.csv)
#setwd(filepath_2)
# for (i in 1:3){
#   assign(temp[i], read.csv(temp[i]))
# }
#a <- dapply(temp[1:3],read.csv, header  = TRUE)
