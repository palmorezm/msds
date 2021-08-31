
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpis_10yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)

# # Regional Price Parities (RPP)
# Extraction
ipd <- data.frame(read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/ipd_10yr.csv"))
ipd <- ipd[4:nrow(ipd),] # 
colnames(ipd) <- ipd[1,]
ipd <- ipd[-1,]
View(ipd)

# Tidying
mipd <- ipd %>% 
  gather(., key, value, -GeoFips, -GeoName) 
View(mipd)

# Determine the presence of and deal with missing Values
sum(is.na(mipd)) # 20 
which(is.na(mipd))
mipd[15986,] # Displays the first selected NA
mipd[which(is.na(mipd)),] # Displays all NA's
na.omit(mrpi)

