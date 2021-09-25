
# MS Analytics Capstone
# Restring GEOID to GEOFIPS
# Dataset: Median Home Values
# Sources: U.S.Census (ACS)
# data.census.gov

# Packages
library(dplyr)
library(tidyr)
library(stringr)

#### Start with Median Home Values ####
mhv <- data.frame(read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/mhv.csv"))

# Compare GEOID and GeoName 
# GEOID Filter:
mhv %>% 
  filter(GEOID == "310M100US10180")
#     X       GEOID           GeoName          MedianValue  MOE Year
# 1    4 310M100US10180 Abilene, TX Metro Area       83400 2009 2010
# 2  959 310M100US10180 Abilene, TX Metro Area       84800 1914 2011
# 3 1914 310M100US10180 Abilene, TX Metro Area       89300 2515 2012

# GeoName Filter:
mhv %>% 
  filter(GeoName == "Abilene, TX Metro Area")
#      X    GEOID                GeoName        MedianValue  MOE Year
# 1     4 310M100US10180 Abilene, TX Metro Area       83400 2009 2010
# 2   959 310M100US10180 Abilene, TX Metro Area       84800 1914 2011
# 3  1914 310M100US10180 Abilene, TX Metro Area       89300 2515 2012
# 4  2868 310M200US10180 Abilene, TX Metro Area       89000 2139 2013
# 5  3797 310M200US10180 Abilene, TX Metro Area       91900 2825 2014
# 6  4726 310M200US10180 Abilene, TX Metro Area       94000 2341 2015
# 7  5655 310M300US10180 Abilene, TX Metro Area       98200 1916 2016
# 8  6600 310M300US10180 Abilene, TX Metro Area      102000 2634 2017
# 9  7545 310M400US10180 Abilene, TX Metro Area      110100 3327 2018
# 10 8490 310M500US10180 Abilene, TX Metro Area      116100 2841 2019

# Results 
# GEOID filter returns 3 total entries, all with exactly the same GEOID. 
# GeoName returns 10 total entries, all with exactly the same GeoName
# Difference is GEOID reference changes middle value but not last 5 digits
# Last 5 digits of GEOID are equivalent to GEOFIPS 

# Slice to extract the GEOFIPS from GEOID for Abilene, TX metro
geostring <- as.character(mhv$GEOID)
GeoFips <- str_extract(geostring, "\\d{5}$")
mhv$GeoFips <- GeoFips

# Check that there are matches to GeoFips 


 ################### Rerun Minc Data Extraction Tidying ######


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


 ################## End Minc Rerun ############################

# Prepare for test Merge
df1 <- minc %>%  
  filter(year == 2019 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2019)
# Test merge for 2019
merged.df.2019 <- merge(df1, df2, by = "GeoFips")
# Complete and functioning - for 2019

# 2018
df1 <- minc %>%  
  filter(year == 2018 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df1, df2, by = "GeoFips")

# 2017
df1 <- minc %>%  
  filter(year == 2017 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df1, df2, by = "GeoFips")

# 2016
df1 <- minc %>%  
  filter(year == 2016 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df1, df2, by = "GeoFips")

# 2015
df1 <- minc %>%  
  filter(year == 2015 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 
df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df1, df2, by = "GeoFips")

# 2014
df1 <- minc %>%  
  filter(year == 2014 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 
df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df1, df2, by = "GeoFips")

# 2013
df1 <- minc %>%  
  filter(year == 2013 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 
df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df1, df2, by = "GeoFips")

# 2012
df1 <- minc %>%  
  filter(year == 2012 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 
df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df1, df2, by = "GeoFips")

# 2011
df1 <- minc %>%  
  filter(year == 2011 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df1, df2, by = "GeoFips")

# 2010
df1 <- minc %>%  
  filter(year == 2010 & LineCode == 3) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  slice(-1) 

df2 <- mhv %>% 
  rename(value = MedianValue, 
         year = Year) %>%
  dplyr::select("GeoFips", "GeoName", "year", "value") %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df1, df2, by = "GeoFips")

# Review Merges
merged.df <- rbind(merged.df.2019, merged.df.2018, 
      merged.df.2017, merged.df.2016, 
      merged.df.2015, merged.df.2014, 
      merged.df.2013, merged.df.2012, 
      merged.df.2011, merged.df.2010) 

# Rename and drop columns 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y)
colnames(merged.df) <- c("GeoFips", 
                         "GeoName", "year", "MEDINC", "MEDVAL")
View(merged.df)


