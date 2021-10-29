
# MS Analytics Capstone
# Housing Affordability Index
# Dataset: mixed
# Sources: BEA and U.S.Census (ACS)
# https://apps.bea.gov/iTable/
# data.census.gov

# Packages
library(dplyr)
library(tidyr)

# To get data
# Run Scripts In Order:
# GEOID_GEOFIPS.R --> RPP.R --> IPD.R
# Or use link from remote Git: 
# https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/compiled.csv

merged.df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/compiled.csv")
merged.df %>% View()

# 384 Metros for 2019 Confirmed Reasonable HAI
merged.df %>% 
  filter(year == 2018) %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>%
  arrange(desc(HAI)) %>% View()


# All metros 2010 through 2019
df_mapping <- merged.df %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>%
  # filter(HAI >= 0 & HAI <= 500) %>% 
  arrange(desc(HAI)) 


# 384 Metros for 2019 New Baseline HAI 
# (minus average per person healthcare costs) - see link for details
# https://www.cnbc.com/2019/10/09/americans-spend-twice-as-much-on-health-care-today-as-in-the-1980s.html
merged.df %>% 
  filter(year == 2018) %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100, 
         HHAI = ( (MEDINC - 5000) / QINC) * 100, 
         DIF = HAI - HHAI ) %>%
  arrange(desc(HAI)) %>% View()


  
# Average HAI using 10 year average HAI varaible
merged.df %>% 
  filter(GeoName == "Harrisburg-Carlisle, PA (Metropolitan Statistical Area)") %>%
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100, 
         HHAI = ( (MEDINC - 5000) / QINC) * 100, 
         DIF = HAI - HHAI, 
         AVGHAI =  median((MEDINC / QINC) * 100), 
         NEWHAI = mean((MEDINC / QINC)/.001 )
        ) %>% 
  arrange(desc(AVGHAI)) %>% View()



