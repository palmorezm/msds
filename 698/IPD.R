
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
na.omit(mipd)

# Merging process with merged.df which already 
# contains MEDINC, MEDVAL, PERINC, POP, RPPALL, 
# RPPGOODS, RPPRENT, and RPPSOTH by metro 2010 - 2019 

# 2019
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2019) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2019)
merged.df.2019 <- merge(df2, df1, by="GeoFips") 

# 2018
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2018) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df2, df1, by="GeoFips") 

# 2017
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2017) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df2, df1, by="GeoFips") 

# 2016
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2016) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df2, df1, by="GeoFips") 

# 2015
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2015) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df2, df1, by="GeoFips") 

# 2014
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2014) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df2, df1, by="GeoFips") 

# 2013
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2013) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df2, df1, by="GeoFips") 

# 2012
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2012) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df2, df1, by="GeoFips") 

# 2011
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2011) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df2, df1, by="GeoFips") 

# 2010
df1 <- mipd %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         IPD = value) %>% 
  filter(year == 2010) %>% 
  slice(-1) 
df2 <- merged.df %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df2, df1, by="GeoFips") 

# Review Merges
merged.df <- rbind(merged.df.2019, merged.df.2018, 
                   merged.df.2017, merged.df.2016, 
                   merged.df.2015, merged.df.2014, 
                   merged.df.2013, merged.df.2012, 
                   merged.df.2011, merged.df.2010) 

# Rename and drop columns 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y) %>% 
  rename(GeoName = GeoName.x, 
         year = year.x)




