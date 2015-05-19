#server.R
#ShinyDemo
library(datasets)
library(shiny)
library(ggplot2)
library(plyr)

#Prepare the state and region data sets.  This should run only once.
data(state)
dataset <- data.frame(state.abb, as.factor(state.region), state.x77)
names(dataset) <- c("State", "Region", "Population", "Income", "Illiteracy",
                    "LifeExpectancy", "MurderRate", "HSGraduationRate",
                    "DaysFrost", "Area")
regionDS <- ddply(dataset, .(Region), summarise, 
                    Population=sum(Population), 
                    Income=mean(Income),
                    Illiteracy=mean(Illiteracy),
                    LifeExpectancy=mean(LifeExpectancy),
                    MurderRate=mean(MurderRate),
                    HSGraduationRate=mean(HSGraduationRate),
                    DaysFrost=mean(DaysFrost),
                    Area=sum(Area))
                    
pdataset = data.frame()

shinyServer(
function(input, output) {

    #By using the outputs of the Y and X axis selectors and the dataSort radio
    #buttons to control the way the plot is rendered, the renderPlot command 
    #is automatically reactive.
    output$plot <- renderPlot({

            #Check to see if one of the sort radio buttons is set.  If so, sort
            #the state data set for display
            if (input$dataSort == 'asc') {
                pdataset <- dataset[order(dataset[match(input$y,names(dataset))]),]
                pdataset$State <- factor(pdataset$State, levels = pdataset$State)
            } else if (input$dataSort == 'desc') {
                pdataset <- dataset[order(-dataset[match(input$y,names(dataset))]),]
                pdataset$State <- factor(pdataset$State, levels = pdataset$State)
            } else {
                pdataset <- dataset
            }

        
        p <- NULL
        
        #Select the appropriate base plot based on the X-axis data item
        if (input$x == "State") {
            p <- ggplot(pdataset, aes_string(x=input$x, y=input$y)) +
                geom_bar(stat='identity')
        } else if (input$x == "Region") {
            p <- ggplot(regionDS, aes_string(x=input$x, y=input$y, fill="Region")) +
                geom_bar(stat='identity') + scale_fill_brewer(palette="Spectral")
        }
       
        #If Color By is selected and the X-axis data item is State, add
        #a plot command to color the plot by the selected Color By data item
        if ((input$color != 'None') & (input$x != "Region")) {
            p <- p + aes_string(fill=input$color)
        } 
         
        #Finally, add the appropriate Y-axis legend based on the selected Y-axis
        #data item
        if (input$y == "Population") {
            p <- p + ylab("Population in Thousands")
        } else if (input$y == "Illiteracy") {
            p <- p + ylab("Illiteracy as % of Population")
        } else if (input$y == "Income") {
            p <- p + ylab("Per Capita Income in US Dollars (1974)")
        } else if (input$y == "LifeExpectancy") {
            p <- p + ylab("Life Expectancy in Years")
        } else if (input$y == "MurderRate") {
            p <- p + ylab("Murder and Non-Negligent Manslaughter Rate per 100,000 Population")
        } else if (input$y == "HSGraduationRate") {
            p <- p + ylab("Percent High School Graduates")
        } else if (input$y == "DaysFrost") {
            p <- p + ylab("Mean Number of Days with Minimum Temps Below Freezing")
        } else if (input$y == "Area") {
            p <- p + ylab("Land Area in Square Miles")
        }
        
        print(p)
        
    }, height=700)
    
}

)
