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

source("twitterApp.R")

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)


Amnesty_tweets <- userTimeline("amnesty", n = 3200)

PETA_tweets <- userTimeline("peta", n = 3200)

RedCross_tweets <- userTimeline("RedCross", n = 3200)



save(Amnesty_tweets, file = "./dataset/Amnesty_tweets.rda")

save(PETA_tweets, file = "./dataset/PETA_tweets.rda")

save(RedCross_tweets, file = "./dataset/RedCross_tweets.rda")



