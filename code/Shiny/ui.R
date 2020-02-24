#### Module2 
### ui.R

rm(list = ls())

require(shiny)
require(shinythemes)
library(ggplot2)
library(leaflet)
require(data.table)



Location = fread("./Top10gpsdf.csv")
Influence_Users = fread("./influential_user.csv")
Star_Count = fread("./top10_star_count.csv")

Pizza_Chain_Names = unique(Location$name)
# State_list = unique(Location$state)
#City_list = unique(Location$city)

City_List = c("Madison","A")
State_List = unique(Location$state)
OH = unique(Location[Location$state == "OH",]$city)
ON = unique(Location[Location$state == "ON",]$city)
AZ = unique(Location[Location$state == "AZ",]$city)
AB = unique(Location[Location$state == "AB",]$city)
PA = unique(Location[Location$state == "PA",]$city)
NC = unique(Location[Location$state == "NC",]$city)
SC = unique(Location[Location$state == "SC",]$city)
NV = unique(Location[Location$state == "NV",]$city)
WI = unique(Location[Location$state == "WI",]$city)
IL = unique(Location[Location$state == "IL",]$city)


  
  
  
ui = fluidPage(theme = shinytheme("darkly"),
  titlePanel("Top 10 Pizza Chain Advice"),
               sidebarLayout(      
                 sidebarPanel(
                   selectInput("pizza", "Pizza Chain:", 
                               choices=Pizza_Chain_Names),
                   selectInput("state", "State:", 
                               choices = State_List),
                   conditionalPanel("input.state == 'OH'",
                                    selectInput("OH", "City:", 
                                                choices = OH)
                   ),
                   conditionalPanel("input.state == 'ON'",
                                    selectInput("ON", "City:", 
                                                choices = ON)
                   ),
                   conditionalPanel("input.state == 'AZ'",
                                    selectInput("AZ", "City:", 
                                                choices = AZ)
                   ),
                   conditionalPanel("input.state == 'AB'",
                                    selectInput("AB", "City:", 
                                                choices = AB)
                   ),
                   conditionalPanel("input.state == 'PA'",
                                    selectInput("PA", "City:", 
                                                choices = PA)
                   ),
                   conditionalPanel("input.state == 'NC'",
                                    selectInput("NC", "City:", 
                                                choices = NC)
                   ),
                   conditionalPanel("input.state == 'SC'",
                                    selectInput("SC", "City:", 
                                                choices = SC)
                   ),
                   conditionalPanel("input.state == 'NV'",
                                    selectInput("NV", "City:", 
                                                choices = NV)
                   ),
                   conditionalPanel("input.state == 'WI'",
                                    selectInput("WI", "City:", 
                                                choices = WI)
                   ),
                   conditionalPanel("input.state == 'IL'",
                                    selectInput("IL", "City:", 
                                                choices = IL)
                   ),
                   hr(),
                   helpText("Choose a Pizza chain you like!"),
                   hr(),
                   helpText("Thanks for using it!"),
                   helpText("If there exist any problems, feel free to contact us!"),
                   helpText("E-mail: jmiao24@wisc.edu"),
                   img(src = "Yelp_Logo.svg.png",height=100,width= 175)
                 ),
                   mainPanel(tabsetPanel( tabPanel("Basic information", img(src = "pizzastar.png",height=250,width= 750),
                                                   h4("Star Distribution for Review"),plotOutput("stars_map")),
                     tabPanel("SWOT Table", h3("Business Suggestion for Pizza Hut"),img(src = "Pizza_HUT-page-001.jpg",height=400,width=550),
                              h4("'Our focus on digital efforts is clearly to make certain we are appealing to younger audiences, which will be the future of the overall business.—— Steve Richie'")),
                                       tabPanel("Interaction Map", textOutput("robust"), leafletOutput("map")),
                                                tabPanel("Highlighted Users Reviews", 
                                                         htmlOutput("comment"),img(src = "User_Weight.jpg",
                                                                                   height=400,width=650),
                                                         h3("We suggest these business owner to do these things to attract highlighted user!"),
                                                         h4("1. E-mail coupons and VIP fellowship"),
                                                         h4("2. Give a lot off discount or even free for meal"))
             )
         )
      )
)
  

