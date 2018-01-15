#Extract tweets using Twitter App
# Link: https://arpitsolanki14.wordpress.com/2017/10/19/fetch-tweets-using-twitter-package-in-r/
# Link: http://varianceexplained.org/r/trump-tweets/
cat("\014")  #Clear Screen
rm(list = setdiff(ls(), lsf.str())) #Clear All
require("twitteR")
#Create Corpus
require("tm")
require("ggplot2")
require("tidyr")
require("stringr")
require("dplyr")
require("SnowballC")
require("wordcloud")
##
twitter_key<-" f63W52HGvTVGqfwk9nrsAc4gK"
twitter_secret<-" J88QVo0HkruKJWKjDlU9SRnzVmGn9cBDhxcGOutzKx9Bdh7EFO"
oauth<-setup_twitter_oauth(twitter_key, twitter_secret)