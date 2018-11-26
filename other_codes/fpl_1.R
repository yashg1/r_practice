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
# Extract All GKs
goalkeepers <- player_details[player_details$element_type == 1 & player_details$minutes > 500,]
p <- ggplot(data = goalkeepers, aes(x = points_per_game,y = as.numeric(selected_by_percent), label = web_name))
d <- p + geom_point(aes(color =  now_cost),size = 4) + geom_text_repel()
d + scale_colour_gradient(low = "blue", high = "red")
# #Extract All MFs
# midfielders <- player_details[player_details$element_type == 3 & player_details$minutes > 1000,]
# p <- ggplot(data = midfielders, aes(points_per_game,as.numeric(selected_by_percent), label = web_name))
# q <- p + geom_point(aes(size =  now_cost), ) + geom_text_repel()
# r <- q + scale_colour_gradient(low = "blue", high = "red")

