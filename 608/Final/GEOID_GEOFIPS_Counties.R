
# MS Analytics Capstone
# Restring GEOID to GEOFIPS (All Counties)
# Dataset: Median Home Values
# Sources: U.S.Census (ACS)
# data.census.gov

# Packages
library(dplyr)
library(tidyr)
library(stringr)

#### Start with Median Home Values ####
mhv <- data.frame(read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/mhv.csv"))

# Slice to extract the GEOFIPS from GEOID for Abilene, TX metro
geostring <- as.character(mhv$GEOID)
GeoFips <- str_extract(geostring, "\\d{5}$")
mhv$GeoFips <- GeoFips

df.mhv <- as.data.frame(mhv) %>% 
  rename(County = GeoFips)
df.mhv2019 <- df.mhv %>% 
  filter(Year == 2019)
  
