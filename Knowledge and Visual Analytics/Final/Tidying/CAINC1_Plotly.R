

# MS Knowledge and Visual Analytics 
# Mapping Housing Affordability 
# Dataset: mixed
# Sources: BEA and U.S.Census (ACS)
# https://apps.bea.gov/iTable/
# data.census.gov

# Packages
library(tidyverse)
library(rjson)
library(tigris)
library(plotly)
library(geojsonsf)
library(sf)

# Cleaning
url <- 'https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json'
counties <- rjson::fromJSON(file=url)
# Import personal income CAINC1 
# It contains Personal Income, Pop, Per Capita Personal Income
inc_counties <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/608/Final/Data/CAINC1_AllCounties_1969_2019.csv")
sample.df2019 <- inc_counties %>%
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% # Keep descriptors for each County
  filter(year == 'X2019') %>% # Filter by year of our choice (1969 - 2019)
  slice(-c(1:3)) # Remove US Totals/Averages
# Convert all values to numeric tpye
sample.df2019$value <- as.numeric(sample.df2019$value)
sample.df2019 <- sample.df2019 %>% 
  filter(LineCode == 3) # Subset to per capita personal income by county
# Locate which index values are not counties (list includes state, regions, by GeoFIPS)
indecies <- str_which(sample.df2019$GeoFIPS, pattern = "\\d{2}(000)") 
# Use a boolean array to subset the sample df by indexes of GeoFIPS
test <- subset(sample.df2019, (sample.df2019[indecies,1] == sample.df2019$GeoFIPS))
test1 <- sample.df2019 %>% 
  slice(indecies) # Select/extract rows where indexes match 
test2 <- sample.df2019 %>% 
  slice(-indecies) # Select/extract all rows where indexes do not match 
# Remove quotations and whitespace from county GeoFIPS codes
test2$GeoFIPS <- str_remove_all(test2$GeoFIPS, '\\\"')
test2$GeoFIPS <- str_remove(test2$GeoFIPS, "\\s")
# for ease of access/reproducibility; export as csv to Git
# write.csv(test2, "C:/Users/Owner/Documents/Data/test2.csv")
url2<- "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv"
df <- read.csv(url2, colClasses=c(fips="character")) # Import Plotly's FIPS codes by county 
df$fips == test2$GeoFIPS # Confirm our county FIPS codes match 

# Remove outliers
df <- test2 %>% 
  dplyr::select(where(is.numeric))
for (i in colnames(df)) {
  iqr <- IQR(df[[i]])
  q <- quantile(df[[i]], probs = c(0.25, 0.75), na.rm = FALSE)
  qupper <- q[2]+1.5*iqr
  qlower <- q[1]+1.5*iqr
  outlier_free <- subset(df, df[[i]] > (q[1] - 1.5*iqr) & df[[i]] < (q[2]+1.5*iqr) )
  df.outlier_free <- outlier_free
}
test2.med <- median(test2$value, na.rm=T) # Find median of all values as if NA's were removed
test2[which(test2$GeoFIPS == "56039"),"value"] <- test2.med # To get it to not skew results

# Visualize with Plotly Choropleth
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
fig <- plot_ly()
fig <- fig %>% add_trace(
  type="choropleth",
  geojson=counties,
  locations=test2$GeoFIPS,
  z=test2$value,
  colorscale="Viridis",
  zmin=0,
  zmax=200000,
  marker=list(line=list(
    width=0)
  )
)
fig <- fig %>% colorbar(title = "Value")
fig <- fig %>% layout(
  title = "2019 US Median Incomes by County"
)

fig <- fig %>% layout(
  geo = g
)

fig


