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

# Amnesty Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/Amnesty_tweets.rda")

Amnesty.df <- twListToDF(Amnesty_tweets)

## Build the corpus, and specify the source to be character vectors 
AmnestyCorpus <- Corpus(VectorSource(Amnesty.df$text))

## Make it work with the new tm package
AmnestyCorpus <- tm_map(AmnestyCorpus,
                   content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                   mc.cores=1)

## Convert to lower case
AmnestyCorpus <- tm_map(AmnestyCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
AmnestyCorpus <- tm_map(AmnestyCorpus, content_transformer(removePunctuation))

## Remove numbers
AmnestyCorpus <- tm_map(AmnestyCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
AmnestyCorpus <- tm_map(AmnestyCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
AmnestyCorpus <- tm_map(AmnestyCorpus, removeWords, stopwords("english"))

## Final corpus
tdmAmnesty <- TermDocumentMatrix(AmnestyCorpus)