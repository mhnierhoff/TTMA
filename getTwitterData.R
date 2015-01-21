################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################
##                                                                            ##
##                        Text Mining of Twitter Tweets                       ##
##                                                                            ##            
##                    App & Code by Maximilian H. Nierhoff                    ##
##                                                                            ##
##                           http://nierhoff.info                             ##
##                                                                            ##
##         Live version of this app: https://nierhoff.shinyapps.io/TTMA       ##
##                                                                            ##
##         Github Repo for this app: https://github.com/mhnierhoff/TTMA       ##
##                                                                            ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################  

library(devtools)
library(rjson)
library(bit64)
library(httr)
library(twitteR)
library(plyr)

source("twitterApp.R")

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

## Get n tweets of the accounts
Amnesty_tweets <- userTimeline("amnesty", n = 3200)
PETA_tweets <- userTimeline("peta", n = 3200)
RedCross_tweets <- userTimeline("RedCross", n = 3200)

## Change list structure into data frame
Amnesty.df <- twListToDF(Amnesty_tweets)
PETA.df <- twListToDF(PETA_tweets)
RedCross.df <- twListToDF(RedCross_tweets)

## Save text column DF as .csv file
write.csv(Amnesty.df$text, file = "./amnesty.csv")
write.csv(PETA.df$text, file = "./peta.csv")
write.csv(RedCross.df$text, file = "./redcross.csv")