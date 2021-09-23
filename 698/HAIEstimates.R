
# MS Analytics Capstone
# Housing Affordability Index
# Dataset: mixed
# Sources: BEA and U.S.Census (ACS)
# https://apps.bea.gov/iTable/
# data.census.gov

# Packages
library(dplyr)
library(tidyr)

#### Start with Median Home Values ####
mhv <- data.frame(read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/mhv.csv"))
IR <- .035 # Interest Rate

mhv %>%
  filter(Year == 2019) %>% 
  mutate(EMR = MedianValue * 0.8 * (IR / 12) / (1 * (1 / 1 + IR / 12)^360), 
         QFI = (EMR * 4 * 12), 
         HAI = (EMR / QFI)* 100) # Error occured with EMR

#### Bring in Median Income ####

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

#### Combine Data ####

minc %>% 
  filter(GeoFips == "40060" & year == "2019")

# per capita income is 58628 for Richmond, VA
MEDINC <- 58628

#### Create Estimates ####

mhv %>% 
  filter(GeoName == "Richmond, VA Metro Area") %>% 
  mutate(PMT = MedianValue * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12, 
         HAI = (MEDINC / QINC) * 100 )  
# Median Income  (MEDINC) needs to be included in the final computation
