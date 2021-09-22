
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: ACSDT5Y2019.B25077_data_with_overlays_2021-09-13T152535.csv
# Source: US Census Bureau
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)

# Import CSVs 
h1 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2019.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h1 <- h1 %>% 
  mutate(year = 2019)
h2 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2018.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h2 <- h2 %>% 
  mutate(year = 2018)
h3 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2017.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h3 <- h3 %>% 
  mutate(year = 2017)
h4 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2016.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h4 <- h4 %>% 
  mutate(year = 2016)
h5 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2015.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h5 <- h5 %>% 
  mutate(year = 2015)
h6 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2014.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h6 <- h6 %>% 
  mutate(year = 2014)
h7 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2013.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h7 <- h7 %>% 
  mutate(year = 2013)
h8 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2012.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h8 <- h8 %>% 
  mutate(year = 2012)
h9 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2011.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h9 <- h9 %>% 
  mutate(year = 2011)
h10 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2010.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1))
h10 <- h10 %>% 
  mutate(year = 2010)


# Combine
mhv <- rbind(h10, h9, h8, h7, h6, h5, h4, h3, h2, h1)
colnames(mhv) <- c("GEOID", "GeoName", "MedianValue", "MOE", "Year")
View(mhv)

