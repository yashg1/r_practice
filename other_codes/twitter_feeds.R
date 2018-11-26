#Extract tweets using Twitter App
# Link: https://arpitsolanki14.wordpress.com/2017/10/19/fetch-tweets-using-twitter-package-in-r/
# Link: http://varianceexplained.org/r/trump-tweets/
cat("\014")  #Clear Screen
rm(list = setdiff(ls(), lsf.str())) #Clear All
# Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", 
#             "cluster", "igraph", "fpc")
require("twitteR")
#require("rtweet")
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
source("search_string_gen.R")
source("clean_text.R")
##------
#Using Twitter Package
cust_key <- "f63W52HGvTVGqfwk9nrsAc4gK"
cust_secret <- "J88QVo0HkruKJWKjDlU9SRnzVmGn9cBDhxcGOutzKx9Bdh7EFO"
access_token <- "953025628021907461-fgBFmUEusXMXbLL0ayzySURbAil5vQb"
access_secret <- "1fGUUwLz7NAAWAKN2WMXWwBGDBg9bH0qELvpinKqIwKxA"
setup_twitter_oauth(cust_key, cust_secret, access_token, access_secret)
##------
##-----
#Using Rtweet package
# twitter_token <- create_token(
#   app = "datatrial1",
#   consumer_key = cust_key,
#   consumer_secret = cust_secret)
# ## path of home directory
# home_directory <- path.expand("~/")
# ## combine with name for token
# file_name <- file.path(home_directory, "twitter_token.rds")
# ## save token to home directory
# saveRDS(twitter_token, file = file_name)
##-----
search_string <- "arsenal afc" #SPACE between different words
num_tweets <- 10e3
term_sep = "+"
string_combi_gen <- search_string_gen(search_string,term_sep)
tweets <- searchTwitter(string_combi_gen, n=num_tweets,lang="en", retryOnRateLimit = 1e3)
tw_df <- twListToDF(tweets)
tw_text <- tw_df$text
tw_time <- as.POSIXct(tw_df$created, tz = "UTC")
#filter(as.POSIXct(created) < as.POSIXct("2018-01-14 23:59:00",tz = "UTC")) %>%
### ----
myplot_1 <- tw_df  %>% 
  ggplot(aes(created))
myplot_1 + geom_histogram(aes(fill = ..count..), binwidth = 30,
  col = "black", alpha = 0.2)+
  scale_fill_gradient("Count", low="blue", high="red")
### ----
# Create Corpus from Tweet texts
tweet_text <- Corpus(VectorSource(tw_text))
clean_text <- cleaned_text(tweet_text) # Corpus
doc_term_mat <- DocumentTermMatrix(clean_text)
dtm <- as.matrix(doc_term_mat)
freq <- sort(colSums(dtm), decreasing=TRUE)   
#ord <- order(freq)
### ----
wf <- data.frame(word=names(freq), freq=freq,row.names = NULL)   
myplot_2 <- ggplot(subset(wf, freq>300), aes(x = reorder(word, -freq), y = freq))
myplot_2 + geom_bar(stat = "identity") + 
  theme(axis.text.x=element_text(angle=45, hjust=1))
### ----