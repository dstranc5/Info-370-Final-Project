rm(list=ls())

## This code gathers tweets from Donald Trump's twitter timeline (@realDonaldTrump)

#install.packages("ROAuth")
#install.packages("twitteR")
library(ROAuth)
library(twitteR)

## insert API key and secret
api_key<- "CxW67n5PYrepdpriW2l0iW5e0"
api_secret<- "dz5wRdxuQoD1ATOh8N5y67XnkPc10L2YYb1BOuxSJ3tY5OjGAH"
access_token<- "412023662-2VdfV4wSK51ufEhJszcDYujfgUV6ow8Fs2OQTP5o"
access_token_secret<- "CmDxz7F1MrEimdfwIbyxCDBvzIPRQHxFeg7xo9iGWaP0m"

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

tweets_trump <- userTimeline("realDonaldTrump", n=3000)

#transform data into a data frame 
data_trump<- twListToDF(tweets_trump)

#write data to csv
write.csv(data_trump,"post-election-data.csv")

