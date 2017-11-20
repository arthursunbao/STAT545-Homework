library(shiny)
library(DT)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Welcome to Jason's self made BC Liquor Store Webapp powered by ShinyApp"),
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      #Let's have a logo for the page
      img(src = "bclogo.jpg", width = "90%"),
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      uiOutput("countryOutput")
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      ##Donwload Button Here
      downloadButton("downloadTable","Download The Current Table"),
      textOutput("number"),
      ## Use DT for interactive table
      DT::dataTableOutput("results")
    )
  )
  
)