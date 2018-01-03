# Read multipled CSV files and convert to a list
rm(list = setdiff(ls(), lsf.str())) #Clear All

filepath <-  paste(getwd(),"/FPL_16/", sep ="")
fileappend <- "FPL16-GW"
fileiter <- 5
fileext <- ".csv"
file_vec <- c(filepath,fileappend,fileiter,fileext)
myfilename <- paste(file_vec,collapse = "")
players <- read.csv(myfilename, header= TRUE )
web_name <- display_name(players)
# Open Multiple CSV files
temp = list.files(filepath,pattern="*.csv")
setwd(filepath)
for (i in 1:length(temp)){ 
  assign(temp[i], read.csv(temp[i]))
}