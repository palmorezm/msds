
# DATA 608
# Shiny Final

# Packages
library(tidyverse)
library(rjson)
library(tigris)
library(plotly)
library(shiny)
library(geojsonsf)
library(sf)
ggplot2::theme_set(theme_minimal())

# Cleaning
counties <- rjson::fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")
inc_counties <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/Knowledge%20and%20Visual%20Analytics/Final/Data/CAINC1_AllCounties_1969_2019.csv")
df <- inc_counties %>%
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% # Keep descriptors for each County
  slice(-c(1:3)) %>% # Remove US Totals/Averages
  # filter(LineCode == 3) %>% # Subset to per capita personal income by county
  mutate(Value = as.numeric(value)) %>% # Convert all values to numeric type
  dplyr::select(-value) %>% # Remove non-numeric value column
  mutate_all(~replace(., is.na(.), 0)) %>% # Replace missing with 0
  filter(Value > 0) %>% # Remove missing
  slice( -(str_which(inc_counties$GeoFIPS, pattern = "\\d{2}(000)")) ) %>% # extract counties by GeoFIPS string code
  mutate(GeoFIPs = str_remove_all(GeoFIPS, '\\\"'), 
         GeoFips = str_remove(GeoFIPs, "\\s"), 
  ) %>% 
  dplyr::select(-GeoFIPS, -GeoFIPs) %>% # Remove quotations and whitespace from county GeoFIPS codes
  mutate(Year = as.numeric(str_remove(year, "^X"))) %>% 
  dplyr::select(-year) %>% 
  mutate(Est28 = Value*.28) %>% 
  mutate(Statistic = case_when(
    endsWith(Description, "(thousands of dollars)") ~ "Personal Income",
    endsWith(Description, "2/") ~ "Income Per Capita", 
    endsWith(Description, "1/") ~ "Population"
  )) %>% 
  dplyr::select(-Description, -TableName, -IndustryClassification)


g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'))

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
             choices = unique(df$Year), 
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
      filter(Year == input$Year) %>% 
      plot_ly(.) %>% 
      add_trace(
        type="choropleth",
        geojson=counties,
        locations=df$GeoFips,
        z=df$Est28,
        colorscale="Viridis",
        zmin=min(df$Est28),
        zmax=max(df$Est28),
        marker=list(line=list(
          width=0))) %>% 
      colorbar(title = "Value") %>% 
      layout(title = "2019 US Median Incomes by County") %>% 
      layout(geo = g)
  })
}

shinyApp(ui, server)
