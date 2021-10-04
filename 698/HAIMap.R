
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
library(plotly)


data <- fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")
data$features[[1]]

# Data comes from "HAIEstimates.R" and "GEOID_GEOFIPS.R" 
df <- df_mapping %>% 
  filter(year == "2019")

g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
fig <- plot_ly()
fig <- fig %>% 
  add_trace(type="choropleth", geojson=counties, locations=df$GeoFips, z=df$HAI, colorscale="Viridis",
            zmin=0, zmax=500, marker=list(line=list(width=0)))
fig <- fig %>% colorbar(title = "HAI")
fig <- fig %>% layout(
  title = "2016 US Unemployment by County"
)

fig <- fig %>% layout(
  geo = g
)

fig
