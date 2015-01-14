# Greenpeace Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/Greenpeace_tweets.rda")

Greenpeace.df <- twListToDF(Greenpeace_tweets)

## Build the corpus, and specify the source to be character vectors 
GreenpeaceCorpus <- Corpus(VectorSource(Greenpeace.df$text))

## Make it work with the new tm package
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus,
                    content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                    mc.cores=1)

## Convert to lower case
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, content_transformer(removePunctuation))

## Remove numbers
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, removeWords, 
                    c(stopwords("german"), "für", "über"))
GreenpeaceCorpus <- tm_map(GreenpeaceCorpus, removeWords, stopwords("english"))

## Final corpus
tdmGreenpeace <- TermDocumentMatrix(GreenpeaceCorpus)