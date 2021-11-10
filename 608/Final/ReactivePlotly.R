
# DATA 608
# Reactive Plotly CDC Example 2

library(shiny)
library(plotly)
library(dplyr)
library(tidyr)

data <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)




ui <- fluidPage(
  titlePanel("Crude Mortality Rates"),
  h4("A Comparison of States' Causes of Death to National Averages"),
  h5("Note: Some states did not report data for every cause and year"),
  fluidRow(
    column(12, 
      selectizeInput(
             inputId = "State", 
             label = "Select State:", 
             choices = unique(data$State), 
             selected = "NY", 
             multiple = F),
      selectizeInput(
          inputId = "Cause", 
          label = "Select Cause of Death:", 
          choices = unique(data$ICD.Chapter), 
          selected = "Pregnancy, childbirth and the puerperium", 
          multiple = F)
      ), 
  fluidRow(
    column(6, 
           plotlyOutput(outputId = "p", 
                        height = "600px", 
                        width = "800px")), 
    column(6,  
           plotlyOutput(outputId = "b", 
                            height = "600px", 
                            width = "800px"))
    ),
  hr(), 
  helpText("Data Source: CDC WONDER system, at
https://wonder.cdc.gov/ucd-icd10.htm") 
  )
)

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    data %>% 
      group_by(Year, ICD.Chapter) %>% 
      mutate(National_Average = as.numeric(mean(Crude.Rate)), 
             Difference = Crude.Rate - National_Average, 
             Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
      filter(State == input$State & ICD.Chapter == input$Cause) %>% ungroup() %>% 
      plot_ly(., x = ~Year, y = ~Crude.Rate, type = 'scatter', mode='lines', name = "State") %>% 
      add_trace(y = ~National_Average, name = "National", connectgaps = TRUE) %>% 
      layout(title = "Change in Crude Mortality Rate",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Crude Mortality Rate (per 100,000)"), 
             legend = list(orientation = 'h', x = 0.35, y = 1.019))
    
  })
  output$b <- renderPlotly({
    data %>% 
      group_by(Year, ICD.Chapter) %>% 
      mutate(National_Average = as.numeric(mean(Crude.Rate)), 
             Difference = as.numeric(Crude.Rate - National_Average),
             LTNA = ifelse(Difference <0, Difference, NA),
             GTNA = ifelse(Difference >=0, Difference, NA),
             Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
      filter(State == input$State & ICD.Chapter == input$Cause) %>% 
      ungroup() %>%
      plot_ly(.,  
              x = ~Year, 
              y = ~GTNA, 
              type = 'bar', 
              marker = list(
                color = 'red'
              ), 
              name = "Above National Average") %>% 
      add_bars(x = ~Year,
               y = ~LTNA,
               base = 0,
               marker = list(
                 color = 'blue'
               ),
               name = 'Below National Average'
      ) %>%
      layout(title = "Difference in Crude Rate by State",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Difference (per 100,000)"),
             legend = list(x = .2, y = 1.019, orientation = "h"))

  })
  output$c <- renderPlotly({
    subplot(output$p, output$b) %>% 
                        layout(title = 'Side By Side Subplots')
  })
}

shinyApp(ui, server)







