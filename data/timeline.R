##install.packages("timevis")
library(timevis)

start <- c('2015-07-16', '2015-08-06', '2015-09-16', '2015-10-28', '2015-11-10', '2015-12-15', '2016-01-14', '2016-01-28',
           '2016-02-06', '2016-02-13', '2016-02-25', '2016-03-01', '2016-03-03', '2016-03-10', '2016-05-26', '2016-07-16',
           '2016-07-21', '2016-07-28', '2016-09-26', '2016-10-09', '2016-10-19', '2016-10-28', '2016-11-06', '2016-11-08',
           '2016-12-19', '2017-01-20')

start <- as.Date(start, format = "%Y-%m-%d")

content <- c("First Tweet collected from Trump", "First Republican Debate", "Second Republican Debate", "Third Republican Debate", "Fourth Republican Debate",
             "Fifth Republican Debate", "Sixth Republican Debate", "Seventh Republican Debate", "Eighth Republican Debate",
             "Ninth Republican debate", "Tenth Republican debate", "Super Tuesday", "Eleventh Republican debate", "Twelfth Republican Debate",
             "Trump Passes 1237 Pledged Delegates", "Trump Announces Pence as VP", "Trump Accepts Republican Nomination", "Hillary Clinton Accepts Democratic Nomination",
             "First Presidential General Election Debate", "Second Presidential General Election Debate", "Third And Final Presedential Debate", 
             "FBI Discovers New Emails On Clinton's Server", "FBI Says Charges Will Not Be Pressed On Clinton", "Election Day", "Electoral College Formally Votes In Trump",
             "Inauguration of Donald Trump")

df.events <- data.frame(start, content, end = NA)
df.events[] <- lapply(df.events, as.character)
df.events$start <- as.Date(df.events$start, format = "%Y-%m-%d")
df.events$end <- as.Date(df.events$end, format = "%Y-%m-%d")

timevis(df.events)