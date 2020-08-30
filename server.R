#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(quantmod)
#library(TTR)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    optionInput <- reactive (
        {
            if (input$showEnd)
            {
                a <- as.numeric(tail(signal,1))
                if (a == 1) "Signal of the End Date: Buy"
                else if (a == -1) "Signal of the End Date: Sell"
                else if (is.na(a)) "Signal of the End Date: Hold"
            }
            else
                ""
        }
    )

    output$stockPlot <- 
            renderPlot({

                start <- as.Date(input$dates[1])
                end <- as.Date(input$dates[2])
                ticker <- input$symbol
                s <- getSymbols(ticker, src = "yahoo", auto.assign = F, from = start, to = end)
                data <- s[,4]
                sma <- SMA(Cl(data), n=50)
                macd <- MACD(data, nFast=12, nSlow=26, nSig=50, maType=SMA, percent = FALSE)
                signal <- Lag(ifelse(macd$macd < macd$signal, -1, 1))
                chartSeries(data, name = "Strategy Chart Series", theme = chartTheme('white'),
                            TA=c(addVo(), addBBands(), addMACD(signal=50)))
            })
    
    output$result <- 
        renderText ({ optionInput() })
})
