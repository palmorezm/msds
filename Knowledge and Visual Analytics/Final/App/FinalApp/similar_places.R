
source("C:/Users/Zachary Palmore/GitHub/msds/Knowledge and Visual Analytics/Final/App/FinalApp/df_source.R") # Might take a minute 

df.fin %>%
  filter(HAI >= 110)


df.fin %>% 
  filter(GeoName == "Janesville-Beloit, WI (Metropolitan Statistical Area)") %>% View()

df.fin %>% 
  filter(HAI >= 142 & HAIRW >= 152) %>% View()

df.fin %>% 
  filter(HAI >= 132, 
         year == 2019) %>% View()

df.fin %>% 
  filter(HAI >= 100, 
         POP >= 500000, 
         year == 2019) %>% 
  dplyr::select(GeoName, year, POP, HAI, HAIRW, HAIRNT) %>% View() 
