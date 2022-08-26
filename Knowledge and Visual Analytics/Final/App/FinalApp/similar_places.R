
library(dplyr)
source("C:/Users/Zachary Palmore/GitHub/msds/Knowledge and Visual Analytics/Final/App/FinalApp/df_source.R") # Might take a minute 

df.fin %>%
  filter(HAI >= 110)


df.fin %>% 
  filter(GeoName == "Janesville-Beloit, WI (Metropolitan Statistical Area)") 

df.fin %>% 
  filter(HAI >= 142 & HAIRW >= 152) %>% View()

df.fin %>% 
  filter(HAI >= 132, 
         year == 2019) %>% View()

df.fin %>% 
  filter(HAI >= 100) %>% View() 
