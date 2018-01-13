#Read CSV files using PURRR / LAPPLY
rm(list = setdiff(ls(), lsf.str())) #Clear All
#Packages
#require("tidyverse")
require("stringr")
require("ggplot2")
require("purrr")
require("tidyr")
require("dplyr")
require("stringr")
setwd("D:/Grad School/Coursework/Extra/R/Tutorials/r_practice")
#setwd("../R_tutorials/r_practice")
source("display_name.R")

## Set WD to locate csv files
wd_now <-  paste(getwd(),"/FPL_16/", sep ="")
setwd(wd_now)
#file.path("..","FPL_16/")
files <- list.files(pattern = "csv$") 
#files <- files[1:6]
dat <- map(files, read.csv)
f1 <- gsub("FPL16-","", files)
f2 <- gsub("\\.csv", "", f1)
names(dat) <- f2

# Combine Display Names
game_week <- lapply(dat, display_name)
# Extract Points from Game_Week list
#lapply applies a function to each data frame in the list sequentially
# game_week$GW05[game_week$GW05$Surname %in% "Cech","TotalPoints"]
#points_data <- lapply(game_week,function(x) x[x$Surname %in% "Xhaka","TotalPoints"])
# points_df <- data.frame(unlist(points_data))
# p <- ggplot(points_df, aes(names(points_data),points_df[[1]]))
# p + geom_bar(stat = "identity")

# Dataframe Manipulation 2
#a <- lapply(game_week,select(dis_name,PositionsList,Team,Cost,TotalPoints))
#a <- game_week$GW05 %>% select(dis_name,PositionsList,Team,Cost,TotalPoints)
#b <- game_week$GW05 %>% group_by(Team) %>% summarise(mean_pts = mean(TotalPoints))

player_name <- str_to_lower(c("ozil","sanchez","aguero")) # Do Not Enter a single character
## Add code to preserve order - critical!
pattern <- paste(player_name, collapse = "|")
n_players <- length(player_name)
# player_extract_data <- map(game_week,~filter(.x,grepl(player_name,dis_name)))%>% 
#                        map(~select(.x,PointsLastRound,TotalPoints, EAIndex, Form,NextFixture1 )) 
player_extract_data <- map(game_week,~filter(.x,grepl(pattern,dis_name)))%>% 
  map(~select(.x,PointsLastRound,TotalPoints, EAIndex, Form,NextFixture1 )) 


points_per_gw<- as.data.frame(map(player_extract_data,~select(.x,PointsLastRound)))

last_gw <- player_extract_data$GW37$TotalPoints - 
player_extract_data$GW36$TotalPoints

points_per_gw <- as.data.frame(cbind(points_per_gw,last_gw))
#names(points_per_gw) <- paste("GW",as.character(4:37),sep = "")
names(points_per_gw) <- (4:37)
points_per_gw <- cbind(player_name,points_per_gw)
  
a <- points_per_gw %>% gather(gw,pts,-player_name)

#stack(points_per_gw) %>% ggplot(aes(x = ind, y = values)) + geom_line()



# Old Points per Game Week
# player_points_allGW_vec <- unlist(player_points_allGW)
# ppw <- player_points_allGW_vec[2:length(player_points_allGW_vec)] - player_points_allGW_vec[1:(length(player_points_allGW_vec)-1)]
# ppw <- c(player_points_allGW_vec[1]/5,ppw) #Data available since GW5. Hence GW5 data divided by 5
# plot(ppw)