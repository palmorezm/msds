

# Measuring Housing Affordability
# Income Map

library(tidyverse)
library(plotly)
library(shiny)

### County Income & Population Data ###
counties <- rjson::fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")
df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/Knowledge%20and%20Visual%20Analytics/Final/Data/CAINC1_AllCounties_1969_2019.csv")

df_decades <- df %>%
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
    mutate(Statistic = case_when(
        endsWith(Description, "(thousands of dollars)") ~ "Personal Income",
        endsWith(Description, "2/") ~ "Income Per Capita", 
        endsWith(Description, "1/") ~ "Population"
    ), 
    Years = as.Date(paste(Year, 12, 31, sep = "-"))) %>% 
    filter(Year %in% c(1969, 1979, 1989, 1999, 2009, 2019)) %>% 
    dplyr::select(-Description, -TableName, -IndustryClassification)

df_decades <- df_decades %>% 
    slice( -(str_which(df$GeoFIPS, pattern = "\\d{2}(000)")) ) %>% # extract counties by GeoFIPS string code
    mutate(GeoFIPs = str_remove_all(GeoFIPS, '\\\"'), 
           GeoFips = str_remove(GeoFIPs, "\\s")) %>% 
    dplyr::select(-GeoFIPS, -GeoFIPs)

dmap <- df_decades %>% 
    filter(Statistic == "Income Per Capita") %>% 
    mutate(mpay = (Value*.28)/12, 
           lmpay = (Value*.16)/12,
           dif = mpay - lmpay) %>% 
    mutate(RegionName = case_when(
        Region == 1 ~ "New England", 
        Region == 2 ~ "Mid-Atlantic",
        Region == 3 ~ "Midwest",
        Region == 4 ~ "Great Plains",
        Region == 5 ~ "South",
        Region == 6 ~ "Southwest",
        Region == 7 ~ "Rocky Mountain",
        Region == 8 ~ "West",
    )) 

# Alter to fit map
dmap$hover <- with(dmap, 
                   paste(GeoName, "<br>",
                         "Region:", RegionName, "<br>",
                         '<br>', "Income Per Capita:", paste0("$", format(Value, nsmall = 0)), "<br>",
                         "Max. Monthly Payment:", paste0("$", format(mpay, nsmall = 2, digits = 2)), "<br>",
                         "Min. Monthly Payment:", paste0("$", format(lmpay, nsmall = 2, digits = 2)), "<br>",
                         "Affordability Range", paste0("$", format(dif, nsmall = 2, digits = 2)))) 


colors <- data.frame(list(c("Bluered", "Cividis", "Earth", "Electric", "Greens", "Greys", "Hot", "Picnic", "RdBu", "Viridis")))
colnames(colors) <- "col"

g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white'))


ui <- fluidPage(
    tabsetPanel(
        tabPanel("Map", fluid = TRUE,
                 titlePanel("Measuring Housing Affordability"),
                 h4("An app to observe and assess measurements of affordability in the United States"),
                 h5("Specifically we try to determine:"), 
                 h5("     - Where is housing most affordable and why?"),
                 h5("     - How has housing affordability changed?"),
                 h5("     - Using standard NAR HAI, what is considered affordable?"),
                 h5("     - If changes in HAI methods could better represent 
              existing challenges, what might they look like?"),
                 h5("     - Explain major macroeconomic forces that effect affordability at scale"),
                 hr(), 
                 
                 fluidRow(
                     column(12,
                            selectizeInput(
                                inputId = "mapyear", 
                                label = "Census Year:", 
                                choices = unique(dmap$Year), 
                                selected = 2019, 
                                multiple = F), 
                            selectizeInput(
                                inputId = "mapcolor", 
                                label = "Choose Color:", 
                                choices = unique(colors$col), 
                                selected = "Cividis", 
                                multiple = F),
                            plotlyOutput(outputId = "map", 
                                         height = "1000px", 
                                         width = "1600px")
                     ), 
                     h4("Income and Affordability"),
                     h5("For this mapping tab we identify the geographic distribution of the primary driver of 
     the home affordability index (HAI), income. At its core, the HAI is represented as
     ratio of Median Household Income to a Qualifying Income per location. This Home 
     Affordability Index equation incorporates the home value within the 
     qualifying income. It is based on the idea that to afford housing one only 
     needs to have a house price and enough income to qualify for a mortgage 
     at a specific interest rate (3.5%). Here, we use the rule of 28% to estimate the maximum 
     proportion of monthly income an individual should spend on housing given 
     financial standards. For a minimum we found that the lowest quantile of homeowners
     financed their mortgage with a median of no less than 16% of their monthly income. 
     This is applied to estimate minimum payments by county and the difference between the
     two is that county's affordability range."),
                     h5("With this map we can select the last year in each decade from 1969 to 2019. 
      Changing the map's colors can improve visibility of certain areas of interest. 
      For example, for isolating high and low values a Red-Blue might be of use while 
      Electric or Viridis with high lower value but still highlight higher values. 
      Income values per county through each year are displayed on the same scale $0 - $100,000.
      This begins to show how much has changed with income and monthly housing payments since
      1969. The state of Virginia contains multiple counties that are aggregated to form any area
      similar to a CBSA 
      and as such are not displayed on a county-level map."),
                     
                     hr(), 
                     
                     helpText("Data Source: U.S. Census Bureau at https://data.census.gov/cedsci/"),
                     helpText("Note: Data has a maximum margin of error (MOE) of $17,381 and 
                    minimum of $447 for median home values and are estimated with 
                    ACS 5-Year results. Estimates of HAI are based on the 
                    observed median in real personal income 
                    of individuals alongside the median estimate of individuals'
                    perceived home values")
                 )
                ) # End tab 1 
    )
    
)

# Define server functions
server <- function(input, output){
    
    output$map <- renderPlotly({
        dmap %>% 
            filter(Year == input$mapyear) %>%
            plot_ly(.) %>% 
            add_trace(
                type="choropleth",
                geojson=counties,
                locations= ~GeoFips,
                z= ~Value,
                colorscale= input$mapcolor,
                zmin=0,
                zmax=100000,
                text = ~hover,
                marker=list(line=list(
                    width=0))) %>% 
            colorbar(title = "Salary") %>% 
            layout(title = "U.S. Median Income Per Capita") %>% 
            layout(geo = g) 
    })
}

shiny::shinyApp(ui, server)


