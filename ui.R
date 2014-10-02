library(shiny)
library(rCharts)

shinyUI(fluidPage(
  
  tags$head(tags$script(src = "https://code.highcharts.com/highcharts.js"),
            tags$script(src = "https://code.highcharts.com/highcharts-more.js"),
            tags$script(src = "https://code.highcharts.com/modules/exporting.js"),
            tags$script(src = "https://code.highcharts.com/modules/heatmap.js")
            ),
            
  titlePanel("Interactive Highcharts Heat Map in Shiny"),

  tabsetPanel(
    tabPanel("Highcharts Heat Map",
      showOutput("heatmap","highcharts")
    ),
    
    tabPanel("About",
      p("This is not really an app, but rather a quick demonstration how to use Highcharts Heat Maps in R Shiny.
         It uses the ", 
        a(href='http://rcharts.io','rCharts'), " package and the ",
        a(href='http://www.highcharts.com/demo/heatmap','http://www.highcharts.com/demo/heatmap'), 
        "example.")
    )
  )
))