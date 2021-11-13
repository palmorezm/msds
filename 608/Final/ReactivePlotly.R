
# DATA 608
# Reactive Plotly CDC Example 2

data <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)

df.fin <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/fin.csv")
df.fin <- df.fin %>% 
  dplyr::select(-X)
ggplot2::theme_set(theme_minimal())

# Packages
library(tidyverse)
library(rjson)
library(tigris)
library(plotly)
library(shiny)
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
test2.med <- median(test2$value, na.rm=T) # Find median of all values as if NA's were removed
test2[which(test2$GeoFIPS == "56039"),"value"] <- test2.med # To get it to not skew results



g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'))

df <- inc_counties %>%
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% # Keep descriptors for each County
  slice(-c(1:3)) 

df$year <- as.numeric(str_remove(df$year, "^X"))
df$value <- as.numeric(df$value)
indecies <- str_which(df$GeoFIPS, pattern = "\\d{2}(000)") 
df_noncounty <- df %>% 
  slice(indecies) # Select/extract rows where indexes match 
df <- df %>% 
  slice(-indecies) %>% 
  na.exclude()
df.summary <- df %>% 
  group_by(LineCode, Description, year) %>% 
  summarize(MedianValue = median(value, na.rm = T), 
            MeanValue = mean(value, na.rm = T))
df$GeoFIPS <- str_remove_all(df$GeoFIPS, '\\\"')
df$GeoFIPS <- str_remove(df$GeoFIPS, "\\s")


df %>% 
  filter(Description == "Per capita personal income (dollars) 2/") %>% 
  filter(year == 2019) %>% 
  add_trace(
    type="choropleth",
    geojson=counties,
    locations=df$GeoFIPS,
    z=df$value,
    colorscale="Viridis",
    zmin=0,
    zmax=200000,
    marker=list(line=list(width=0)) %>% 
    layout(geo = g, 
           title = "2019 US Median Incomes by County"))



ui <- fluidPage(
  titlePanel("Some Title"),
  h4("Some Heading with some text for reference"),
  h5("Note: Some special note regarding the data"),
  fluidRow(
    column(12, 
      selectizeInput(
             inputId = "Filter", 
             label = "Select Filter:", 
             choices = unique(df$Description), 
             selected = "Per capita personal income (dollars) 2/", 
             multiple = F),
      selectizeInput(
          inputId = "Year", 
          label = "Select Year:", 
          choices = unique(df$year), 
          selected = "2019", 
          multiple = F)
      ), 
    plotlyOutput(outputId = "p", height = "800px", width = "1000px"),
  hr(), 
  helpText("Data Source: (WAS NOT FROM) CDC WONDER system, at
https://wonder.cdc.gov/ucd-icd10.htm") 
  )
)

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    df %>% 
      filter(Description == input$Filter) %>% 
      filter(year == input$Year) %>% 
      plot_ly(.) %>% 
      add_trace(
        type="choropleth",
        geojson=counties,
        locations=df$GeoFIPS,
        z=df$value,
        colorscale="Viridis",
        zmin=0,
        zmax=200000,
        marker=list(line=list(
          width=0))) %>% 
        colorbar(title = "Value") %>% 
        layout(title = "2019 US Median Incomes by County") %>% 
        layout(geo = g)
  })
}

shinyApp(ui, server)






