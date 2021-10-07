
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
            Crude_Rate = Crude_Mortality / Population * 100000) %>% 
  arrange(desc(Crude_Rate))

ui <- fluidPage(
  selectizeInput(
    inputId = "Cause", 
    label = "Select Cause of Death", 
    choices = unique(df$ICD.Chapter), 
    selected = "Neoplasms", 
    multiple = F
    ),
    plotlyOutput(outputId = "p", height = "800px", width = "1000px")
  )

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    df %>% 
      filter(ICD.Chapter == input$Cause) %>%
      arrange(desc(Crude_Rate)) %>% 
      plot_ly(., 
              x = ~Crude_Rate,
              y = ~reorder(State, Crude_Rate), 
              text = ~round(Crude_Rate, 0), 
              textposition = 'auto', 
              marker = list(color = 'rgb(150, 217, 250)',
                            line = list(color = 'rgb(2,38,100)', width = 1.25))) %>% 
      layout(title = "Crude Mortality Rate by State",
             xaxis = list(title = "Crude Rate (Per 100,000)"),
             yaxis = list(title = "State"))
    
  })
}

shinyApp(ui, server)

df %>% 
  filter(ICD.Chapter == "Neoplasms") %>%
  arrange(desc(Crude_Rate)) %>% 
  plot_ly(., 
          x = ~Crude_Rate,
          y = ~reorder(State, Crude_Rate), 
          text = ~round(Crude_Rate, 0), 
          textposition = 'auto', 
          marker = list(color = 'rgb(150, 217, 250)',
                        line = list(color = 'rgb(2,38,100)', width = 1.25))) %>% 
  layout(title = "Crude Mortality Rate by State",
               xaxis = list(title = "Crude Rate (Per 100,000)"),
               yaxis = list(title = "State"))







