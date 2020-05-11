function(input, output){
  Zip =  data$Zipcode
  output$density <- renderPlotly({
    data %>%
    ggplot(.,aes(label = Zip)) +
    geom_point(aes(density, Percent.Population)) +
    ggtitle('Density and Covid-19') +
    ylab('Percent Tested Population Positive') +
    xlab('Density(ppsm)')  
  })
  output$demographics <- renderPlotly({
    #fit <- reactive({lm(data[x] ~ data[y])})
    data %>%
      ggplot(.,aes(label = Zip)) +
    geom_point(aes_string(x=input$x, y=input$y)) +
    ggtitle('Demographics and Covid-19') #+
    #abline(fit())  
  })
      
    pal <- colorNumeric(
      palette = "Reds",
      domain = char_zips@data$Percent.Population,
      na.color = 'transparent')
    labels <- 
      paste0(
        "Zip Code: ",
        char_zips@data$GEOID10, "<br/>",
        "Percent Positive: ",
        char_zips@data$Percent.Population) %>%
      lapply(htmltools::HTML)
  output$map <- renderLeaflet({
    char_zips %>% 
      leaflet %>% 
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal(Percent.Population),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(weight = 2,
                                               color = "#666",
                                               dashArray = "",
                                               fillOpacity = 0.7,
                                               bringToFront = TRUE),
                  label = labels) %>%
      addLegend(pal = pal, 
                values = ~Percent.Population, 
                opacity = 0.7, 
                title = htmltools::HTML("Percent Positive <br> 
                                    For Covid-19 <br> 
                                    by Zip Code"),
                position = "bottomright")
      })
  pal2 <- colorNumeric(
    palette = "Greens",
    domain = char_zips@data$Median.Household.Income,
    na.color = 'transparent')
  labels2 <- 
    paste0(
      "Zip Code: ",
      char_zips@data$GEOID10, "<br/>",
      "Median Household Income: ",
      char_zips@data$Median.Household.Income) %>%
    lapply(htmltools::HTML)
  output$map2 <- renderLeaflet({
    char_zips %>% 
      leaflet %>% 
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal2(Median.Household.Income),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(weight = 2,
                                               color = "#666",
                                               dashArray = "",
                                               fillOpacity = 0.7,
                                               bringToFront = TRUE),
                  label = labels2) %>%
      addLegend(pal = pal2, 
                values = ~Median.Household.Income, 
                opacity = 0.7, 
                title = htmltools::HTML("Median Household Income <br> 
                                      by Zip Code"),
                position = "bottomright")
  })
  pal3 <- colorNumeric(
    palette = "Blues",
    domain = char_zips@data$Percent_Crowded,
    na.color = 'transparent')
  labels3 <- 
    paste0(
      "Zip Code: ",
      char_zips@data$GEOID10, "<br/>",
      "Percent Living in Crowded Housing: ",
      char_zips@data$Percent_Crowded) %>%
    lapply(htmltools::HTML)
  output$map3 <- renderLeaflet({
    char_zips %>% 
      leaflet %>% 
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal3(Percent_Crowded),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(weight = 2,
                                               color = "#666",
                                               dashArray = "",
                                               fillOpacity = 0.7,
                                               bringToFront = TRUE),
                  label = labels3) %>%
      addLegend(pal = pal3, 
                values = ~Percent_Crowded, 
                opacity = 0.7, 
                title = htmltools::HTML("Percent Living <br>
                                      in Crowded Housing <br> 
                                      by Zip Code"),
                position = "bottomright")
  })
  output$cor1 <- renderText({
    z = cor(data$Percent.Population, data$Median.Household.Income)
    paste0(c('Correlation Coefficient for Household Income:', z))
  })
  output$cor2 <- renderText({
    z = cor(data$Percent.Population, data$Percent_College)
    paste0(c('Correlation Coefficient for Education:', z))
  })
  output$cor3 <- renderText({
    z = cor(data$Percent.Population, data$Percent_Crowded)
    paste0(c('Correlation Coefficient for Crowded Housing', z))
  })
}