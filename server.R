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
        library(BH),
        library(qdap)))

source("globalCorpus.R")

shinyServer(function(input, output, session) {
        
        
############################### ~~~~~~~~1~~~~~~~~ ##############################
        
## NAVTAB 1 - Wordcloud and Word-Letter Ratio Plot

getTdm <- reactive({
        
        getTermMatrix(input$tdmwc)
        
        
})

## Tabset 1

wordPlotInput <- function() {
        m <- as.matrix(getTdm())
        word.freq <- sort(rowSums(m), decreasing = TRUE)
        wordcloud(words = names(word.freq), 
                  freq = word.freq, 
                  min.freq = input$minfreqWord,
                  max.words=input$maxfreqWord,
                  random.order = FALSE,
                  vfont=c("sans serif","bold"),
                  colors=brewer.pal(7, "Dark2"))
}

output$wordPlot <- renderPlot({                        
        
        ##########    Adding a progress bar  ##########
        
        ## Create a Progress object
        
        progress <- shiny::Progress$new()
        
        on.exit(progress$close())
        
        progress$set(message = "Creating Plot", value = 0)
        
        n <- 5
        
        for (i in 1:n) {
                # Each time through the loop, add another row of data. This is
                # a stand-in for a long-running computation.
                
                # Increment the progress bar, and update the detail text.
                progress$inc(1/n, detail = paste("Doing Part", i))
                
                
                wordPlotInput()
                
                # Pause for 0.1 seconds to simulate a long computation.
                Sys.sleep(0.1)
        }
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
        
## NAVTAB 2 - Cluster Dendrogram

getTdmcd <- reactive({
        
        getTermMatrix(input$tdmcd)
        
})


clusterPlotInput <- function() {
        
        tdm2 <- removeSparseTerms(getTdmcd(), sparse = 0.95)
        m2 <- as.matrix(tdm2)
        # Cluster terms
        distMatrix <- dist(scale(m2))
        fit <- hclust(distMatrix, method = "ward.D")
        
        plot(fit)
        rect.hclust(fit, k = input$clusterNumber)
}

output$clusterPlot <- renderPlot({
        
        ##########    Adding a progress bar  ##########
        
        ## Create a Progress object
        
        progress <- shiny::Progress$new()
        
        on.exit(progress$close())
        
        progress$set(message = "Creating Plot", value = 0)
        
        n <- 5
        
        for (i in 1:n) {
                # Each time through the loop, add another row of data. This is
                # a stand-in for a long-running computation.
                
                # Increment the progress bar, and update the detail text.
                progress$inc(1/n, detail = paste("Doing Part", i))
                
                clusterPlotInput()
                
                # Pause for 0.1 seconds to simulate a long computation.
                Sys.sleep(0.1)
        }
        
})
        
############################### ~~~~~~~~3~~~~~~~~ ##############################
        
## NAVTAB 3 - Association Plot

getTdmap <- reactive({
        
        getTermMatrix(input$tdmap)
        
})

assocPlotInput <- function() {
        
        freq.terms <- findFreqTerms(getTdmap(), lowfreq = input$lowfreqAssoc)
        
        plot(getTdmap(), term = freq.terms, 
             corThreshold = 0.08, 
             weighting = TRUE)
}

output$assocPlot <- renderPlot({
        
        ##########    Adding a progress bar  ##########
        
        ## Create a Progress object
        
        progress <- shiny::Progress$new()
        
        on.exit(progress$close())
        
        progress$set(message = "Creating Plot", value = 0)
        
        n <- 5
        
        for (i in 1:n) {
                # Each time through the loop, add another row of data. This is
                # a stand-in for a long-running computation.
                
                # Increment the progress bar, and update the detail text.
                progress$inc(1/n, detail = paste("Doing Part", i))
                
                assocPlotInput()
                
                # Pause for 0.1 seconds to simulate a long computation.
                Sys.sleep(0.1)
        }
})

############################### ~~~~~~~~4~~~~~~~~ ##############################
        
## NAVTAB 4 - Term Frequency Plot & Table

getTdmtf <- reactive({
        
        getTermMatrix(input$tdmtf)
        
})

## Tabset Tab 1

freqPlotInput <- function() {
        
        freq.terms <- findFreqTerms(getTdmtf(), lowfreq = input$freqNumber)
        term.freq <- rowSums(as.matrix(getTdmtf()))
        term.freq <- subset(term.freq, term.freq >= input$freqNumber)
        freq.df <- data.frame(term = names(term.freq), freq = term.freq)
        freq.df <- transform(freq.df, term = reorder(term, freq))
        freqPlot <- ggplot(freq.df, aes(x = term, y = freq, fill = freq)) 
        freqPlot + geom_bar(width = 0.7, stat = "identity") +
                labs(title = "Most Frequent Terms") +
                labs(y = "Terms") + 
                labs(x = "Count") + 
                coord_flip() +
                theme_bw()
}

output$freqPlot <- renderPlot({
        
        freqPlotInput()
        
})

## Tabset Tab 1

freqTableInput <- function() {
        
        freq.terms <- findFreqTerms(getTdmtf(), lowfreq = input$freqNumber)
        term.freq <- rowSums(as.matrix(getTdmtf()))
        term.freq <- subset(term.freq, term.freq >= input$freqNumber)
        freq.df <- data.frame(term = names(term.freq), freq = term.freq)
        freq.df <- transform(freq.df, term = reorder(term, freq)) 
}

output$freqTable <- renderDataTable({
        
        freqTableInput()
        
})
})