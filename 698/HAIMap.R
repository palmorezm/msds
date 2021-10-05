
# MS Analytics Capstone
# Mapping Housing Affordability 
# Dataset: mixed
# Sources: BEA and U.S.Census (ACS)
# https://apps.bea.gov/iTable/
# data.census.gov

# Packages
library(dplyr)
library(tidyr)
library(rjson)
library(tigris)


counties <- rjson::fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")


# Data comes from "HAIEstimates.R" and "GEOID_GEOFIPS.R" 
df <- df_mapping %>% 
  filter(year == "2019")


csa <- tigris::combined_statistical_areas()


