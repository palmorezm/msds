
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: ACSDT5Y2019.B25077_data_with_overlays_2021-09-13T152535.csv
# Source: US Census Bureau
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)


# Regional Price Parities by MSA from 2008 - 2019
# Extraction
medhval <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ACSDT5Y2019.B25077_data_with_overlays_2021-09-13T152535.csv", 
  skip = 1)) 

colnames(medhval) <- c("GEOID", "GeoName", "MedianValue", "MOE")
View(medhval)

# Tidying
# Do we need any further tidying at this time?

# Determine the presence of and deal with missing Values
sum(is.na(medhval)) # 0
which(is.na(medhval))
medhval[which(is.na(medhval)),] # Displays all NA's (if there are any)
# There are no missing values in this data set 