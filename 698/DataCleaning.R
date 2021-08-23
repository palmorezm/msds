
# MS Analytics Capstone
# Data Cleaning
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)

# Real Personal Income (RPI)
# Extraction
rpi <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/rpis_10yr.csv")) 
rpi <- rpi[4:nrow(rpi),]
colnames(rpi) <- rpi[1,]
rpi <- rpi[-1,]
View(rpi)

# Tidying
melted <- rpi %>% 
  gather(key, value, -GeoFips, -GeoName, -LineCode, -Description) 
rpi.percapita <- subset(melted, LineCode==2)  
rpi.income <- subset(melted, LineCode==1)
combined <- rbind(rpi.income, rpi.percapita)
View(combined)


