library(shiny)
library(DT)
dataset <- read.csv("data/dataset.csv")
# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Fast Food Restaurants Popular Menu Nutritional Facts"),
  
  fluidRow(
      column(4,
      # Input: Select Fast Food chain ----
      selectInput("restaurant", "Choose a Fast Food Restaurant:",
                  c("All", unique(as.character(dataset$Fast.Food.Restaurant))))),
      
      column(4,
      # Input: Select Menu Item ----
      selectInput("item", "Choose Menu Item:",
                  c("All", unique(as.character(dataset$Item))))),
    
    
# Create a new row for the table.
fluidRow(
  DT::dataTableOutput("table")
)))

# Server logic ----

server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- dataset
    if (input$restaurant != "All") {
      data <- dataset[dataset$Fast.Food.Restaurant == input$restaurant,]
    }
    if (input$item != "All") {
      data <- dataset[dataset$Item == input$item,]
    }
    
    data
  }))
  
}
    
shinyApp(ui, server)