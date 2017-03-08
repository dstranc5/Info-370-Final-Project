rm(list=ls())

## install.packages("tidytext")
## install.packages("SnowballC")
library(dplyr)
library(tidytext)
library(stringr)
library(RColorBrewer)
library(wordcloud)
library(tm)
library(SnowballC)

# read in the post-election dataset
source("remove-specials.R")

## Data Prep
# read in the file and select columns of possible importance
df <- read.csv("Crowdbabble_Social-Media-Analytics_Twitter-Download_Donald-Trump_7375-Tweets.csv", header = TRUE)
df <- select(df, Date, Time, Tweet_Text, Type, Media_Type, Hashtags, Tweet_Id, Tweet_Url, twt_favourites_IS_THIS_LIKE_QUESTION_MARK, Retweets)

# remove special characters from the tweets and create a new column called Text with the filtered tweets
pre_election <- df %>%
  mutate(Text = str_replace_all(Tweet_Text, "http.+|&[a-zA-Z0-9]+|@[A-Za-z0-9]+|[^A-Za-z0-9# ]", ""))

# create a new column called Date that contains the relevant date information
post_election <- mutate(post_election, Date = substr(post_election$created, 3, 11))

# for both dataframes, select only necessary columns and rename them with nicer names.
# combine the two dataframes into one new one
pre_election <- select(pre_election, Date, Text, Favorites = twt_favourites_IS_THIS_LIKE_QUESTION_MARK, Retweets)
post_election <- select(post_election, Date, Text, Favorites = favoriteCount, Retweets = retweetCount)
pre_election <- arrange(pre_election, Date)
post_election <- arrange(post_election, Date)
all_tweets <- rbind(pre_election, post_election)

# write dataframe to a new CSV file
write.csv(all_tweets, "all-tweets.csv", append = FALSE)

# delete any tweets that are earlier than 16-11-11 in the post election data so
# there are no repetitive tweets. combine the datasets again into a new dataframe.
post_election <- dplyr::filter(post_election, Date > "16-11-11")
tweets <- rbind(pre_election, post_election)


## function taken from http://varianceexplained.org/r/trump-tweets/
## Creates a new column where each row is a single word
reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
wordTable <- tweets %>%
  filter(!str_detect(Text, '^"')) %>%
  mutate(text = str_replace_all(Text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, Text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

## Selects the given column(s) from the given data frame and stores into a new data frame
wordTable <- select(wordTable, word)

# Remove any occurrences of rt which stands for retweet
wordTable$word[wordTable$word == "rt"] <- NA
wordTable <- na.omit(wordTable)

# create a new wordcloud with the given color pallete and a max of 75 words
pal <- brewer.pal(3, "Set1")
wordcloud(wordTable$word, max.words = 75, random.order = FALSE, colors = pal, 
          random.color = FALSE)

# create a new column which is a count of each word
wordTable <- dplyr::group_by(wordTable, word)
wordTable <- dplyr::summarize(wordTable, count = n())
wordTable <- arrange(wordTable, desc(count))

# write dataframe to a new CSV file
write.csv(wordTable, "word-count.csv", append = FALSE)
