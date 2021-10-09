
# DATA 608 Documentation
# Helper Chunks


library(shiny)
library(plotly)
library(dplyr)
library(tidyr)

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
fig1 <- data %>% 
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

fig2 <- data %>% 
  group_by(Year, ICD.Chapter) %>% 
  mutate(National_Average = as.numeric(mean(Crude.Rate)), 
         Difference = as.numeric(Crude.Rate - National_Average),
         LTNA = ifelse(Difference <0, Difference, NA),
         GTNA = ifelse(Difference >=0, Difference, NA),
         Time = as.Date(ISOdate(Year, 12, 31)) ) %>% 
  filter(State == "MI" & ICD.Chapter == "Neoplasms") %>% 
  ungroup() %>%
  plot_ly(.,  
          x = ~Year, 
          y = ~GTNA, 
          type = 'bar', 
          marker = list(
            color = 'blue'
          ), 
          name = "Above National Average") %>% 
  add_bars(x = ~Year,
           y = ~LTNA,
           base = 0,
           marker = list(
             color = 'red'
           ),
           name = 'Below National Average'
  )


subplot(fig1, fig2)


data$Crude.Rate[which(data$Crude.Rate >= 0)]
which(data$Crude.Rate >= 0)
