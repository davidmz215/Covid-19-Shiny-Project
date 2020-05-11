library(shinydashboard)
shinyUI(dashboardPage(skin = "blue",
                      dashboardHeader(
                        title = "Covid-19 NYC Demographic Analysis",
                        titleWidth = 230
                      ), 
                      
                      dashboardSidebar(
                        sidebarUserPanel("Author: David Zask"),
                        
                        sidebarMenu(
                          menuItem("Introduction",
                            tabName = 'intro', icon = icon('band-aid')),
                          
                          menuItem("Interactive Covid-19 Tracker",
                                   tabName = 'graphs', icon = icon('ambulance')),
                          
                          menuItem("Map Visualization",
                                   tabName = "map", icon = icon("map")),
              
                          menuItem("Conclusion and Credits" , 
                                   tabName = "info", icon = icon("book")),
                          
                          menuItem("About Me", 
                                   tabName = "Me", icon = icon("address-card"))
                        )
                      ), 
                      dashboardBody(
                        tags$head(
                          tags$style(
                            HTML(
                              '.main-header .logo {
                                font-family: "Century Gothic", Century, "Century Gothic", Century;
                                font-weight: bold;
                                font-size: 14px;
                                                    }'
                            )
                          )
                        ),
                     tabItems(
                        tabItem(tabName = 'intro',
                            h2('Why is the Covid-19 Crisis in NY so Profound?'),
                            h3('Common Belief: New York has so many Covid-19 cases because it is a very dense city.'),
                            h4('However, when we try to relate the severity to density we do not find any correlation.'),
                            box(plotlyOutput('density'), width = 8),
                            box(h3('So what does influence Covid-19 infection rates?'),
                            h3('-Income'),
                            h3('-Education'),
                            h3('-Public Transit'),
                            h3('-housing'))
                        ),
                        tabItem(tabName = 'graphs', 
                              h2('Comparison of Covid-19 Data Based on Zipcode Demographics'),
                              fluidRow(
                                box(plotlyOutput('demographics'), width = 12),
                                box(h4('Choose which demographic features and what Covid-19 data you want to compare'),
                                       selectizeInput(inputId = 'x',
                                                      label = 'Select Demographic Parameter',
                                                      choices = c('Median Household Income'='Median.Household.Income', 'Percent Bachelors Degree or Higher' = 'Percent_College', 'Percent Taking Public Transit' = 'Percent_Public_Transit', 'Crowded Housing(Percent of population living in crowded housing)' = 'Percent_Crowded')),
                                       selectizeInput(inputId = 'y',
                                                      label = 'Select Covid-19 Statistic',
                                                      choices = c('Percent Tested Population Positve for Covid-19'='Percent.Population','Total Positive' ='Positive','Total Tests' = 'Total_Tests'))
                                      
                                    )
                                    )),
                         tabItem(tabName = 'map',
                            h2('Map of Coronavirus Data'),
                            fluidRow(
                              box(leafletOutput('map'), width = 12),
                              box(leafletOutput('map2'), width = 12),
                              box(leafletOutput('map3'), width = 12)
                              ))
                        
                              )
                     )
        ))
