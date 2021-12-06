
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
  # filter(Year %in% c(1969, 1979, 1989, 1999, 2009, 2019)) %>% 
  dplyr::select(-Description, -TableName, -IndustryClassification) 


df <- df %>% 
  slice( -(str_which(df$GeoFIPS, pattern = "\\d{2}(000)")) ) %>% # extract counties by GeoFIPS string code
  mutate(GeoFIPs = str_remove_all(GeoFIPS, '\\\"'), 
       GeoFips = str_remove(GeoFIPs, "\\s"), # Remove quotations and whitespace from county GeoFIPS codes
       ) %>% 
  dplyr::select(-GeoFIPS, -GeoFIPs) 

## Cleaned County Income ## 

df_0919 <- df %>%
  filter(Year > 2008) %>% 
  filter(LineCode == 3) 

df %>%
  filter(Year > 2008) %>% 
  filter(LineCode == 3) %>% 
  dplyr::select(GeoFips, GeoName, Year, Statistic, Value) %>% 
  spread(Year, Value) 





g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'))


# Define UI for random distribution app ----
library(shiny)
library(plotly)
library(tidyverse)
library(ggpubr)
library(kableExtra)
library(DT)
theme_set(theme_minimal())


shinyApp(
  ui = fluidPage(
    tabsetPanel(
      # Start Tab 1 
      # Show map of income by county in US 
      # Consider option to make it static with most recent year since 
      tabPanel("Map", fluid = TRUE,
               sidebarLayout(
                 
                 sidebarPanel(
                   selectInput("Country", "Select Country", choices = "", selected = "")
                   ),
                 
                 mainPanel(
                   htmlOutput("Attacks")
                 )
               )
      ), # End tab 1 
      
      # Start tab 2 
      tabPanel("Methods", fluid = TRUE,
               sidebarLayout(
                 
                 sidebarPanel( # Create sidebar panel for Tab 2
                   
                   selectizeInput(
                     inputId = "haimethodtab2", 
                     label = "Select Method:", 
                     choices = unique(ltdf$key), 
                     selected = "HAI", 
                     multiple = F),
                   
                   selectizeInput(
                     inputId = "haiset2", 
                     label = "Select Affordability Set:", 
                     choices = unique(d$Set), 
                     selected = "GT100", 
                     multiple = T),
                   
                 ), # Close sidebar panel for tab 2 
                 mainPanel(
                   tabsetPanel(type = "tabs",
                               tabPanel("Trend", plotlyOutput(outputId = "Summary")), 
                               tabPanel("MSA LT100", dataTableOutput("")),
                               tabPanel("MSA GT100", dataTableOutput("")),
                               h4("some message in heading 4"),
                               tabPanel("Other", plotOutput(outputId = "", 
                                                            height = "800px", 
                                                            width = "1000px"))
                   ) # End Child Tab Panel of Main Panel 
                 ) # End Main Panel 
               ) # End Sidebar layout for tab 2
      ), # End Tab 2
      
      # Start Tab 3
      tabPanel("Population", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel( # Create Sidebar Panel
                   
                   selectizeInput(
                     inputId = "Statisticdftbl3", 
                     label = "Select Statistic", 
                     choices = unique(df.tbl$Statistic), 
                     selected = "Income Per Capita", 
                     multiple = F),
                   
                   selectizeInput(
                     inputId = "barcharthaikey3", 
                     label = "Select HAI", 
                     choices = unique(d$key), 
                     selected = "HAI", 
                     multiple = T),
                  
                    selectizeInput(
                     inputId = "barcharthaiset2", 
                     label = "Select Affordability Set", 
                     choices = unique(d$Set), 
                     selected = "LT100", 
                     multiple = F)
                   
                 ), # close Sidebar Panel for Tab 3 
                 
                 mainPanel(fluidRow( # Create main panel Tab 3
                   column(4, plotlyOutput("")),
                   column(8, plotlyOutput("barproportionmsabymethod")),
                   h5("somthing written here"),
                   h6("This is an example of a longer paragraph with sentences 
                      for examplaining the data above. This is an example of a 
                      longer paragraph with sentences for examplaining the data
                      above. This is an example of a longer paragraph with 
                      sentences for examplaining the data above.")
                  ) # Close fluid Row
                 ) # Close main panel 
               ) # End Tab 3 Sidebar Layout 
      ), # End Tab 3
     
     # Start Tab 4
      tabPanel("Tables", fluid = TRUE,
               sidebarLayout(
                 
                 sidebarPanel( # Create sidebar panel for Tab 4
                   
                   selectizeInput(
                     inputId = "haimethodtab3", 
                     label = "Select Method:", 
                     choices = unique(ltdf$key), 
                     selected = "HAI", 
                     multiple = F),
                   
                   selectizeInput(
                     inputId = "haiset", 
                     label = "Select Affordability Set:", 
                     choices = unique(d$Set), 
                     selected = "GT100", 
                     multiple = T),
                   
                   ), # Close sidebar panel for tab 4 
                 mainPanel(
                   tabsetPanel(type = "tabs",
                               tabPanel("Trend", plotlyOutput(outputId = "Summary")), 
                               tabPanel("MSA LT100", dataTableOutput("ltdftable")),
                               tabPanel("MSA GT100", dataTableOutput("gtdftable")),
                               h4("some message in heading 4"),
                               tabPanel("Other", plotOutput(outputId = "", 
                                                            height = "800px", 
                                                            width = "1000px"))
                              ) # End Child Tab Panel of Main Panel 
                          ) # End Main Panel 
              ) # End Sidebar layout for tab 4
          ), # End Tab 4
     
     # Start Tab 5
     tabPanel("Other", fluid = TRUE,
              sidebarLayout(
                sidebarPanel( # Create Sidebar Panel
                  
                  selectizeInput(
                    inputId = "Statisticdftbl5", 
                    label = "Select Statistic", 
                    choices = unique(df.tbl$Statistic), 
                    selected = "Income Per Capita", 
                    multiple = F),
                  
                  selectizeInput(
                    inputId = "barcharthaikey5", 
                    label = "Select HAI", 
                    choices = unique(d$key), 
                    selected = "HAI", 
                    multiple = T),
                  
                  selectizeInput(
                    inputId = "barcharthaiset5", 
                    label = "Select Affordability Set", 
                    choices = unique(d$Set), 
                    selected = "LT100", 
                    multiple = F)
                  
                ), # close Sidebar Panel for Tab 5
                
                mainPanel(fluidRow( # Create main panel Tab 5
                  column(4, plotlyOutput("plotincome")),
                  column(8, plotlyOutput("barcharthai")),
                  h5("somthing written here"),
                  h6("This is an example of a longer paragraph with sentences 
                      for examplaining the data above. This is an example of a 
                      longer paragraph with sentences for examplaining the data
                      above. This is an example of a longer paragraph with 
                      sentences for examplaining the data above.")
                  
                ) # Close fluid Row
                ) # Close main panel 
              ) # End Tab 5 Sidebar Layout 
           ) # End Tab 5
      ) # Close Tabset Panel 
  ), # Close UI
  # Define server functions
  server = function(input, output) {
    
    output$plotincome <- renderPlotly({
      df.tbl %>% 
        filter(Statistic == input$Statisticdftbl) %>% 
        plot_ly(., x = ~Years, y = ~min, name = "min", type = "scatter", mode = "lines+markers") %>% 
        add_trace(y = ~med, name = 'med', mode = 'lines+markers') %>% 
        add_trace(y = ~max, name = 'max', mode = 'lines+markers')
    })
    
    output$barproportionmsabymethod <- renderPlot({
      d %>% 
        ggplot(aes(year, (TPOP/1000000), fill=Set)) + 
        geom_col(col = "grey38", alpha= 0.25) + 
        # scale_x_discrete(limit = c(2010, 2015, 2019)) + 
        labs(x = "Year (2010 - 2019)", y = "Population (Millions)", subtitle = "Proportion of MSA Population by Method") + 
        theme(axis.text.x = element_blank(), 
              # axis.ticks = element_line(size = .5), 
              plot.subtitle = element_text(hjust = 0.5)) +
        facet_wrap(~key, scales = "fixed", labeller = labeller(key = hainames)) + 
        scale_fill_discrete(limits = c("GT100", "LT100"), labels = c("Affordable", "Unaffordable") )
    })
    
    output$barcharthai <- renderPlotly({
      d %>% 
        filter(Set == input$barcharthaiset) %>%
        filter(key %in% input$barcharthaikey) %>% 
        plot_ly(., x = ~year, y = ~(TPOP/1000000), type = "bar", name = ~key, opacity = 0.75)
    })  
    
    output$ltdftable <- renderDataTable({
      ltdf %>% 
        dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
        filter(key == input$haimethodtab3) 
    }, filter = 'top',
    rownames = T)
    
    output$gtdftable <- renderDataTable({
      gtdf %>% 
        dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
        filter(key == input$haimethodtab3) 
    }, filter = 'top',
    rownames = T)
    
}) # Finish Shiny App

