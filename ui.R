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
        library(qdap),
        library(googleVis)))

shinyUI(navbarPage("Twitter Text Mining",
                   
                   #tags$head(includeScript("ga-rewetm.js")),


############################### ~~~~~~~~1~~~~~~~~ ##############################                   

## NAVTAB 1 - Wordcloud and Word-Letter Ratio Plot

        tabPanel("Words",
        
                 sidebarLayout(
                                  
                         sidebarPanel(
                                 radioButtons(inputId = "tdm",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", "Greenpeace", "Amnesty"),
                                              selected = "RedCross"),
                                 
                                 tags$hr(),
                                 
                                 sliderInput("minfreqWord", 
                                             label = "Minimum frequency of words:",
                                             min = 5, max = 25, value = 10)
                                 
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
                 
                 sidebarLayout(
                         
                         sidebarPanel(
                                 radioButtons(inputId = "tdm",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", "Greenpeace", "Amnesty"),
                                              selected = "RedCross"),
                                 
                                 tags$hr(),
                                 
                                 sliderInput("lowfreqAssoc", 
                                             label = "Number of frequent terms:",
                                             min = 10, max = 25, value = 15)
                                 
                         ),
                         
                         mainPanel(
                                 
                                 plotOutput("assocPlot")
                                 
                         )
                 )
        ),
 
############################### ~~~~~~~~3~~~~~~~~ ##############################

## NAVTAB 3 - Cluster Dendrogram
        
        tabPanel("Cluster Dendrogram",
                 
                 sidebarLayout(
                         
                         sidebarPanel(
                                 radioButtons(inputId = "tdm",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", "Greenpeace", "Amnesty"),
                                              selected = "RedCross")
                                                
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
                                radioButtons(inputId = "tdm",
                                             label = "Select Twitter account:",
                                             choices = c("RedCross", "Greenpeace", "Amnesty"),
                                             selected = "RedCross"),
                                
                        
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