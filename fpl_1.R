# Script to extract FPL data
# Based on script by Jo Gall
library("ggplot2")
require(jsonlite)
require(dplyr)
require(ggplot2)
require(ggrepel)
rm(list = setdiff(ls(), lsf.str())) #Clear All
fpl_data <- fromJSON("https://fantasy.premierleague.com/drf/bootstrap-static")
player_details <- fpl_data$elements
unavail_players <- player_details[player_details$status == "u",]
unavail_logic <- player_details$status == "u"
unavail_index <- which(unavail_logic)
player_details <- player_details[-unavail_index,]
