
# MS Analytics Capstone
# Mapping Housing Affordability 
# Dataset: mixed
# Sources: BEA and U.S.Census (ACS)
# https://apps.bea.gov/iTable/
# data.census.gov

# Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(rjson)
library(tigris)
library(plotly)
library(geojsonsf)
library(sf)


# Data comes from "HAIEstimates.R" and "GEOID_GEOFIPS.R" 
df <- df_mapping %>% 
  filter(year == "2019")

csa <- tigris::combined_statistical_areas()
cores <- tigris::core_based_statistical_areas()
metro_areas <- cores %>% 
  filter(LSAD == "M1")

plot(metro_areas$geometry) # Produces map of metro areas 
plot(metro_areas$geometry, col = df$HAI) # Created "Rplot3" in Git


df %>% 
  ggplot(aes(HAI, alpha = 0.5)) + geom_histogram(stat = "bin", binwidth = 10, fill='CadetBlue', color='white') + 
  geom_vline(xintercept = median(df$HAI), lty = "dotted", col = "black") + 
  geom_vline(xintercept = 100, lty = "dotdash", col = "orange") +
  theme_minimal() + theme(legend.position = "none") 


library(RColorBrewer)
my_colors <- brewer.pal(9, "Greens") 
my_colors <- colorRampPalette(my_colors)(18)

class_of_country <- cut(df$HAI, 18)
my_colors <- my_colors[as.numeric(class_of_country)]

# Make the plot
plot(metro_areas$geometry, col=my_colors)

summary(df$HAI)

df %>%
  top_frac(n = 0.2,wt = HAI) # Top 20% 

df %>% 
  top_frac(n = -0.2, wt = HAI) # Bottom 20% 


df %>% 
  top_frac(n = -0.1, wt = HAI) # Lowest 10%



# Plotly Choropleth
url <- 'https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json'
counties <- rjson::fromJSON(file=url)
url2<- "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv"
df <- read.csv(url2, colClasses=c(fips="character"))


df.mhv2 <- df.mhv %>% 
  mutate(fips = County) %>%
  filter(Year == 2019) 

class(df.mhv2$MedianValue)

df.mhv2$nums <- as.numeric(df.mhv2$MedianValue)

class(df.mhv2$fips)
sum(is.na(df.mhv2))

ListJSON <- toJSON(cores$geometry,pretty=TRUE,auto_unbox=TRUE)
ListJSON

list(cores$geometry)
class(cores$geometry)


geo <- sf_geojson(cores$geometry)
substr(geo, 1, 80)


# Convert from sfc_Multipolygon object to sf
# Then Convert sf to geojson  
cores <- tigris::core_based_statistical_areas(cb = F, class = "sf")

inc_counties <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/608/Final/Data/CAINC1_AllCounties_1969_2019.csv")
sample.df2019 <- inc_counties %>% 
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% 
  filter(year == 'X2019') %>%
  slice(-c(1:3)) 

sample.df2019$value <- as.numeric(sample.df2019$value)
sample.df2019 <- sample.df2019 %>% 
  filter(LineCode == 3)

library(stringr)
str <- sample.df2019$GeoFIPS
str_extract(str, "\\d{2}(000)")

str_subset(sample.df2019$GeoFIPS, "\\d{2}(000)")
str_locate(sample.df2019$GeoFIPS, "\\d{2}(000)")
sample.df20192 <- str_remove_all(sample.df2019$GeoFIPS, "\\d{2}(000)")

str_sub(sample.df2019, start = 3, end = 7)
str_sub(sample.df2019$GeoFIPS, start=3, end=7)
str_extract_all(sample.df2019$GeoFIPS, "\\d{2}(000)")
which(str_match(sample.df2019$GeoFIPS, "\\d{2}(000)")[,1])
where(str_match(sample.df2019$GeoFIPS, "\\d{2}(000)")[,1])
sample.df2019 %>% 
  dplyr::select(GeoFIPS) %>% 
  str_extract_all(., pattern = "\\d{2}(000)") 
indecies <- str_which(sample.df2019$GeoFIPS, pattern = "\\d{2}(000)")
test <- sample.df2019[c(indecies),"GeoFIPS"]
subset(sample.df2019, GeoFIPS[c(indecies)])
str_subset("\\d{2}(000)")

sample.df2019[[1,indecies]]
  
sample.df2019$GeoFIPS == str_extract_all(sample.df2019$GeoFIPS, "\\d{2}(000)")
sample.df2019$GeoFIPS[indecies]
subset(sample.df2019, sample.df2019$GeoFIPS[indecies])

sample.df2019[indecies,1] == sample.df2019$GeoFIPS

sample.df2019[(sample.df2019[indecies,1] == sample.df2019$GeoFIPS)]
test <- subset(sample.df2019, (sample.df2019[indecies,1] == sample.df2019$GeoFIPS))
test1 <- sample.df2019 %>% 
  slice(indecies) 
test2 <- sample.df2019 %>% 
  slice(-indecies) 


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
  zmin=min(test2$value),
  zmax=max(test$value),
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





url <- 'https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json'
counties <- rjson::fromJSON(file=url)
url2<- "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv"
df <- read.csv(url2, colClasses=c(fips="character"))

df$fips == test2$GeoFIPS

class(test2$GeoFIPS)
test2$GeoFIPS[1]
df$fips[1]

str <- str_remove(test2$GeoFIPS, "\\s")

test2$GeoFIPS <- str_remove_all(test2$GeoFIPS, '\\\"')
test2$GeoFIPS <- str_remove(test2$GeoFIPS, "\\s")


boxplot(test2$value)

write.csv(test2, "C:/Users/Owner/Documents/Data/test2.csv")

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
  locations=df$fips,
  z=df$unemp,
  colorscale="Viridis",
  zmin=0,
  zmax=12,
  marker=list(line=list(
    width=0)
  )
)
fig <- fig %>% colorbar(title = "Unemployment Rate (%)")
fig <- fig %>% layout(
  title = "2016 US Unemployment by County"
)

fig <- fig %>% layout(
  geo = g
)

fig




# Attempt to draw CBSAs with add_polygon()

g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
fig <- plot_ly()

fig <- fig %>% add_trace(
  type="choropleth",
  geojson=cores$jsHooks$jsHooks$width,
  locations=df$fips,
  z=df$unemp,
  colorscale="Viridis",
  zmin=0,
  zmax=12,
  marker=list(line=list(
    width=0)
  )
)
fig <- fig %>% colorbar(title = "Unemployment Rate (%)")
fig <- fig %>% layout(
  title = "2016 US Unemployment by County"
)

fig <- fig %>% layout(
  geo = g
)

fig

library(ggplot2)

df.mhv %>%
  ggplot(aes(Year, MedianValue, col = MedianValue)) + geom_col()


RColorBrewer::brewer.pal(df.mhv$MedianValue, name =)
plot(cores$geometry, )


