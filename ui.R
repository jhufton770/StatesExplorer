#ui.R
#ShinyDemo
library(datasets)
library(shiny)
library(ggplot2)
library(markdown)


#Initialize a list of data item names from the data sets for the UI elements to use.
dsNames <- c("State", "Region", "Population", "Income", "Illiteracy",
                "LifeExpectancy", "MurderRate", "HSGraduationRate",
                "DaysFrost", "Area")

regionNames <- c("Northeast", "North Central", "South", "West")

shinyUI(
fluidPage(
    
    titlePanel("U.S. States Explorer"),
    
    sidebarPanel(
        selectInput('x', 'X', dsNames[c(1,2)]),
        selectInput('y', 'Y', dsNames[-1], dsNames[[3]]),
        
        conditionalPanel(
            condition = "input.x == 'State' ",
            selectInput('color', 'Color By', c('None', dsNames[-1]), 'None')
            ),
        
        conditionalPanel(
            condition = "input.x == 'State' ",
            radioButtons("dataSort", "Sort by Y:",
                         c("No Sort" = "none",
                           "Ascending" = "asc",
                           "Descending" = "desc"))
            )

    ),
    
    mainPanel(
        tabsetPanel(
            tabPanel("Data Plot", plotOutput('plot') ),
            tabPanel("Instructions", includeMarkdown("Instructions.md")),
            tabPanel("About this Dataset", includeMarkdown("DatasetInfo.md"))
            )  
    )
) 
)