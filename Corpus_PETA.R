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

# PETA Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/PETA_tweets.rda")

PETA.df <- twListToDF(PETA_tweets)

## Build the corpus, and specify the source to be character vectors 
PETACorpus <- Corpus(VectorSource(PETA.df$text))

## Make it work with the new tm package
PETACorpus <- tm_map(PETACorpus,
                           content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                           mc.cores=1)

## Convert to lower case
PETACorpus <- tm_map(PETACorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
PETACorpus <- tm_map(PETACorpus, content_transformer(removePunctuation))

## Remove numbers
PETACorpus <- tm_map(PETACorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
PETACorpus <- tm_map(PETACorpus, content_transformer(removeURL))

## Remove stopwords from corpus
PETACorpus <- tm_map(PETACorpus, removeWords, c(stopwords("english"), "amp"))

## Final corpus
tdmPETA <- TermDocumentMatrix(PETACorpus)