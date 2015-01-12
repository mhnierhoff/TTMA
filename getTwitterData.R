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

taz_tweets <- userTimeline("tazgezwitscher", n = 3200)

FAZ_tweets <- userTimeline("faznet", n = 3200)

save(SZ_tweets, file = "./dataset/SZ_tweets.rda")

save(taz_tweets, file = "./dataset/taz_tweets.rda")

save(FAZ_tweets, file = "./dataset/FAZ_tweets.rda")




