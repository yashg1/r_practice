#Read CSV files using PURRR / LAPPLY
cat("\014")  #Clear Screen
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
source("player_ppgw.R")
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
#Select Player Name to extract points per GW data
player_name <- sort(str_to_lower(c("degea","Hennessey"))) # Do Not Enter a single character
pattern <- paste(player_name, collapse = "|")
n_players <- length(player_name)
## Extract Player ppgw data
player_extract_data <- map(game_week,~filter(.x,grepl(pattern,dis_name)))%>% 
  map(~select(.x, PointsLastRound, TotalPoints, Cost, SelectedByPercent, EAIndex, Form,NextFixture1 )) 
#Extract data from Player Positions
player_extract_data_positions <- map(game_week,~group_by(.x,PositionsList)) %>% 
  map(~summarise(.x,mean_pts = mean(PointsLastRound[MinutesPlayed!=0]), 
                 mean_selected_by = mean(SelectedByPercent) ,
                 num_pos_players = n()))
# Extract Team data
team_extract_data <- map(game_week,~group_by(.x,Team)) %>%
map(~summarise(.x,meanteampts = mean(PointsLastRound[MinutesPlayed!=0]),
               totalteampts = sum(PointsLastRound),
               meanform = mean(Form[MinutesPlayed!=0]),
               meancost = mean(Cost),
               nettransfers = sum(TransfersInRound) - sum(TransfersOutRound),
               maxselectedby = max(SelectedByPercent),
               pointsperdollar = sum(TotalPointsPerDollar[MinutesPlayed!=0]), 
               bonus = sum(Bonus),
               numteamplayers = n()))
#lapply(d, function(x) p<- ggplot(x, aes(x = mean_form, y = mean_cost, color = Team))+geom_jitter() )
# Select variables from team data
var_select = c("pointsperdollar","bonus")
team_var_select <- map(team_extract_data, ~select(.x,var_select))
team_var_select_df <- as.data.frame(team_var_select)  
teamlist <- team_extract_data$GW05$Team
team_var_select_df <- as.data.frame(cbind(teamlist,team_var_select_df))
names(team_var_select_df) <- gsub(".", "_", names(team_var_select_df), fixed = TRUE)
gather_df_long <- team_var_select_df %>% gather(obstype_gw,obs_value,-teamlist)
# gather_df_normal <- gather_df_long %>% spread(obstype_gw,obs_value)
# gather_temp <- gather_df_long %>% unite(var_ID, team_list,obstype_gw,sep="_")
gather_temp <- gather_df_long %>% separate(obstype_gw, into = c('GW','obs_type'),sep = '_')
gather_spread <- spread(gather_temp,obs_type,obs_value)
gather_spread$GW <- as.numeric(str_extract(gather_spread$GW,"[0-9]+"))

myplot <- gather_spread %>% subset(teamlist == "ARS"| teamlist == "TOT"|teamlist == "CHE"|teamlist == "MCI") %>%
  ggplot(aes(x = pointsperdollar, y = bonus,color = teamlist))
myplot + geom_point(size = 2.5,alpha = 0.7)+geom_line(size = 1)+scale_x_log10()

# ------------------------- Extract Points vs. Game Week
# a <- player_ppgw(player_extract_data)
# g <- a %>% ggplot(aes(x = gw, y = pts, color = player_name)) 
# g+ geom_point(color="magenta",size=4,shape=8) + geom_line(size =1.2)
#-----------------------------
# # End Restore WD
setwd("D:/Grad School/Coursework/Extra/R/Tutorials/r_practice")

