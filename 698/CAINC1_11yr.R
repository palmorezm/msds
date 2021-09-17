
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: cainc1_msa_11yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)


# Income, Population, & Per Capita Income by County from 1969 to 2019
# Extraction
cainc1 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/cainc1_msa_11yr.csv")) 
cainc1 <- cainc1[4:nrow(cainc1),]
colnames(cainc1) <- cainc1[1,]
cainc1 <- cainc1[-1,]
View(cainc1)

# Tidying
minc <- cainc1 %>% 
  gather(year, value, -GeoFips, 
         -GeoName, -LineCode, -Description) 
minc.personalincome <- subset(minc, LineCode==1)
minc.population <- subset(minc, LineCode==2)  
minc.percapitaincome<- subset(minc, LineCode==3) 
minc <- rbind(minc.personalincome, minc.population, minc.percapitaincome)
View(minc)

# Cleaning
# Determine the presence of and deal with missing Values
sum(is.na(minc)) # 0
which(is.na(minc))
minc[which(is.na(minc)),] # None are missing