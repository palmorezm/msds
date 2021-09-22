
# MS Analytics Capstone
# Merging Script with HAI Estimates
# Dataset: rpp_msa_11yr.csv, cainc1_msa_11yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(tidyverse)

# Data Source 1
# Regional Price Parities by MSA from 2008 - 2019
# Extraction
rpp <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/rpp_msa_11yr.csv")) 
rpp <- rpp[4:nrow(rpp),]
colnames(rpp) <- rpp[1,]
rpp <- rpp[-1,]
# Tidying
mrpp <- rpp %>% 
  gather(key, value, -GeoFips, -GeoName, -LineCode, -Description) 
rpp.allitems <- subset(mrpp, LineCode==1)
rpp.goods <- subset(mrpp, LineCode==2)  
rpp.rents <- subset(mrpp, LineCode==3) 
rpp.services <- subset(mrpp, LineCode==4)  
mrpp <- rbind(rpp.allitems, rpp.goods, rpp.rents, rpp.services)
# Determine the presence of and deal with missing Values
sum(is.na(mrpp)) # 0
which(is.na(mrpp))
mrpp[which(is.na(mrpp)),] # Displays all NA's (if there are any)
# There are no missing values in this data set 

# Data Source 2 
# Income, Population, & Per Capita Income by MSA from 2008 to 2019
# Extraction
cainc1 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/cainc1_msa_11yr.csv")) 
cainc1 <- cainc1[4:nrow(cainc1),]
colnames(cainc1) <- cainc1[1,]
cainc1 <- cainc1[-1,]
# Tidying
minc <- cainc1 %>% 
  gather(year, value, -GeoFips, 
         -GeoName, -LineCode, -Description) 
minc.personalincome <- subset(minc, LineCode==1)
minc.population <- subset(minc, LineCode==2)  
minc.percapitaincome<- subset(minc, LineCode==3) 
minc <- rbind(minc.personalincome, minc.population, minc.percapitaincome)
# Cleaning
# Determine the presence of and deal with missing Values
sum(is.na(minc)) # 0
which(is.na(minc))
minc[which(is.na(minc)),] # None are missing

# Merge with Data Type Conversions
merged <- merge(minc, mrpp, by = "GeoFips")
merged[c("LineCode.x","year","LineCode.y","key","value.y")] <- sapply(merged[c("LineCode.x","year","LineCode.y","key","value.y")], as.numeric)

# NAR Traditional HAI Estimate for 2019
merged %>% 
  filter(LineCode.x == 3) %>% 
  mutate(RelAf = (value.x / value.y)/1000) %>% 
  filter(LineCode.y == 1) %>%
  arrange(desc(RelAf)) %>% 
  filter(year == 2019 & key == 2019)


