#### Module2 
### ui.R

rm(list = ls())

require(shiny)
require(shinythemes)
library(ggplot2)
library(leaflet)
require(data.table)



Location = fread("./Top10gpsdf.csv")

Pizza_Chain_Names = unique(Location$name)
# State_list = unique(Location$state)
#City_list = unique(Location$city)

City_List = c("Madison","A")
State_List = c("WI","D")


ui = fluidPage(titlePanel("Top 10 Pizza Chain Advice"),
               sidebarLayout(      
                 sidebarPanel(
                   selectInput("pizza", "Pizza Chain:", 
                               choices=Pizza_Chain_Names),
                   selectInput("state", "State:", 
                               choices = State_List),
                   selectInput("city", "City:", 
                               choices = City_List),
                   hr(),
                   helpText("Choose a Pizza chain you like!")
                 ),
                   mainPanel(tabsetPanel( tabPanel("SWOT Table", img(src = "Pizza_HUT-page-001.jpg")),
                                       tabPanel("Interaction Map", leafletOutput("map")),
                                                tabPanel("Table", tableOutput("table"))
             )
         )
      )
)
  




server = function(input, output, session) {
  state = reactive({
    return(as.character(input$state))
  })
  city = reactive({
    return(as.character(input$city))
  })
  pizza = reactive({
    return(as.character(input$pizza))
  })

  Final =  reactive({
      City_index = which(Location$city == city() & Location$state == state())
      City_Location = Location[City_index,]
      Final_Table = City_Location[City_Location$name == pizza(),]
      return(Final_Table)
    })



#   
#   output$table = Pizza_Location()
  
  output$map <- renderLeaflet({
    leaflet(Final()) %>% addProviderTiles(providers$Stamen.TonerLite)%>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(~longitude, ~latitude, popup= ~name)
    })
  output$img <- renderUI({
    tags$img(src = "/Users/michael/Google Drive/Courses/Stat628/Module3/Pizza_HUT-page-001.jpg")
  })

  }


shinyApp(ui = ui, server = server)




city = City_List
pizza = Pizza_Chain_Names[1]
state = State_List
