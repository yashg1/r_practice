player_ppgw <- function(player_extract_data)
{
points_per_gw<- as.data.frame(map(player_extract_data,~select(.x,PointsLastRound)))
last_gw <- player_extract_data$GW37$TotalPoints - 
player_extract_data$GW36$TotalPoints
points_per_gw <- as.data.frame(cbind(points_per_gw,last_gw))
#names(points_per_gw) <- paste("GW",as.character(4:37),sep = "")
names(points_per_gw) <- (4:37)
points_per_gw <- cbind(player_name,points_per_gw)
a <- points_per_gw %>% gather(gw,pts,-player_name)
a$gw <- as.integer(a$gw)
#stack(points_per_gw) %>% ggplot(aes(x = ind, y = values)) + geom_line()
#b <- a[order(a$player_name),]
return(a)
}
# Old Points per Game Week
# player_points_allGW_vec <- unlist(player_points_allGW)
# ppw <- player_points_allGW_vec[2:length(player_points_allGW_vec)] - player_points_allGW_vec[1:(length(player_points_allGW_vec)-1)]
# ppw <- c(player_points_allGW_vec[1]/5,ppw) #Data available since GW5. Hence GW5 data divided by 5
# plot(ppw)