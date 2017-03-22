library(shiny)
library(ggplot2)
library(ggmap)
library(leaflet)

shinyServer(function(input, output) {
  
  artcoord <- read.table('artemisia_californica_occurrances.txt', 
                         header = T,
                         sep = ",")
  
  names(artcoord)[3:4] <- c("lat", "long")
  
  fires = read.table('optimusprimefires.csv', 
                     header = T,
                     sep = ",")
  
  #Linh Anh trying to overlay PRISM data
  #r <- raster("prism_data_CA_1995")
  #pal <- colorNumeric(c("blue", "red"), values(r),
  #na.color = "transparent")
  
  output$main_map<-renderLeaflet({
    current_file = input$file
    #cf<-paste0('prism_data_CA_',input$file,'.grd')
    #artcoord2<-filter(artcoord, year == as.numeric(input$file))
    r <- raster(current_file)
    if (input$file == "prism_data_CA_2005.grd"){
      artcoord2<-filter(artcoord, year == 2005)
    }else{
      artcoord2<-filter(artcoord, year == 1995)
    }
    pal <- colorNumeric(c("white", "blue"), values(r),
                        na.color = "transparent")
    leaflet(options = leafletOptions(minZoom = 5, maxZoom = 7)) %>%
      setView(lng = -118, lat = 36, zoom = 5) %>%
      addTiles() %>%
      addRasterImage(r, colors = pal, opacity = 0.7) %>%
      addLegend(pal = pal, values = values(r),
                title = "Precip") %>% addCircles(data = artcoord2, color = 'green') %>%
    addCircles(data = fires, group = "Fires", color = 'red') %>%
      # Layers control
      addLayersControl(
        overlayGroups = c('Sage', 'Fires'),
        options = layersControlOptions(collapsed = FALSE))
    
  })
})