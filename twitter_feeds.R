#Extract tweets using Twitter App
# Link: https://arpitsolanki14.wordpress.com/2017/10/19/fetch-tweets-using-twitter-package-in-r/
# Link: http://varianceexplained.org/r/trump-tweets/
cat("\014")  #Clear Screen
rm(list = setdiff(ls(), lsf.str())) #Clear All
require("twitteR")
require("rtweet")
require("httpuv")
#Create Corpus
require("tm")
require("ggplot2")
require("tidyr")
require("stringr")
require("dplyr")
require("SnowballC")
require("wordcloud")
require("ROAuth")

##------
#Using Twitter Package
cust_key <- "f63W52HGvTVGqfwk9nrsAc4gK"
cust_secret <- "J88QVo0HkruKJWKjDlU9SRnzVmGn9cBDhxcGOutzKx9Bdh7EFO"
access_token <- "953025628021907461-fgBFmUEusXMXbLL0ayzySURbAil5vQb"
access_secret <- "1fGUUwLz7NAAWAKN2WMXWwBGDBg9bH0qELvpinKqIwKxA"
#setup_twitter_oauth(cust_key, cust_secret, access_token, access_secret)
##------
##-----
#Using Rtweet package
twitter_token <- create_token(
  app = "datatrial1",
  consumer_key = cust_key,
  consumer_secret = cust_secret)
## path of home directory
home_directory <- path.expand("~/")
## combine with name for token
file_name <- file.path(home_directory, "twitter_token.rds")
## save token to home directory
saveRDS(twitter_token, file = file_name)
##-----
search.string <- "wenger OR arsenal"
num_tweets <- 15e2
tweets <- search_tweets(search.string, n = num_tweets, include_rts = TRUE,retryonratelimit = TRUE)
ts_plot(tweets, "1 hour")
# tweets <- searchTwitter(search.string, n=no.of.tweets,lang="en")
# tw = twitteR::searchTwitter('#realDonaldTrump + #HillaryClinton', n = 1e4, since = '2016-11-08', retryOnRateLimit = 1e3)
sf <- get_trends("london")

