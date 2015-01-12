# SZ Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/SZ_tweets.rda")

SZ.df <- twListToDF(SZ_tweets)

## Build the corpus, and specify the source to be character vectors 
SZCorpus <- Corpus(VectorSource(SZ.df$text))

## Make it work with the new tm package
SZCorpus <- tm_map(SZCorpus,
                     content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                     mc.cores=1)

## Convert to lower case
SZCorpus <- tm_map(SZCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
SZCorpus <- tm_map(SZCorpus, content_transformer(removePunctuation))

## Remove numbers
SZCorpus <- tm_map(SZCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
SZCorpus <- tm_map(SZCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
SZCorpus <- tm_map(SZCorpus, removeWords, stopwords("german"))
SZCorpus <- tm_map(SZCorpus, removeWords, stopwords("english"))

## Final corpus
tdmSZ <- TermDocumentMatrix(SZCorpus)