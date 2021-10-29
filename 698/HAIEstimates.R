
# MS Analytics Capstone
# Housing Affordability Index
# Dataset: mixed
# Sources: BEA, BLS, U.S.Census (ACS)
# See Github: https://github.com/palmorezm/msds/tree/main/698

# Packages
library(dplyr)
library(tidyr)

# To get data
# Run Scripts In Order:
# GEOID_GEOFIPS.R --> RPP.R --> IPD.R
# Or use link from remote Git: 
# https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/compiled.csv

df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/compiled.csv")

# Change Data Types to Numeric
df[4:length(df)] <- sapply(df[4:length(df)], as.numeric)


# 384 Metros for 2019 Confirmed Reasonable HAI
df %>% 
  filter(year == 2018) %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>%
  arrange(desc(HAI))


# All metros 2010 through 2019
df_mapping <- df %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>%
  # filter(HAI >= 0 & HAI <= 500) %>% 
  arrange(desc(HAI)) 


# 384 Metros for 2019 New Baseline HAI 
# (minus average per person healthcare costs) - see link for details
# https://www.cnbc.com/2019/10/09/americans-spend-twice-as-much-on-health-care-today-as-in-the-1980s.html
df %>% 
  filter(year == 2018) %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100, 
         HHAI = ( (MEDINC - 5000) / QINC) * 100, 
         DIF = HAI - HHAI ) %>%
  arrange(desc(HAI)) %>% View()


  
# Average HAI using 10 year average HAI varaible
df %>% 
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

# RPP Adjusted Income (Real Wage) HAI
df %>% 
  filter(year == 2019) %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>% 
  mutate(ADJALL = (MEDINC - ((RPPALL / 100)* MEDINC)),
         AINCALL = MEDINC + ADJALL, 
         # Real Wage HAI:
         HAIRW = (AINCALL / QINC)*100) %>% 
  mutate(ADJRNT = (MEDINC - ((RPPRENT / 100)* MEDINC)), 
         AINCRNT = MEDINC + ADJRNT, 
         # Rent Adjusted HAI:
         HAIRNT = (AINCRNT / QINC)*100) %>% 
  mutate(ADJIPD = (AINCRNT + AINCALL / 2)*(IPD/100),
         # IPD Projected HAI:
         HAIIPD = (ADJIPD / QINC)*100) %>% 
  mutate(PMTRAW = MEDVAL * 0.99999 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINCRAW = PMTRAW * 4 * 12,
         HAIRAW = (MEDINC / QINCRAW) * 100)

