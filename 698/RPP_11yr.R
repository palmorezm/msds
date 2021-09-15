
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpp_msa_11yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)


# Regional Price Parities by MSA from 2008 - 2019
# Extraction
rpp <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/rpp_msa_11yr.csv")) 
rpp <- rpp[4:nrow(rpp),]
colnames(rpp) <- rpp[1,]
rpp <- rpp[-1,]
View(rpp)

# Tidying
mrpp <- rpp %>% 
  gather(key, value, -GeoFips, -GeoName, -LineCode, -Description) 
rpp.allitems <- subset(mrpp, LineCode==1)
rpp.goods <- subset(mrpp, LineCode==2)  
rpp.rents <- subset(mrpp, LineCode==3) 
rpp.services <- subset(mrpp, LineCode==4)  
mrpp <- rbind(rpp.allitems, rpp.goods, rpp.rents, rpp.services)
View(mrpp)

# Determine the presence of and deal with missing Values
sum(is.na(mrpp)) # 28 
which(is.na(mrpp))
mrpp[which(is.na(mrpp)),] # Displays all NA's (if there are any)
# There are no missing values in this data set 

