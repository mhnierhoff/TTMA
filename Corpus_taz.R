# taz Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/taz_tweets.rda")

taz.df <- twListToDF(taz_tweets)

## Build the corpus, and specify the source to be character vectors 
tazCorpus <- Corpus(VectorSource(taz.df$text))

## Make it work with the new tm package
tazCorpus <- tm_map(tazCorpus,
                     content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                     mc.cores=1)

## Convert to lower case
tazCorpus <- tm_map(tazCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
tazCorpus <- tm_map(tazCorpus, content_transformer(removePunctuation))

## Remove numbers
tazCorpus <- tm_map(tazCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
tazCorpus <- tm_map(tazCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
tazCorpus <- tm_map(tazCorpus, removeWords, 
                     c(stopwords("german"), "für", "über"))
tazCorpus <- tm_map(tazCorpus, removeWords, stopwords("english"))

## Final corpus
tdmtaz <- TermDocumentMatrix(tazCorpus)