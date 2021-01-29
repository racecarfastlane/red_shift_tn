shinyServer(function(input, output) {
    
    output$slider <- renderUI({
        
        if (input$mapview=="Demographics")
        {
            return( sliderInput("year_demo",
                                "Year",
                                min = 2000,
                                max = 2018,
                                value = 2000,
                                sep = ""))
        }
        
        if  (input$mapview=="Presidential Vote")
        {
            return(   sliderInput("year_pres",
                                  "Year",
                                  min = 2000,
                                  max = 2016,
                                  step = 4,
                                  value = 2000,
                                  sep = ""))        
        }    
    })

    output$mapTN <- renderPlotly({
        
    if (input$mapview=="Demographics")
    {
        
        data <- acs_data_tn %>%
            filter(year == input$year_demo)
        
        elb<-tn_base + 
            geom_polygon(data = data, aes(fill = white, text = sprintf('County: %s\nWhite: %s\nBlack: %s\nAsian: %s\nNative Hawaiian or Pacific Islander: %s\nFirst Nation: %s\nOther Race: %s'
                                                                                   , county, round(white, 2),round(black,2),round(asian,2),
                                                                                   round(`first.nation`,2),round(`native.hawaiian.or.pacific.islander`,2),
                                                                                   round(`other.race`,2))), color = "black") +
            labs(fill = "White Race \nper Capita") +
            geom_polygon(color = "black", fill = NA) +
            theme_bw() +
            ditch_the_axes
        
        elb<-elb +
            scale_fill_gradient2(midpoint = 70,low="darkblue",high="darkred",limits=c(39,100)) 
        
            
    }  
    if (input$mapview=="Presidential Vote") 
    {
        data <- county_pres_returns %>%
            filter(year == input$year_pres)
        
        elb<-tn_base + 
            geom_polygon(data = data, aes(fill = rep_vote_pcnt, 
                                                              text = tooltip))+
            labs(fill = "Republican \nVote Share") +
            geom_polygon(color = "black", fill = NA) +
            theme_bw() +
            ditch_the_axes
        
        elb<-elb +
            scale_fill_gradient2(midpoint = 50,low="darkblue",high="darkred",limits=c(29,86))
        
    }
        ggplotly(elb,tooltip = "text")

    })
    
    output$demo_line <- renderPlotly({
        
           data_line <- acs_data_tn_np %>%
                filter(county==input$county)
           
            line <- ggplot(data = data_line,aes(x=year,y=percap,color=race,group=race))+
                    geom_line(size=1.25)+
                    xlab("Year")+
                    ylab("Race per Capita")+
                    labs(color = "Race")
                
            
            ggplotly(line,width=1000,height=350)
        
    })

})
