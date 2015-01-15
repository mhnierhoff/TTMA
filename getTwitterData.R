################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

## Text Mining of Twitter Tweets  

library(devtools)
library(rjson)
library(bit64)
library(httr)
library(twitteR)

source("twitterApp.R")

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

Amnesty_tweets <- userTimeline("Amnesty", n = 3200)

PETA_tweets <- userTimeline("peta", n = 3200)

RedCross_tweets <- userTimeline("RedCross", n = 3200)

save(Amnesty_tweets, file = "./dataset/Amnesty_tweets.rda")

save(PETA_tweets, file = "./dataset/PETA_tweets.rda")

save(RedCross_tweets, file = "./dataset/RedCross_tweets.rda")




