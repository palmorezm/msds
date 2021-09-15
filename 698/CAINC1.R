
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpp_msa_11yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)


# Income, Population, & Per Capita Income by MSA from 1969
# Extraction
cainc1 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/CAINC1__ALL_AREAS_1969_2019.csv")) 
l1 <- colnames(cainc1[1:8])
l2 <- seq(1969, 2019, 1)
l3 <- c(l1, l2)
colnames(cainc1) <- l3

# Tidying
cainc1 %>% 
  gather(key, value, -GeoFIPS, -GeoName, -LineCode, -Description, -IndustryClassification, -Unit, -TableName) 
cainc1.personalincome <- subset(mcainc1, LineCode==1)
cainc1.population <- subset(mcainc1, LineCode==2)  
cainc1.percapitaincome<- subset(mcainc1, LineCode==3) 
cainc1 <- rbind(cainc1.personalincome, cainc1.population, cainc1.percapitaincome)
View(mcainc1)

# Determine the presence of and deal with missing Values
sum(is.na(mrpp)) # 28 
which(is.na(mrpp))
mrpp[which(is.na(mrpp)),] # Displays all NA's (if there are any)
# There are no missing values in this data set 