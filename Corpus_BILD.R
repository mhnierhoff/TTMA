# BILD Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/BILD_tweets.rda")

BILD.df <- twListToDF(BILD_tweets)

## Build the corpus, and specify the source to be character vectors 
BILDCorpus <- Corpus(VectorSource(BILD.df$text))

## Make it work with the new tm package
BILDCorpus <- tm_map(BILDCorpus,
                     content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                     mc.cores=1)

## Convert to lower case
BILDCorpus <- tm_map(BILDCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
BILDCorpus <- tm_map(BILDCorpus, content_transformer(removePunctuation))

## Remove numbers
BILDCorpus <- tm_map(BILDCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
BILDCorpus <- tm_map(BILDCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
BILDCorpus <- tm_map(BILDCorpus, removeWords, stopwords("german"))
BILDCorpus <- tm_map(BILDCorpus, removeWords, stopwords("english"))

## Final corpus
tdmBILD <- TermDocumentMatrix(BILDCorpus)