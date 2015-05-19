#ui.R
#ShinyDemo
library(datasets)
library(shiny)
library(ggplot2)
library(markdown)


#Initialize a list of data item names from the data sets for the UI elements to use.
#Names for the states data set
dsNames <- c("State", "Region", "Population", "Income", "Illiteracy",
                "LifeExpectancy", "MurderRate", "HSGraduationRate",
                "DaysFrost", "Area")

shinyUI(
fluidPage(
    
    titlePanel("U.S. States Explorer"),
    
    sidebarPanel(
        
        #Item selector for the X-axis data item
        selectInput('x', 'X', dsNames[c(1,2)]),
        #Item selector for the Y-axis data item
        selectInput('y', 'Y', dsNames[-1], dsNames[[3]]),
        
        #Conditional Panel to select the Color By data item, available only when
        #State is selected for the X-axis
        conditionalPanel(
            condition = "input.x == 'State' ",
            selectInput('color', 'Color By', c('None', dsNames[-1]), 'None')
            ),
        
        #Conditional Panel for the Sort By radio buttons, available only when
        #State is selected for the Y-axis
        conditionalPanel(
            condition = "input.x == 'State' ",
            radioButtons("dataSort", "Sort by Y:",
                         c("No Sort" = "none",
                           "Ascending" = "asc",
                           "Descending" = "desc"))
            )

    ),
    
    mainPanel(
        #Three Tabs on the Main Panel for Plot, Instructions and Data Set Info
        tabsetPanel(
            tabPanel("Data Plot", plotOutput('plot') ),
            tabPanel("Instructions", includeMarkdown("Instructions.md")),
            tabPanel("About this Dataset", includeMarkdown("DatasetInfo.md"))
            )  
    )
) 
)