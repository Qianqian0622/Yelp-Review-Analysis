#### Module2 
### ui.R


require(shiny)
require(shinythemes)
library(ggplot2)
library(leaflet)
require(data.table)



Location = fread("./Top10gpsdf.csv")
Influence_Users = fread("./influential_user.csv")
Star_Count = fread("./top10_star_count.csv")

  




function(input, output, session) {
  state = reactive({
    return(as.character(input$state))
  })
  Change_Lines = function(String){
    Final = rep()
    for (i in 1:length(String)){
      Final = paste(Final, String[i], sep="<br/>")
    }
      return(HTML(Final))
  }
  
  
  city = reactive({
    if(input$state == "OH"){
    return(as.character(input$OH))
      }
    else if(input$state == "ON"){
      return(as.character(input$ON))
    }
    else if(input$state == "AZ"){
      return(as.character(input$AZ))
    }
    else if(input$state == "AB"){
      return(as.character(input$AB))
    }
    else if(input$state == "PA"){
      return(as.character(input$PA))
    }
    else if(input$state == "NC"){
      return(as.character(input$NC))
    }
    else if(input$state == "SC"){
      return(as.character(input$SC))
    }else if(input$state == "NV"){
      return(as.character(input$NV))
    }else if(input$state == "WI"){
      return(as.character(input$WI))
    }
    else if(input$state == "QC"){
      return(as.character(input$QC))
    }
    else if(input$state == "OH"){
      return(as.character(input$IL))
    }
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
  
  output$robust = renderText({
    if (identical(Final()$name,character(0))){
      return("There is no pizza chain you choose in this place !")
    }else{
      return("See the Map !")
    }
  })

  
  output$map <- renderLeaflet({
    leaflet(Final()) %>% addProviderTiles(providers$Esri.NatGeoWorldMap)%>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(~longitude, ~latitude, popup= ~name)
    })

  
  output$comment <- renderUI({
    if (identical(Influence_Users[Influence_Users$Pizza == pizza(),]$text, character(0))){
      return("No highlighted user have commented this pizza chain !")
    }else{
    Change_Lines(Influence_Users[Influence_Users$Pizza == pizza(),]$text)
    }
    # Change_Lines(a)
    # return(Change_Lines(a))
  })
  
  Sub_Count = reactive({
    Sub_Table = Star_Count[Star_Count$name == pizza(),]
    colnames(Sub_Table)[3]=  "Star_Counts"
    Sub_Table$Percentage = Sub_Table$Star_Counts/sum(Sub_Table$Star_Counts)
    return(Sub_Table)
  })


  
  output$stars_map = renderPlot({
    ggplot(data = Sub_Count(), aes(x = stars, y = Percentage,fill = stars))+ 
      geom_bar(stat="identity")+ 
      scale_fill_gradient(low= "#040204",high= "#DA694F")+
      ggtitle(pizza())+ 
      theme_light()
    
  })

}

# 
# a = Influence_Users[Influence_Users$Pizza == "Boston Pizza",]$text
# 
# class(Influence_Users[Influence_Users$Pizza == "Boston Pizza",]$text)
# 
# 
# 
# Change_Lines(a)




