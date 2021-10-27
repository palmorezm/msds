
# MS Analytics Capstone
# Merge All Data Sources
# Dataset: Median Home Values, Median Income, RPP, IRPD (IPD)
# Sources: U.S.Census (ACS)
# data.census.gov


# Packages
library(dplyr)
library(tidyr)

# Cleaning RPP
merge(merged.df, mrpp, by = "GeoFips" ) %>% 
  arrange(desc(year.x)) %>%
  View()


View(c(merged.df, mrpp))

cbind(merged.df, mrpp)


merge(merged.df, rppall, by = 'GeoFips') %>% View()

merged.df %>% 
  filter(year == 2019) %>% dim()
  merge(., rppall, by="GeoFips") %>% View()
