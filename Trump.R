app_name<-"rClover"
consumer_key<-"gDtc0StNa7jMwy8lGCaemIvLm"
consumer_secret<-"ZwvzdDzHksJnnoy9no9FiwdR9Cp9gJs6t4sw0Qf9elNI4m6gB4"
access_token<-"24455569-BFlpQ0biRq03Rb0NTKBHbqxxdipvOUx9YmHh6Rhf6"
access_secret <-"Rf5UgBKAf4zumiVXDtqlBWZj2EBaXp3BlRYKQzFlfTTiR"

library(devtools)
library(rtweet)
library(dplyr)
create_token(app=app_name, consumer_key=consumer_key, consumer_secret=consumer_secret)

#collect 1000 tweets from trump
trumptweets <- get_timelines(c("realDonaldTrump"), n = 1000)
#make it so only includes user_id, status_id, and text
trump <- trumptweets[,c(1,2,3,5,13,14)]
retweet <- trumptweets$retweet_text
trump <- cbind(trump, retweet, stringsAsFactors = FALSE)
trump <- subset(trump, is.na(trump$retweet))

#sentiment of tweet
trump$text.clean <- trump$text
word.df <- as.vector(trump$text.clean)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(trump, emotion.df)
sent.value <- get_sentiment(word.df)
trump <- cbind(emotion.df2, sent.value)
rownames(trump) <- c()
which.min(trump$sent.value)
which.max(trump$sent.value)
trump.neg <- trump[47,]
trump.pos <- trump[58,]
trump.neut <- trump[74,]

negRT <- get_retweets('1107020360803909632')
posRT <- get_retweets('1106634712871784448')
neutRT <- get_retweets('1106173343475081217')