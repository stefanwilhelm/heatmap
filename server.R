library(shiny)
library(rCharts)
library(rjson)

# read in JSON data and convert to data frame
dat <- rjson::fromJSON(file="heatmap-data.json")
dat <- lapply(dat, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})
dat <- matrix(dat$data, ncol=3, byrow=TRUE)
colnames(dat) <- c("x","y","value")

shinyServer(function(input, output, session) {
  
  # Highcharts Heat Map
  output$heatmap <- renderChart2({
    map <- Highcharts$new()
    map$chart(zoomType = "x", type = 'heatmap')
    map$credits(text = "Created with rCharts and Highcharts", href = "http://rcharts.io")
    map$title(text='Sales per employee per weekday')

    map$series(name = 'Sales per employee',
         data = toJSONArray2(dat, json=FALSE),
         color = "#cccccc",
         dataLabels = list(
           enabled = TRUE,
           color = 'black',
           style = list(
              textShadow = 'none',
              HcTextStroke = NULL
           )
         ))
         
    map$xAxis(categories = c('Alexander', 'Marie', 'Maximilian', 'Sophia', 'Lukas', 
      'Maria', 'Leon', 'Anna', 'Tim', 'Laura'))

    map$yAxis(categories = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'),
        title=list(text = ""))
        
    map$addParams(colorAxis = 
      list(
          min = 0,
          minColor='#FFFFFF',
          maxColor='#7cb5ec'
      )
    )

    map$legend(align='right',
         layout='vertical',
         margin=0,
         verticalAlign='top',
         y=25,
         symbolHeight=320)
           
    # custom tooltip
    map$tooltip(formatter = "#! function() { return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
                    this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>'; } !#")

        
    # set width and height of the plot and attach it to the DOM
    map$addParams(height = 400, width=1000, dom="heatmap")
    
    # save heatmap as HTML page heatmap.html for debugging
    #map$save(destfile = 'heatmap.html')
    
    # print map
    print(map)
  })
})