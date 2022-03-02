#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(GEOquery)
library(leaflet)
library(ggmap)
# library(shinyjs)


# Function to format metadata
get_metadata <- function(metadata){
    meta <- lapply(unname(metadata), function(x){
        if(length(x) > 1){
            x <- paste0(x, collapse = "; ")
            } else{
                x
                } 
        x
    })
    df <- data.frame("A" = names(metadata), "B" = unlist(meta))
    }
    

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Dissease list
  input_df <- reactive({
    df <- read.csv("data/diseases_and_geo_data_spreadsheet_update.csv")
  })
 
  disease <- reactive({
    dis <- input_df()[, 1]
  })  
  
  # Read data
    gse_d <- eventReactive(input$Submit, {
      ds <- input$dataset
      df <- input_df()
      gse_id <- df[df[, 1] == ds, ][, 2]
      print(gse_id)
     
      withProgress(message = 'Patience, searching data . . .',{
          gse <- getGEO(gse_id,GSEMatrix=FALSE)
          gse_m <- getGEO(gse_id,GSEMatrix=TRUE)
        })
      return(list(gse, gse_m))
        })
    
    
    
    # Format data
    meta_df <- eventReactive(input$Submit, {
      m_data <- Meta(gse_d()[[1]])
      df <- get_metadata(m_data)
      print(head(df))
      return(df)
    })
    
    
    
    
    # Platforms used
    pltf_df <- eventReactive(input$Submit,{
      gsmplatforms <- lapply(GSMList(gse_d()[[1]]),function(x) {Meta(x)$platform_id})
      print(head(gsmplatforms))
      p_df <- data.frame("Sample" = names(gsmplatforms), "Platform" = unname(unlist(gsmplatforms)))
    })
    
    # raw data
    raw_df <- eventReactive(input$Submit,{
      gsmlist = Filter(function(gsm) {Meta(gsm)$platform_id=='GPL96'},GSMList(gse_d()))
      length(gsmlist)
      
      # get the probeset ordering
      probesets <- Table(GPLList(gse_d()[[1]])[[1]])$ID
      # make the data matrix from the VALUE columns from each GSM
      # being careful to match the order of the probesets in the platform
      # with those in the GSMs
      data.matrix <- do.call('cbind',lapply(gsmlist,function(x) 
      {tab <- Table(x)
      mymatch <- match(probesets,tab$ID_REF)
      return(tab$VALUE[mymatch])
      }))
      data.matrix <- apply(data.matrix,2,function(x) {as.numeric(as.character(x))})
      data.matrix <- log2(data.matrix)
      raw_data <- data.matrix[1:5,]
    })



    
    # Display metadata
    output$meta <- renderDataTable({
        if(is.null(meta_df()) || (length(meta_df())==0)){ 
            return(NULL)
            }else{meta_df()}
    })
    
    
    # map
    loc_map <- eventReactive(input$Submit, {
      register_google(key = "AIzaSyBS_BZ3WYSh97TIKMV5b-RneTwqsFS1w_Q")
      df <- meta_df()
      locs <- df[df$A =='contact_institute', 2]
      c <- geocode(locs)
      m <- leaflet() %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
        addMarkers(lng=c$lon, lat=c$lat, popup=locs)
      m
    })
    
    output$location <- renderLeaflet({
      if(is.null(loc_map()) || (length(loc_map())==0)){ 
        return(NULL)
      }else{ 
        loc_map()}
    })
    
    
    # Display platform
    output$platfrm <- renderDataTable({
      if(is.null(pltf_df()) || (length(pltf_df())==0)){ 
        return(NULL)
      }else{ 
        df <- pData(phenoData(gse_d()[[2]][[1]]))[, c(1,6,8)]}
    })
    
    
    # Display rawdata
    output$raw <- renderDataTable({
      if(is.null(gse_d()) || (length(gse_d())==0)){ 
        return(NULL)
      }else{ df <- pData(phenoData(gse_d()[[2]][[1]]))}
    })
    

})





