 
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpp_msa_11yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)


# Income, Population, & Per Capita Income by County from 1969 to 2019
# Extraction
cainc1 <- data.frame(read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/CAINC1__ALL_AREAS_1969_2019.csv")) 
l1 <- colnames(cainc1[1:8])
l2 <- seq(1969, 2019, 1)
l3 <- c(l1, l2)
colnames(cainc1) <- l3

# Tidying
mcainc1 <- cainc1 %>% 
  gather(year, value, 
         -GeoFIPS, -GeoName, -Region, -TableName, -LineCode, 
         -IndustryClassification, -Description, -Unit) 
cainc1.personalincome <- subset(cainc1, LineCode==1)
cainc1.population <- subset(cainc1, LineCode==2)  
cainc1.percapitaincome<- subset(cainc1, LineCode==3) 
cainc1 <- rbind(cainc1.personalincome, cainc1.population, cainc1.percapitaincome)
View(mcainc1)

# Cleaning
# Determine the presence of and deal with missing Values
sum(is.na(mcainc1)) # 153 - recheck for assurance
which(is.na(mcainc1)) 
mcainc1[which(is.na(mcainc1)),] # Displays all NA's (if there are any)
# Missing values in this data are direct from BEA 
# Review each subset before omission/imputation
sum(is.na(cainc1.percapitaincome)) # 1 Missing
which(is.na(cainc1.percapitaincome)) # At 6397
cainc1.percapitaincome[6397,] # All missing 
which(is.na(cainc1.personalincome)) # At 6397
cainc1.personalincome[6397,] # All missing
which(is.na(cainc1.population)) # At 6397
cainc1.population[6397,] # Ditto as above
# The one missing entry from the data created 153 missing entries when gathered
mcainc1.clean <- na.omit(mcainc1)
sum(is.na(mcainc1.clean)) # 0 
# However, omission removed more than expected
count(mcainc1) - 153 # Expected 153 removals 
sum(is.na(mcainc1)) # The value has changed. 
# Solution: During rerun update notes!




