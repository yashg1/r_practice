# Read multipled CSV files and convert to a list
rm(list = setdiff(ls(), lsf.str())) #Clear All

filepath_1 <-  paste(getwd(),"/FPL_16/", sep ="")
fileappend <- "FPL16-GW"
fileiter <- 37
fileext <- ".csv"
file_vec <- c(filepath_1,fileappend,fileiter,fileext)
myfilename <- paste(file_vec,collapse = "")
players <- read.csv(myfilename, header= TRUE )
source("display_name.R")
web_name <- display_name(players)
# Open Multiple CSV files
filepath_2 <-  paste(getwd(),"/FPL_16/", sep ="")
temp = list.files(filepath_2,pattern="*.csv")
myfiles = lapply(temp[1:3], read.csv)
#setwd(filepath_2)
# for (i in 1:3){
#   assign(temp[i], read.csv(temp[i]))
# }
#a <- dapply(temp[1:3],read.csv, header  = TRUE)
