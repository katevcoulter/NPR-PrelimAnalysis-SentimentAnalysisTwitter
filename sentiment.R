#analysis time to find some vis

#visualize the sentiment values

#subset trump so from 2017 - march, 2019 
trump <- trump[trump$created_at >= '2018-01-01' & trump$created_at <= '2018-12-31',]

#create 3 separate datasets
trump$response <- trump$retweet_count + trump$favorite_count
trump$created_at <- as.Date(trump$created_at, format = '%m/%d/%y')
trump$month <- as.Date(cut(trump$created_at, breaks='month'))
trump$year <- as.Date(cut(trump$created_at, breaks='year'))
trump$day <- as.Date(cut(trump$created_at, breaks='day'))
trump$week <- as.Date(cut(trump$created_at, breaks='week'))
trump <- na.omit(trump)

#look at how sent.value seems to interact with response
#plot something to get basic idea
ggplot(data = trump, aes(x = sent.value, y = response)) + geom_smooth()
ggplot(trump, aes(x = as.factor(anger), y = response)) + geom_boxplot()
ggplot(trump, aes(x = as.factor(disgust), y = response)) + geom_boxplot()


trump$category <- cut(trump$sent.value, breaks=c(-Inf,1,Inf), labels=c('negative', 'positive'))
write.csv(trump, 'trump.csv')
positive <- subset(trump, category=='positive')
positive$created_at <- as.Date(positive$created_at)
pos.summary <- with(positive, aggregate(list(retweet_count, favorite_count, response, sent.value), by = list(week), 
                                      FUN = function(x) { mon.sum = sum(x, na.rm = TRUE) } ))
pos.summary <- do.call(data.frame, my.summary)
colnames(pos.summary) <- c('week', 'RTavg', 'favavg', 'respavg', 'sent.avg')
pos.summary

negative <- subset(trump, category=='negative')
negative$created_at <- as.Date(negative$created_at)
neg.summary <- with(negative, aggregate(list(retweet_count, favorite_count, response, sent.value), by = list(week), 
                                        FUN = function(x) { mon.mean = mean(x, na.rm = TRUE) } ))
neg.summary <- do.call(data.frame, my.summary)
colnames(neg.summary) <- c('week', 'RTavg', 'favavg', 'respavg', 'sent.avg')
neg.summary


ggplot(data = neg.summary, aes(x = week, y = respavg)) + geom_smooth()
ggplot(data = pos.summary, aes(x = week, y = respavg)) + geom_smooth()



trump %>% group_by(week) %>% summarise(median = median(count, na.rm = TRUE))




ggplot(trump, aes(x=week, fill=))




write.csv(positive, file='positive.csv')
write.csv(negative, file='negative.csv')
write.csv(neutral, file='neutral.csv')


#plots
qplot(x = month, y = response, data = positive, main="Response by Positive Tweet\n 2015 - 2019", xlab = 'Date', ylab='Response on Twitter')
qplot(x = created_at, y = response, data = negative, main="Response by Negative Tweet\n 2015 - 2019", xlab = 'Date', ylab='Response on Twitter')


ggplot(data = positive, aes(x=created_at, y = response)) + geom_point()

d <- density(trump$sent.value)
plot(d)

#seems like outliers must exist, so look at histogram
hist(trump$sent.value, breaks = 20)

#going to look at sentiment values between -5 and 5
#save copy of all tweets
trump.df <- trump
#make categories for sentiment
trump$category <- cut(trump$sent.value, breaks=c(-5,0,.5,5), labels=c('negative', 'neutral', 'positive'))

ggplot(trump, aes(x=sent.value, fill=category)) + geom_density(alpha = 0.3)


# find outliers of response from tweets in 2018
summary(trump$response)
#min = 13, Q1 = 78844, med = 102825, mean = 108952, Q3 = 131204, max = 691020
#find IQR = 131204 - 78844 = 52360
#1.5*IQR = 78540

# plot distribution of response
d <- ggplot(trump, aes(x = response))
d + geom_density() + geom_vline(aes(xintercept = mean(response)), 
                                linetype='dashed', size=0.6)

library(ggpubr)
theme_set(theme_pubclean())
d + geom_density(aes(y = ..count..), fill = "lightgray") +
  geom_vline(aes(xintercept = mean(response)), 
             linetype = "dashed", size = 0.6,
             color = "#FC4E07")

