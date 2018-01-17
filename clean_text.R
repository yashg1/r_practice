# Clean Tweets and Text ; my_text should be from a Corpus
# From https://arpitsolanki14.wordpress.com/2017/10/21/step-by-step-analysis-of-twitter-data-using-r/
cleaned_text <- function(my_text){
  toSpace <- content_transformer(function(x, pattern) 
    ((gsub(pattern, " ", x))
    ))
  docs <- tm_map(my_text, toSpace, "&")
  docs <- tm_map(docs, toSpace, "@\\w+")
  docs <- tm_map(docs, toSpace, "<\\w*>")
  docs <- tm_map(docs, toSpace, "http.*\\s*")
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeNumbers) 
  docs <- tm_map(docs, function(x) iconv(enc2utf8(x), sub = "byte"))
  docs <- tm_map(docs,content_transformer(tolower))
  docs <- tm_map(docs,stripWhitespace)
  #remove stopwords using the standard list in tm
  docs <- tm_map(docs, removeWords, stopwords("english"))
  #Stem Document
  docs <- tm_map(docs,stemDocument)
  
  
  
  # my_text = gsub("[[:digit:]]", " ", my_text)#Remove numbers
  # # my_text = gsub("@", "", my_text)
  # my_text = gsub("^\\s+|\\s+$", " ", my_text)#Remove Leading and trailing spaces
  # my_text = gsub("[[:punct:]]", " ", my_text)#Remove punctuation marks and special characters
  # 
  return(docs)
}