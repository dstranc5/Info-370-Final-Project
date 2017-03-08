## Removing unwanted characters/phrases from the gathered twitter data

# read in file
trump_data <- read.csv("post-election-data.csv")

# function taken from http://varianceexplained.org/r/trump-tweets/
# I tweaked it so that it creates a new column where all special characters
# except #'s, links, and usernames (@username) are removed.
post_election <- trump_data %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(Text = str_replace_all(text, "http.+|&[a-zA-Z0-9]+|@[A-Za-z0-9]+|[^A-Za-z0-9# ]", ""))
  
# write file to csv
write.csv(post_election, "trump-tweets.csv", append = FALSE)
