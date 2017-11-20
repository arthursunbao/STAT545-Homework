library(shiny)
library(tidyverse)
library(DT)

# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
  bcl <- read_csv("bcl-data.csv")
  
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })  
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }  
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
  })
  
  #Number of rows we have for the result
  output$number <- renderText({
    c("Number of ",nrow(filtered()),"results for you")
  })
  
  #Used DT package to render interactive table
  output$results <- DT::renderDataTable({
    filtered()
  })
  
  ##Let's do some work and download the file here
  output$downloadTable <- downloadHandler(
    filename = function(){
      "downloadTable.csv"
    },
    content = function(file){
      write.table(x = filtered(), file = file, quote = FALSE, sep = ",", row.names = FALSE)
    }
  )
  
  
  
}