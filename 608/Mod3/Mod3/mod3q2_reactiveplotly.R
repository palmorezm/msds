
# DATA 608
# Reactive Plotly CDC Example

# Question 2: 
# Often you are asked whether particular States are improving their mortality rates (per cause)
# faster than, or slower than, the national average. Create a visualization that lets your clients
# see this for themselves for one cause of death at the time. Keep in mind that the national
# average should be weighted by the national population.


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

data %>% 
  group_by(State, ICD.Chapter) %>% 
  summarise(Crude_Mortality = sum(Deaths), 
            Population = sum(Population), 
            Crude_Rate = Crude_Mortality / Population * 100000) %>% View()

df.national <- data %>% 
  group_by(Year, State, ICD.Chapter) %>%
  mutate(National_Average = mean(Crude.Rate)) 

df.state <- data %>% 
  group_by(State, Year, ICD.Chapter) %>% 
  summarise(Population = sum(Population), 
            Crude_Mortality = sum(Deaths), 
            Crude_Rate = Crude_Mortality / Population * 100000, 
            Crude.Rate = Crude.Rate) 

df.state$National_Average <- df.national$National_Average

data %>% 
  group_by(State, Year, ICD.Chapter) %>% 
  mutate(Population = sum(Population), 
         Crude_Mortality = sum(Deaths),
         Crude_Rate = Crude_Mortality / Population * 100000) %>% View()


df.state %>% 
  filter(State == "AL" & ICD.Chapter == "Neoplasms") %>% 
  plot_ly(., x = ~Year, y = ~Crude_Rate, type = 'scatter', mode='lines') %>% 
  add_trace(y = ~National_Average, name = "<b>No</b> Gaps", connectgaps = TRUE)

data %>% 
  group_by(Year, ICD.Chapter) %>% 
  mutate(National_Average = mean(Crude.Rate), 
         Difference = Crude.Rate - National_Average, 
         Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
  filter(State == "AL" & ICD.Chapter == "Neoplasms") %>% 
  ggplot(aes(x = Year, y = Crude.Rate)) + geom_line()


# Plotly line plot to show change in crude mortality rate over time (year)
data %>% 
  group_by(Year, ICD.Chapter) %>% 
  mutate(National_Average = as.numeric(mean(Crude.Rate)), 
         Difference = Crude.Rate - National_Average, 
         Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
  filter(State == "NY" & ICD.Chapter == "Neoplasms") %>% ungroup() %>% 
  plot_ly(., x = ~Year, y = ~Crude.Rate, type = 'scatter', mode='lines') %>% 
  add_trace(y = ~National_Average, name = "<b>No</b> Gaps", connectgaps = TRUE)

# Plotly bar chart of differences in Cause of Death from national average by year 
data %>% 
  group_by(Year, ICD.Chapter) %>% 
  mutate(National_Average = as.numeric(mean(Crude.Rate)), 
         Difference = Crude.Rate - National_Average, 
         Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
  filter(State == "NY" & ICD.Chapter == "Neoplasms") %>% ungroup() %>% 
  plot_ly(., x = ~Year, y = ~Difference, type = 'bar') 


ui <- fluidPage(
  selectizeInput(
    inputId = "Cause", 
    label = "Select Cause of Death", 
    choices = unique(data$ICD.Chapter), 
    selected = "Pregnancy, childbirth and the puerperium", 
    multiple = F
    ),
    plotlyOutput(outputId = "p", height = "800px", width = "1000px"), 
  
  selectizeInput(
    inputId = "State", 
    label = "Select State", 
    choices = unique(data$State), 
    selected = "NY", 
    multiple = T
  ), 
  plotlyOutput(outputId = "b", height = "800px", width = "1000px"),

  hr(), 
  helpText("Data Source: CDC WONDER system, at
https://wonder.cdc.gov/ucd-icd10.htm")
  )

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    data %>% 
      group_by(Year, ICD.Chapter) %>% 
      mutate(National_Average = as.numeric(mean(Crude.Rate)), 
             Difference = Crude.Rate - National_Average, 
             Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
      filter(State == input$State & ICD.Chapter == input$Cause) %>% ungroup() %>% 
      plot_ly(., x = ~Year, y = ~Crude.Rate, type = 'scatter', mode='lines') %>% 
      add_trace(y = ~National_Average, name = "<b>No</b> Gaps", connectgaps = TRUE) %>% 
      layout(title = "Title",
             xaxis = list(title = "X"),
             yaxis = list(title = "Y"))
    
  })
  output$b <- renderPlotly({
    data %>% 
      group_by(Year, ICD.Chapter) %>% 
      mutate(National_Average = as.numeric(mean(Crude.Rate)), 
             Difference = Crude.Rate - National_Average, 
             Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
      filter(State == input$State & ICD.Chapter == input$Cause) %>% 
      ungroup() %>% 
      plot_ly(., 
              x = ~Year, 
              y = ~Difference, 
              type = 'bar') %>%
      layout(title = "Title",
             xaxis = list(title = "X"),
             yaxis = list(title = "Y"))
    
  })
}

shinyApp(ui, server)







