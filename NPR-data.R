#use archival tweets from 2015-2019
# get data

trump2015 <- read.csv('trump2015.csv')
trump2016 <- read.csv('trump2016.csv')
trump2017 <- read.csv('trump2017.csv')
trump2018 <- read.csv('trump2018.csv')
trump2019 <- read.csv('trump2019.csv')
archive <- rbind(trump2015, trump2016)
archive <- rbind(archive, trump2017)
archive <- rbind(archive, trump2018)
archive <- rbind(archive, trump2019)

#reformat dates
archive$created_at <- as.Date(archive$created_at, format='%m/%d/%y')

#clean text
archive$clean <- archive$text
textprocessing <- function(x)
{gsub("http[[:alnum:]]*",'', x)
  gsub('http\\S+\\s*', '', x) ## Remove URLs
  gsub('\\b+RT', '', x) ## Remove RT
  gsub('#\\S+', '', x) ## Remove Hashtags
  gsub('@\\S+', '', x) ## Remove Mentions
  gsub('[[:cntrl:]]', '', x) ## Remove Controls and special characters
  gsub("\\d", '', x) ## Remove Controls and special characters
  gsub('[[:punct:]]', '', x) ## Remove Punctuations
  gsub("^[[:space:]]*","",x) ## Remove leading whitespaces
  gsub("[[:space:]]*$","",x) ## Remove trailing whitespaces
  gsub(' +',' ',x) ## Remove extra whitespaces
}
archive$clean <- textprocessing(archive$clean)

#sentiment analysis
word.df <- as.vector(archive$clean)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(archive, emotion.df)
sent.value <- get_sentiment(word.df)
trump <- cbind(emotion.df2, sent.value)

#keep only relevant variables
trump$anger <- NULL
trump$anticipation <- NULL
trump$disgust <- NULL
trump$fear <- NULL
trump$joy <- NULL
trump$sadness <- NULL
trump$surprise <- NULL
trump$trust <- NULL
trump$negative <- NULL
trump$positive <- NULL


