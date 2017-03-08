rm(list=ls())
#install.packages("tm")
#install.packages("wordcloud")

source(file = "data-prep.R")
source("sentiment.r")
library(ggplot2)

## Describing Data Structure
nrow(df)
ncol(df)
summary(wordTable$count)

## Univariate Analysis
# Common Words
head(wordTable, 10)
plot(head(wordTable$count, 10))
plot(head(wordTable$count, 50))
plot(head(wordTable$count, 100))
plot(wordTable$count)
hist(head(wordTable$count, 50), xlab = "Number of words", breaks = 15, main = "Trump's Count of Common Words")

# Sentiment of Tweets
pos = readLines("positive_words.txt")
neg = readLines("negative_words.txt")

trumpScore <- score.sentiment(all_tweets$Text,pos, neg)$score
hist(trumpScore)
summary(trumpScore)
sd(trumpScore)

## Univariate Analysis by Category
# plots the given sentiment in time in form yy/mm/dd
num <- substr(all_tweets$Date, 4,5)
all_tweets <- mutate(all_tweets, Sentiment = trumpScore, Month = num)
all_tweets <- all_tweets[grepl("16-", df$Date),]
all_tweets <- arrange(all_tweets, desc(Date))
hist(all_tweets$Sentiment)

## Bivariate Analysis
# create facets
q <- ggplot(all_tweets, aes(x = Date, y = Sentiment, shape = NULL)) + geom_point(size = 0.5)
q + facet_grid(Sentiment~Month) 

#cor(x = as.numeric(all_tweets$Month), y = all_tweets$Sentiment, method = "kendall")
#cov(x = as.numeric(all_tweets$Month), y = all_tweets$Sentiment)





