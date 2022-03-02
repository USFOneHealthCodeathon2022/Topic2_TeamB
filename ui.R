#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    (navbarPage("RDGDEx: Rare Disease Genome Data Extractor",
                position = c("fixed-top"),
                fluid=TRUE)),
    tags$head(
        includeCSS("www/styles.css")
    ),

    # Application title
    titlePanel("Extract and Visualize Genomic Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput('dataset', "Choose Disease",
                        c("Please one or more" = '', disease), multiple = TRUE),
    
    uiOutput('Choose_Disease'),
    
    sliderInput("bins",
                "Number of studies:",
                min = 1,
                max = 10,
                value =4),
    
    wellPanel(
        fluidRow(
            column(5, 
                   h5("Sort based on"),
                   list(
                       checkboxInput("checkbox1", label = "Sample size", value = FALSE),    
                       checkboxInput("checkbox2", label = "Citation", value = FALSE))
                   ),
        
            column(5,
        h5("Filter out"),
        list(
            checkboxInput("checkbox4", label = "Asians", value = FALSE),    
            checkboxInput("checkbox5", label = "Europeans", value = FALSE),
            checkboxInput("checkbox6", label = "Africans", value = FALSE),
            checkboxInput("checkbox7", label = "Hispanic and Latino", value = FALSE))),
        
        fluidRow(
            column(6,
                   h5("Platform"),
                   checkboxInput("checkbox8", label = "Microarray", value = FALSE),
                   checkboxInput("checkbox9", label = "RNAseq", value = FALSE), 
                   )
        )
        
        )),
    
    
    actionButton("Submit", label = "Search", icon = icon("search")),
    
    downloadButton('downloadData1', 'Download')),
    

        # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(id = "Tabs",
                    tabPanel("Meta-data", dataTableOutput("meta"), icon = icon("table")),
                    tabPanel("Locate", leafletOutput("location")),
                    tabPanel("Platforms", dataTableOutput("platfrm"), icon = icon("table")),
                    tabPanel("Phenotype data",dataTableOutput("raw")),
                    tabPanel("Supplementary file", dataTableOutput("full"))
        ))
    )
))
