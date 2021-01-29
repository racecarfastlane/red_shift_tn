shinyUI(
    pageWithSidebar(

        # Application title
        titlePanel("Red Shift Tennessee"),

        sidebarPanel(width = 2,
        
            selectInput(
               "mapview",
               h4("Map View Options"),
               choices = map_choices,
               selected = map_choices[1]
                   ),
            
               h4("Year"),
               uiOutput("slider"),
    
               selectInput(
                   "county",
                   h4("County"),
                   choices = county_choices,
                   selected = county_choices[19]
               )),

        mainPanel(
        plotlyOutput("mapTN"),
        plotlyOutput("demo_line"),
        )
    )
)

      

            