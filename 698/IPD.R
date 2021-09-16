
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpis_10yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)

# Implicit Regional Price Deflator (IRPD - here referred to as simply IPD)
# As defined by BEA 
# The IRPD is a regional price index derived as the product of two terms: 
# the regional price parity and the U.S. PCE price index.
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

