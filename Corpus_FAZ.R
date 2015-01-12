# FAZ Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/FAZ_tweets.rda")

FAZ.df <- twListToDF(FAZ_tweets)

## Build the corpus, and specify the source to be character vectors 
FAZCorpus <- Corpus(VectorSource(FAZ.df$text))

## Make it work with the new tm package
FAZCorpus <- tm_map(FAZCorpus,
                     content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                     mc.cores=1)

## Convert to lower case
FAZCorpus <- tm_map(FAZCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
FAZCorpus <- tm_map(FAZCorpus, content_transformer(removePunctuation))

## Remove numbers
FAZCorpus <- tm_map(FAZCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
FAZCorpus <- tm_map(FAZCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
FAZCorpus <- tm_map(FAZCorpus, removeWords, 
                    c(stopwords("german"), "für", "über"))
FAZCorpus <- tm_map(FAZCorpus, removeWords, 
                    stopwords("english"))

## Final corpus
tdmFAZ <- TermDocumentMatrix(FAZCorpus)