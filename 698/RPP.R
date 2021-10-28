
# MS Analytics Capstone
# Data Cleaning Script 
# Dataset: rpps_10yr.csv
# Source: BEA 
# https://apps.bea.gov/iTable/

# Packages
library(dplyr)
library(tidyr)

# Regional Price Parities (RPP)
# Extraction
rpp <- data.frame(read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/rpps_10yr.csv"))
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
sum(is.na(mrpp)) # None 
which(is.na(mrpp)) 
mrpp[which(is.na(mrpp)),] # Displays all NA's (if there are any)
# There are no missing values in this data set 

# Merging process with merged.df which already contains 
# MEDINC, MEDVAL, PERINC and POP by metro 2010 - 2019 

# 2019
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2019) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2019)
merged.df.2019 <- merge(df2, df1, by="GeoFips") 

# 2018 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2018) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df2, df1, by="GeoFips") 

# 2017 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2017) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df2, df1, by="GeoFips") 

# 2016 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2016) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df2, df1, by="GeoFips") 

# 2015 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2015) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df2, df1, by="GeoFips") 

# 2014
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2014) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df2, df1, by="GeoFips") 

# 2013 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2013) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df2, df1, by="GeoFips") 

# 2012 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2012) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df2, df1, by="GeoFips") 

# 2011 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2011) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df2, df1, by="GeoFips") 

# 2010 
df1 <- rpp.allitems %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPALL = value) %>% 
  filter(year == 2010) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df2, df1, by="GeoFips") 

# Comparing observations 
dim(df1)[1] # 384
dim(df2)[2] # 375 
dim(df1)[1] - dim(df2)[2] # 9 Metro Areas missing due to missing data before merge 
# Conclusion: RPP had nothing to merge to and dropped its observations to match that of the merge

# Return to merged DF
merged.df <- rbind(merged.df.2010, merged.df.2011, 
                   merged.df.2012, merged.df.2013,
                   merged.df.2014, merged.df.2015,
                   merged.df.2016, merged.df.2017,
                   merged.df.2018, merged.df.2019) 
# rename and drop 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y) %>% 
  rename(GeoName = GeoName.x, 
         year = year.x)

# Add RPP for Goods 
# 2019
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2019) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2019)
merged.df.2019 <- merge(df2, df1, by="GeoFips") 
# 2018 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2018) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df2, df1, by="GeoFips") 
# 2017 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2017) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df2, df1, by="GeoFips") 
# 2016 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2016) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df2, df1, by="GeoFips") 
# 2015 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2015) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df2, df1, by="GeoFips") 
# 2014
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2014) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df2, df1, by="GeoFips") 
# 2013 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2013) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df2, df1, by="GeoFips") 
# 2012 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2012) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df2, df1, by="GeoFips") 
# 2011
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2011) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df2, df1, by="GeoFips") 
# 2010
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPGOODS = value) %>% 
  filter(year == 2010) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df2, df1, by="GeoFips") 

# Return to merged DF
merged.df <- rbind(merged.df.2010, merged.df.2011, 
                   merged.df.2012, merged.df.2013,
                   merged.df.2014, merged.df.2015,
                   merged.df.2016, merged.df.2017,
                   merged.df.2018, merged.df.2019) 
# rename and drop 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y) %>% 
  rename(GeoName = GeoName.x, 
         year = year.x)


# Add RPP for Rents
# 2019 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2019) %>% 
  slice(-1, -2)
df2 <- merged.df %>% 
  filter(year == 2019)
merged.df.2019 <- merge(df2, df1, by="GeoFips") 
# 2018 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2018) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df2, df1, by="GeoFips") 
# 2017 
df1 <- rpp.goods %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2017) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df2, df1, by="GeoFips") 
# 2016 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2016) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df2, df1, by="GeoFips") 
# 2015 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2015) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df2, df1, by="GeoFips") 
# 2014
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2014) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df2, df1, by="GeoFips") 
# 2013 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2013) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df2, df1, by="GeoFips") 
# 2012 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2012) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df2, df1, by="GeoFips") 
# 2011 
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2011) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df2, df1, by="GeoFips") 
# 2010
df1 <- rpp.rents %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPRENT = value) %>% 
  filter(year == 2010) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df2, df1, by="GeoFips") 

# Return to merged DF
merged.df <- rbind(merged.df.2010, merged.df.2011, 
                   merged.df.2012, merged.df.2013,
                   merged.df.2014, merged.df.2015,
                   merged.df.2016, merged.df.2017,
                   merged.df.2018, merged.df.2019) 
# rename and drop 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y) %>% 
  rename(GeoName = GeoName.x, 
         year = year.x)


# Add RPP for other services 
# 2019 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2019) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2019)
merged.df.2019 <- merge(df2, df1, by="GeoFips") 
# 2018 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2018) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2018)
merged.df.2018 <- merge(df2, df1, by="GeoFips") 
# 2017
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2017) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2017)
merged.df.2017 <- merge(df2, df1, by="GeoFips") 
# 2016 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2016) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2016)
merged.df.2016 <- merge(df2, df1, by="GeoFips")
# 2015 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2015) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2015)
merged.df.2015 <- merge(df2, df1, by="GeoFips")
# 2014 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2014) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2014)
merged.df.2014 <- merge(df2, df1, by="GeoFips")
# 2013
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2013) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2013)
merged.df.2013 <- merge(df2, df1, by="GeoFips")
# 2012 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2012) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2012)
merged.df.2012 <- merge(df2, df1, by="GeoFips")
# 2011
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2011) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2011)
merged.df.2011 <- merge(df2, df1, by="GeoFips")
# 2010 
df1 <- rpp.services %>% 
  dplyr::select(GeoFips, GeoName, key, value) %>% 
  rename(year = key, 
         RPPSOTH = value) %>% 
  filter(year == 2010) %>% 
  slice(-1, -2) 
df2 <- merged.df %>% 
  filter(year == 2010)
merged.df.2010 <- merge(df2, df1, by="GeoFips")

# Return to merged DF
merged.df <- rbind(merged.df.2010, merged.df.2011, 
                   merged.df.2012, merged.df.2013,
                   merged.df.2014, merged.df.2015,
                   merged.df.2016, merged.df.2017,
                   merged.df.2018, merged.df.2019) 


# rename and drop 
merged.df <- merged.df %>% 
  dplyr::select(-GeoName.y, -year.y) %>% 
  rename(GeoName = GeoName.x, 
         year = year.x) 




