require("ggplot2")
#require("plyr")
require("dplyr")
rm(list = setdiff(ls(), lsf.str())) #Clear All
setwd("D:/Grad School/Coursework/Extra/R/Tutorials/r_practice")
#setwd("~/R_tutorials/r_practice")
gap_wide <- read.csv("gapminder_wide.csv",stringsAsFactors = FALSE)
str(gap_wide)
tibble_vis <- tbl_df(gap_wide) #Better than str to see
gap_long <- gap_wide %>% gather(obstype_year,obs_values,starts_with('pop'),
                                starts_with('lifeExp'), starts_with('gdpPercap') )
gap_long <- gap_wide %>% gather(obstype_year,obs_values,-continent,-country)
gap_long <- gap_long %>% separate(obstype_year,into=c('obs_type','year'),sep="_")
gap_long$year <- as.integer(gap_long$year)
