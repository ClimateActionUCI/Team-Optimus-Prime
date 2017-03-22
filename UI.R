library(shiny)
library(leaflet)

shinyUI(bootstrapPage(
  
  sidebarLayout(      
    
    sidebarPanel(
      selectInput(inputId = "file", label="Year", choices = list("1995" = "prism_data_CA_1995.grd", "2005" = "prism_data_CA_2005.grd"), selected = NULL, multiple = FALSE, selectize = TRUE)
    ),
    
    mainPanel(
      leafletOutput(outputId = "main_map") 
      
    )
    
  )
))