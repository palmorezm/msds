
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
cores <- tigris::core_based_statistical_areas()
metro_areas <- cores %>% 
  filter(LSAD == "M1")
  
plot(metro_areas)

metros <- metro_areas$CBSAFP
metros$geometry <- metro_areas$geometry


metro_areas %>% 
  filter(GEOID == 33260)
metro_areas %>% 
  filter(GEOID == 19180)
metro_areas %>% 
  filter(GEOID == 19500)


plot(metro_areas$GEOID, col = df$HAI)
plot(metro_areas$geometry) # Produces map of metro areas 
plot(metro_areas$geometry, col = df$HAI) # Created "Rplot3" in Git

library(ggplot2)

df %>% 
  ggplot(aes(HAI, alpha = 0.5)) + geom_histogram(stat = "bin", binwidth = 10, fill='CadetBlue', color='white') + 
  geom_vline(xintercept = median(df$HAI), lty = "dotted", col = "black") + 
  geom_vline(xintercept = 100, lty = "dotdash", col = "orange") +
  theme_minimal() + theme(legend.position = "none") 


library(RColorBrewer)
my_colors <- brewer.pal(9, "Greens") 
my_colors <- colorRampPalette(my_colors)(18)

class_of_country <- cut(df$HAI, 18)
my_colors <- my_colors[as.numeric(class_of_country)]

# Make the plot
plot(metro_areas$geometry, col=my_colors)

summary(df$HAI)

df %>%
  top_frac(n = 0.2,wt = HAI) # Top 20% 

df %>% 
  top_frac(n = -0.2, wt = HAI) # Bottom 20% 


df %>% 
  top_frac(n = -0.1, wt = HAI) # Lowest 10%











