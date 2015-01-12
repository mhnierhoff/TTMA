################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################
##                                                                            ##
##                        Text Mining of Twitter Tweets                       ##
##                                                                            ##            
##                    App & Code by Maximilian H. Nierhoff                    ##
##                                                                            ##
##                           http://nierhoff.info                             ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

library(devtools)
library(rjson)
library(bit64)
library(httr)
library(twitteR)

source("twitterApp.R")

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

SZ_tweets <- userTimeline("SZ", n = 3200)

BILD_tweets <- userTimeline("BILD", n = 3200)

FAZ_tweets <- userTimeline("faznet", n = 3200)

save(SZ_tweets, file = "./dataset/SZ_tweets.rda")

save(BILD_tweets, file = "./dataset/BILD_tweets.rda")

save(FAZ_tweets, file = "./dataset/FAZ_tweets.rda")




