
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
df <- df %>% 
  dplyr::select(-X)

# 384 Metros for selected year Confirmed Reasonable HAI
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
  arrange(desc(HAI)) 


  
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
  arrange(desc(AVGHAI))

# All HAI Estimates
df.fin <- df %>% 
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
  mutate(PMTRAW = MEDVAL * 0.99 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINCRAW = PMTRAW * 4 * 12,
         # Raw HAI at 20% Down Payment:
         HAIRAW = (MEDINC / QINCRAW) * 100) %>% 
  mutate(HHSIZE = 2.53, 
         DEBTMV = (20000/HHSIZE),
         DEBTED = 9664*HHSIZE, 
         DEBTIL = 9609*HHSIZE,
         DEBTCC = 3500*HHSIZE, 
         DEBTOC = 10000*HHSIZE, 
         DEBTS = DEBTMV + DEBTED + DEBTIL + DEBTCC + DEBTOC, 
         AQINC30 =  PMT * (100/30) * 12,
         AINCDBT = ((AINCRNT + AINCALL / 2) - DEBTS), 
         # HAI Adjusted for Average American Household Debts
         HAIDBT = AINCDBT / AQINC30) %>% 
  mutate(PMT3DP = MEDVAL * 0.97 * (IR / 12)/(1 - (1/(1 + IR/12)^360)),
         AQINC60 = PMT * (100/60)*12,
         # Lenient Lending Practices HAI 
         #(60% of monthly income on mortgage is acceptable with 3% DP)
         HAILEN = (AINCALL / AQINC60)*100) 


df.sample500 <- sample_n(df.fin, 500, replace = T)
hist(df.sample500$HAILEN)

library(ggplot2)
library(tidyr)
# Histogram of HAI values
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", 
                  "HAIRAW", "HAIDBT", "HAILEN")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .05, fill = key), binwidth = 5)
# Jitter plot of HAI values by year
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>% 
  ggplot(aes(year, value)) + 
  geom_jitter(aes(col = key, alpha = .15)) 
# Increase in all NAR HAI over 10 years
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  ggplot(aes(year, value)) + 
  geom_point(aes(col = key, alpha = .15)) + 
  geom_smooth(col = "black")
# Change in personal income and HAI value per year
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  ggplot(aes(year, value)) + 
  geom_point(aes(x = PERINC, col = PERINC, alpha = .15)) 
# Change in personal income and HAI over the population 
df.fin %>% 
  filter(year == 2019) %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  ggplot(aes(value, POP, col = PERINC)) + 
  geom_point(aes(x = PERINC, alpha = .15)) + 
  geom_smooth(aes(x = PERINC), 
              method="loess", col = "black") 
# Change in personal income, HAI, and population across all HAI's
df.fin %>%  
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>%
  ggplot(aes(value, PERINC, col = PERINC)) + 
  geom_point(aes(x = PERINC, alpha = .15)) + 
  geom_smooth(aes(x = value), 
              method="loess", col = "black") + 
  facet_wrap(~key, scales = "free")  
# Needs Review
df.fin %>%  
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>%
  ggplot(aes(value, PERINC, col = PERINC)) + 
  geom_point(aes(x = value, alpha = .15)) + 
  geom_smooth(aes(x = value), 
              method="loess", col = "black") + 
  facet_wrap(~key, scales = "free")  
# Histogram without HAIDBT
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", 
                  "HAIRAW", "HAILEN")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .50, col = key, fill=I("white")), binwidth = 5)
# Histogram with only HAIDBT
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAIDBT")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .50, col = key, fill=I("white")), binwidth = .1)

# Real Income and HAI's
df.fin %>%  
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAILEN")) %>%
  ggplot(aes(value, AINCALL)) + 
  geom_point(aes(x = value, alpha = .15, col = key)) + 
  geom_vline(xintercept = 100, lty = "dotted", col = "black") + 
  geom_smooth(aes(x = value), 
              method="loess", col = "black") + 
  facet_wrap(~key, scales = "fixed", shrink = F) 



# Notes:
# 1 - Make the same scales on axes where possible
# 2 - Denote the different HAI keys by color 


# New Notes:
# Tabulate total number of Metro Areas above and below threshold under different HAI measures
# For example: Under HAILEN, how many metro's were given above 100 HAI? How many under 100? 


