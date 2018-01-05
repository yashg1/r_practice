require("ggplot2")
#require("plyr")
require("dplyr")
rm(list = setdiff(ls(), lsf.str())) #Clear All
setwd("~/R_tutorials/r_practice")
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv",header = TRUE)
#str(gapminder)
# seAsia <- c("Myanmar","Thailand","Cambodia","Vietnam","Laos")
# country_vec <- unique(gapminder[,1])
# seAsia_indices <- country_vec %in% seAsia
# which(seAsia_indices == TRUE)
# country_vec[seAsia_indices]
# conti_list <- unique(gapminder$continent)
# for (i in conti_list) 
# {
# average_age <- 0
# print(i)
# age <- gapminder[gapminder$continent == i,"lifeExp"]
# average_age <- mean(age)
# #print(average_age)
# if(average_age>50){
# #print(i)
# print(average_age)
# }
# }
#Plot
# ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
#   geom_point(aes(color=continent),shape = 18) + scale_x_log10() +
#   geom_smooth(method="lm", size=1.5) 
# Call Function
# source("calcGDP.R")
# withGDP <- calcGDP(gapminder)
#Data Manipulation - 1
# new <- ddply(
#   .data = gapminder,
#   .variables = c("continent","year"),
#   .fun = function(a) mean(a$lifeExp)
# )
# p2 <- ggplot(data = new[new$continent %in% "Asia",], aes(x = year, y = V1)) + geom_point()
#Data Manipulation - 2
## Using dlplyr package to select, filter data
lifeExp_country_year <- gapminder %>% filter(continent %in% c("Africa","Oceania"))%>% 
                        select(year,lifeExp,country)
#1
gdp_bycontinents <- gapminder %>%
  group_by(continent) %>%
  summarise(a=mean(gdpPercap))
#2
lifeExp_bycountry <- gapminder %>% select(country,lifeExp) %>%
  group_by(country) %>%
  summarize(mean_lifeExp=mean(lifeExp))
#3
gdp_bycontinents_byyear <- gapminder %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap=mean(gdpPercap))
#4
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap=mean(gdpPercap),
            sd_gdpPercap=sd(gdpPercap),
            mean_pop=mean(pop),
            sd_pop=sd(pop))