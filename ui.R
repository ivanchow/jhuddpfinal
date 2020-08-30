#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Stock Price Plot"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("symbol", h3("Stock Ticker Symbol"), 
                             value = "TSLA"),
            dateRangeInput("dates", h3("Date range"), start = "2018-01-01", end = "2020-08-28"), 
            checkboxInput("showEnd", "Show Buy/Sell/Hold Signal on the End Date", value=FALSE),
            submitButton("Submit"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("stockPlot"),
            
            h4(textOutput("result"))
        )
    )
))
