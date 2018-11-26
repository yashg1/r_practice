#Text Mining tutorial from Kailash A.Check textmining_1 folder
# https://eight2late.wordpress.com/2015/05/27/a-gentle-introduction-to-text-mining-using-r/
cat("\014")  #Clear Screen
rm(list = setdiff(ls(), lsf.str())) #Clear All
#Create Corpus
require("tm")
require("ggplot2")
require("tidyr")
require("stringr")
require("dplyr")
require("SnowballC")
require("wordcloud")
docs <- Corpus(DirSource("./textmining_1/"))
toSpace <- content_transformer(function(x, pattern) 
  ((gsub(pattern, " ", x))
  ))
docs <- tm_map(docs, toSpace, '-')
docs <- tm_map(docs, toSpace, ':')
docs <- tm_map(docs, toSpace, '\\.')
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, toSpace, '’') #Non Standard
docs <- tm_map(docs, toSpace, '‘')
docs <- tm_map(docs, toSpace, "“–•”")
# docs <- tm_map(docs, toSpace, "[^a-zA-Z]")
#Transform to lower case (need to wrap in content_transformer)
docs <- tm_map(docs,content_transformer(tolower))
#Strip digits (std transformation, so no need for content_transformer)
docs <- tm_map(docs, removeNumbers) 
#remove stopwords using the standard list in tm
docs <- tm_map(docs, removeWords, stopwords("english"))
#Stem Document
docs <- tm_map(docs,stemDocument)
dtm <- DocumentTermMatrix(docs)
freq <- colSums(as.matrix(dtm))
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#freq[head(ord)]
dtmr <-DocumentTermMatrix(docs, control=list(wordLengths=c(4, 20),
                                             bounds = list(global = c(1,30))))
freqr <- colSums(as.matrix(dtmr))
ordr <- order(freqr,decreasing=TRUE)
freqr[head(ordr)]
wf=data.frame(term=names(freqr),occurrences=freqr, row.names = NULL)
p <- ggplot(subset(wf, occurrences>100), aes(term, occurrences))
p + geom_bar(stat="identity")

# trial_str <- c("Introduction21 –  –and -relationships– towards - an-emergent- approach to data modelling ")
# gsub("[^a-zA-Z]", " ",trial_str)
#writeLines(as.character(docs[[1]])) %>% head(10)