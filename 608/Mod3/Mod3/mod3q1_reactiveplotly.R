
# DATA 608
# Reactive Plotly CDC Example


library(shiny)
library(plotly)
library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)
df <- data %>%
  filter(Year == 2010) %>% 
  group_by(State, ICD.Chapter) %>% 
  summarise(Crude_Mortality = sum(Deaths), 
            Population = sum(Population), 
            Crude_Rate = Crude_Mortality / Population * 100000)

ui <- fluidPage(
  selectizeInput(
    inputId = "Cause of Death", 
    label = "Select Cause", 
    choices = unique(df$ICD.Chapter), 
    selected = "Neoplasms", 
    multiple = T
    ),
    plotlyOutput(outputId = "p", height = "1000px", width = "1000px")
  )

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    plot_ly(df, x = ~Crude_Rate, y = ~State, type = "bar") 
  })
}

shinyApp(ui, server)