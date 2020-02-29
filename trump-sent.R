#clean trump's tweets
getUser('realdonaldtrump')
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
trumptweets <- userTimeline(c("realDonaldTrump"), n = 1000)
n.tweet <- length(trumptweets)

tweets.df <- twListToDF(trumptweets)
head(tweets.df)
text <- data.frame(tweets.df$text)

tweets.clean <- tm_map(text, stripWhitespace)

mycorpus <- Corpus(VectorSource(tweets.df))
str(mycorpus)
corpus1 <- tm_map(mycorpus, stripWhitespace)
corpus2 <- tm_map(corpus1, tolower)
corpus3 <- tm_map(corpus2, removeWords, stopwords('english'))
corpus4 <- tm_map(corpus3, removePunctuation)
corpus5 <- tm_map(corpus4, removeNumbers)


tweetIDs <- tweets.df$status_id
text <- tweets.df$text

#clean the text
text.clean <- gsub("http.*","",tweets.df$text)
text.clean <- gsub("https.*","",text.clean)
text.clean <- gsub("#.*","",text.clean)
text.clean <- gsub("@.*","",text.clean)

####NEED TO CLEAN THESE TWEETS MORE- STEM, GET RID OF EMOJIS AND WEIRD CHARACTERS AND ALL THAT JAZZ
library(tidytext)
library(tm)
library(widyr)
text.clean <- 

#get sentiment score for tweets
word.df <- as.vector(text.clean)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(text.clean, emotion.df)
head(emotion.df2)

#sentiment values
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.negative <- word.df[sent.value <= min(sent.value)]
most.neutral <- word.df[sent.value == median(sent.value)]

most.positive
most.negative
most.neutral
