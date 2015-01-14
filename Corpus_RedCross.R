# RedCross Corpus
library(twitteR)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars) 

load(file = "./dataset/RedCross_tweets.rda")

RedCross.df <- twListToDF(RedCross_tweets)

## Build the corpus, and specify the source to be character vectors 
RedCrossCorpus <- Corpus(VectorSource(RedCross.df$text))

## Make it work with the new tm package
RedCrossCorpus <- tm_map(RedCrossCorpus,
                    content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                    mc.cores=1)

## Convert to lower case
RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(tolower), lazy = TRUE)

## Remove punctuation
RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(removePunctuation))

## Remove numbers
RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(removeNumbers))

## Remove URLs
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(removeURL))

## Remove stopwords from corpus
RedCrossCorpus <- tm_map(RedCrossCorpus, removeWords, 
                    c(stopwords("german"), "für", "über"))
RedCrossCorpus <- tm_map(RedCrossCorpus, removeWords, 
                    stopwords("english"))

# Stem completion
# RedCrossCorpusCopy <- RedCrossCorpus
# RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(stemDocument))
# RedCrossCorpus <- tm_map(RedCrossCorpus, content_transformer(stemCompletion), 
#                    dictonary = RedCrossCorpusCopy, mc.cores=1)

## Final corpus
tdmRedCross <- TermDocumentMatrix(RedCrossCorpus)