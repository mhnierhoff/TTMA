################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

## Text Mining of Twitter Tweets                      

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
        library(qdap)))

shinyUI(navbarPage("Twitter Text Mining", inverse = F,
                   
                   #tags$head(includeScript("ga-rewetm.js")),


############################### ~~~~~~~~1~~~~~~~~ ##############################                   

## NAVTAB 1 - Wordcloud and Word-Letter Ratio Plot

        tabPanel("Words",
        
                 sidebarLayout(
                                  
                         sidebarPanel(
                                 radioButtons(inputId = "tdmwc",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", 
                                                          "PETA", 
                                                          "Amnesty", 
                                                          "Greenpeace"),
                                              selected = "RedCross"),
                                 
                                 tags$hr(),
                                 
                                 sliderInput("minfreqWord", 
                                             label = "Minimum frequency of words:",
                                             min = 5, max = 25, value = 10),
                                 
                         width = 3),
                         
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
                                 radioButtons(inputId = "tdmap",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", 
                                                          "PETA", 
                                                          "Amnesty", 
                                                          "Greenpeace"),
                                              selected = "RedCross"),
                                 
                                 tags$hr(),
                                 
                                 sliderInput("lowfreqAssoc", 
                                             label = "Number of frequent terms:",
                                             min = 10, max = 25, value = 15),
                                 
                                 width = 3),
                         
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
                                 radioButtons(inputId = "tdmcd",
                                              label = "Select Twitter account:",
                                              choices = c("RedCross", 
                                                          "PETA", 
                                                          "Amnesty", 
                                                          "Greenpeace"),
                                              selected = "RedCross"),
                                 
                                 tags$hr(),
                                 
                                 sliderInput("clusterNumber", 
                                             label = "Number of terms cluster:",
                                             min = 3, max = 10, value = 5),
                                 
                                 width = 3),
                         
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
                                radioButtons(inputId = "tdmtf",
                                             label = "Select Twitter account:",
                                             choices = c("RedCross", 
                                                         "PETA", 
                                                         "Amnesty", 
                                                         "Greenpeace"),
                                             selected = "RedCross"),
                                
                                tags$hr(),
                                
                                sliderInput("freqNumber", 
                                            label = "Number of terms cluster:",
                                            min = 10, max = 50, value = 25),
                                
                                width = 3),
                
                        mainPanel(
                        
                    
                                tabsetPanel(
                            
                            
                                        tabPanel("Chart",
                                     
                                     
                                                 plotOutput("freqPlot")),
                                
                            
                            
                                        tabPanel("Table",
                        
                                     
                                                 dataTableOutput("freqTable"))
                                
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