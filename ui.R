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
        library(grid),
        library(Rgraphviz),
        library(qdapTools),
        library(qdapRegex),
        library(magrittr),
        library(wordcloud),
        library(RColorBrewer),
        library(ggplot2),
        library(RCurl),
        library(bitops),
        library(qdap),
        library(googleVis)))

shinyUI(navbarPage("Twitter Text Mining",
                   
                   #tags$head(includeScript("ga-rewetm.js")),


############################### ~~~~~~~~1~~~~~~~~ ##############################                   

## NAVTAB 1 - Wordcloud and Word-Letter Ratio Plot

        tabPanel("Words",
        
                 sidebarLayout(
                                  
                         sidebarPanel(
                                            
                                 radioButtons("plotType", "Plot type",
                                              c("Scatter"="p", "Line"="l")
                                            )
                                    ),
                         
                         mainPanel(
                                 
                                 tabsetPanel(
                                         
                                         tabPanel("Wordcloud",
                                                  
                                                  plotOutput("wordPlot")),
                                         
                                         
                                         tabPanel("Word-Letter Ratio",
                                                  
                                                  plotOutput("ratioPlot"))
                                )
                                 
                        )
                )
        ),

############################### ~~~~~~~~2~~~~~~~~ ##############################

## NAVTAB 2 - Associaltion Plot

        tabPanel("Association Plot",
                 
                 verticalLayout(
                         
                         wellPanel(
                                 
                         sliderInput("n", "Number of points", 10, 200,
                                     value = 50, step = 10)
                         ),
                                 
                         
                         plotOutput("assocPlot")
                         
                 )
        ),
 
############################### ~~~~~~~~3~~~~~~~~ ##############################

## NAVTAB 3 - Cluster Dendrogram
        
        tabPanel("Cluster Dendrogram",
                 
                 sidebarLayout(
                         
                         sidebarPanel(
                                 
                                 sliderInput("n", "Number of points", 10, 200,
                                             value = 50, step = 10)
                         ),
                         
                         mainPanel(
                         
                                plotOutput("clusterPlot")
                         )
                         
                 )
        ),

############################### ~~~~~~~~4~~~~~~~~ ##############################

## NAVTAB 4 - Term Frequency Plot & Table

        tabPanel("Term Frequency",
                
                sidebarLayout(
                        
                        sidebarPanel(
                        
                                checkboxInput(inputId = "pageable", 
                                      label = "Pageable"),
                        
                        
                                conditionalPanel("input.pageable==true",
                                         numericInput(
                                                 inputId = "pagesize",
                                                 label = "Terms per page",
                                                 10))    
                
                                ),
                
                
                        mainPanel(
                        
                    
                                tabsetPanel(
                            
                            
                                        tabPanel("Chart",
                                     
                                     
                                                 plotOutput("freqPlot")),
                                
                            
                            
                                        tabPanel("Table",
                        
                                     
                                                 htmlOutput("mgvisTable"))
                                
                                )
                        
                        )
                
                )
        
        ),

############################### ~~~~~~~~A~~~~~~~~ ##############################

## About
       
        tabPanel("About",
                fluidRow(
                        column(1,
                               p("")),
                        column(10,
                               includeMarkdown("expl.md")),
                        column(1,
                               p(""))
                        )
                )
        )
)