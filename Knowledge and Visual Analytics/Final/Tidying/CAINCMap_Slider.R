
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
df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/Knowledge%20and%20Visual%20Analytics/Final/Data/CAINC1_AllCounties_1969_2019.csv")
df <- df %>%
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% # Keep descriptors for each County
  slice(-c(1:3)) %>% # Remove US Totals/Averages
  # filter(LineCode == 3) %>% # Subset to per capita personal income by county
  mutate(Value = as.numeric(value)) %>% # Convert all values to numeric type
  dplyr::select(-value) %>% # Remove non-numeric value column
  mutate_all(~replace(., is.na(.), 0)) %>% # Replace missing with 0
  filter(Value > 0) %>% # Remove missing
  mutate(Year = as.numeric(str_remove(year, "^X"))) %>% 
  dplyr::select(-year) %>% 
  mutate(Est28 = Value*.28) %>% 
  mutate(Statistic = case_when(
    endsWith(Description, "(thousands of dollars)") ~ "Personal Income",
    endsWith(Description, "2/") ~ "Income Per Capita", 
    endsWith(Description, "1/") ~ "Population"
  ), 
  Years = as.Date(paste(Year, 1, 1, sep = "-"))) %>% 
  filter(Year %in% c(1969, 1979, 1989, 1999, 2009, 2019)) %>% 
  dplyr::select(-Description, -TableName, -IndustryClassification, -Year) 

df <- df %>% 
  slice( -(str_which(df$GeoFIPS, pattern = "\\d{2}(000)")) ) %>% # extract counties by GeoFIPS string code
  mutate(GeoFIPs = str_remove_all(GeoFIPS, '\\\"'), 
         GeoFips = str_remove(GeoFIPs, "\\s"), # Remove quotations and whitespace from county GeoFIPS codes
  ) %>% 
  dplyr::select(-GeoFIPS, -GeoFIPs) 


df %>% 
  filter(Statistic == "Population") %>% 
  filter(Years == as.Date("1969-01-01", "%Y-%m-%d")) %>% View() 
summarise(min = min(Value), 
          max = max(Value))

df.tbl <- df %>% 
  group_by(Statistic, Years) %>% 
  summarise(min = min(Value), 
            med = median(Value), 
            max = max(Value))
df.tbl %>% 
  
  
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white'))

ui <- fluidPage(
  
  titlePanel("Some Title"),
  
  h4("Some Heading with some text for reference"),
  
  h5("Note: Some special note regarding the data"),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        inputId = "Statistic", 
        label = "Select Filter:", 
        choices = unique(df$Statistic), 
        selected = "Population", 
        multiple = F),
      sliderInput("Years", 
                  "Select Year",
                  value = as.Date("1969-01-01"), timeFormat="%Y-%m-%d",
                  min = as.Date("1969-01-01", "%Y-%m-%d"), 
                  max = as.Date("2019-01-01", "%Y-%m-%d")
      ) 
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotlyOutput(outputId = "p", 
                                                height = "800px", 
                                                width = "1000px")), 
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", verbatimTextOutput("table"))
      ), 
    )
  )
)


server <- function(input, output, ...) {
  output$p <- renderPlotly({
    df %>% 
      filter(Statistic == input$Statistic) %>% 
      filter(Years == input$Years) %>% 
      plot_ly(.) %>% 
      add_trace(
        type="choropleth",
        geojson=counties,
        locations=df$GeoFips,
        z=df$Value,
        colorscale="Viridis",
        zmin=min(df$Value),
        zmax=max(df$Value),
        marker=list(line=list(
          width=0))) %>% 
      colorbar(title = "Value") %>% 
      layout(title = "Selected Statistical Changes in U.S. Counties") %>% 
      layout(geo = g)
  })
}

shinyApp(ui, server)
