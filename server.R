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

suppressPackageStartupMessages(c(
        library(graph),
        library(twitteR),
        library(NLP),
        library(tm),
        library(shinyIncubator),
        library(grid),
        library(pvclust),
        library(Rgraphviz),
        library(qdapTools),
        library(qdapRegex),
        library(magrittr),
        library(wordcloud),
        library(RColorBrewer),
        library(ggplot2),
        library(RCurl),
        library(bitops),
        library(plotly),
        library(qdap),
        library(googleVis)))


shinyServer(function(input, output, session) {

############################### ~~~~~~~~~~~~~~~~~ ##############################
        
## Getting the data 

        getTdm <- reactive({
                switch(input$tdm,
                       "Greenpeace" = tdmGreenpeace,
                       "Amnesty" = tdmAmnesty,
                       "RedCross" = tdmRedCross)
        })

############################### ~~~~~~~~~~~~~~~~~ ##############################

## Data computations

        #getFreqTerms <- reactive({
        #        switch(input$freqTerms,
        #               "Greenpeace" <- findFreqTerms(getTdm()),
        #               "Amnesty" <- findFreqTerms(getTdm()),
        #               "RedCross" <- findFreqTerms(getTdm()))
        #})
                
        myOptions <- reactive({
                list(
                        page=ifelse(input$pageable==TRUE,'enable','disable'),
                        pageSize=input$pagesize,
                        width=550
                )
        })
        
############################### ~~~~~~~~1~~~~~~~~ ##############################

## NAVTAB 1 - Wordcloud and Word-Letter Ratio Plot

        ## Tabset 1

        wordPlotInput <- function() {
                m <- as.matrix(getTdm())
                # calculate the frequency of words and sort it by frequency 
                word.freq <- sort(rowSums(m), decreasing = TRUE)
                wordcloud(words = names(word.freq), 
                          freq = word.freq, 
                          min.freq = input$minfreqWord,
                          random.order = FALSE, 
                          colors=brewer.pal(6, "Dark2"))
        }

        output$wordPlot <- renderPlot({                        
                
                wordPlotInput()

        })
        
        ## Tabset 2

        ratioPlotInput <- function() {
                
                words <- getTdm()  %>%
                         as.matrix %>%
                         colnames  %>%
                         (function(x) x[nchar(x) < 20])
                
                data.frame(nletters = nchar(words)) %>%
                        ggplot(aes(x = nletters)) +
                        geom_histogram(binwidth = 1) +
                        geom_vline(xintercept = mean(nchar(words)),
                                   color = "red", size = 1, alpha = 0.5) +
                        labs(title = "Most Frequent Terms") +
                        labs(y = "Number of Words") + 
                        labs(x = "Number of Letters") +
                        theme_bw()
                
        }
        
        output$ratioPlot <- renderPlot({
                
                ratioPlotInput()
        
        })

############################### ~~~~~~~~2~~~~~~~~ ##############################
        
## NAVTAB 2 - Association Plot

        assocPlotInput <- function() {
                
                freq.terms <- findFreqTerms(getTdm(), lowfreq = input$lowfreqAssoc)
                
                plot(getTdm(), term = freq.terms, 
                     corThreshold = 0.08, 
                     weighting = TRUE)
        }

        output$assocPlot <- renderPlot({
        
                assocPlotInput()

        })

############################### ~~~~~~~~3~~~~~~~~ ##############################

## NAVTAB 3 - Cluster Dendrogram

        clusterPlotInput <- function() {
                
                tdm2 <- removeSparseTerms(getTdm(), sparse = 0.95)
                m2 <- as.matrix(tdm2)
                # Cluster terms
                distMatrix <- dist(scale(m2))
                fit <- hclust(distMatrix, method = "ward.D")
                
                plot(fit)
                rect.hclust(fit, k = 4)
        }
        
        output$clusterPlot <- renderPlot({
                
                isolate({
                
                clusterPlotInput()
        
                })
        })

############################### ~~~~~~~~4~~~~~~~~ ##############################

## NAVTAB 4 - Term Frequency Plot & Table

        ## Tabset Tab 1
        output$freqPlot <- renderPlot({
                
                freq.terms <- findFreqTerms(getTdm(), lowfreq = 35)
                term.freq <- rowSums(as.matrix(getTdm()))
                term.freq <- subset(term.freq, term.freq >= 35)
        
                df <- data.frame(term = names(term.freq), freq = term.freq)
        
                df <- transform(df, term = reorder(term, freq))
        
                freqPlot <- ggplot(df, aes(x = term, y = freq, fill = freq)) 
        
                freqPlot + geom_bar(width = 0.7, stat = "identity") +
                labs(title = "Most Frequent Terms") +
                labs(y = "Terms") + 
                labs(x = "Count") + 
                coord_flip() +
                theme_bw()
        })

        ## Tabset Tab 1
        output$mgvisTable <- renderGvis({
                gvisTable(df,options=myOptions())         
        })


        
})