
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
library(ggpubr)
library(DT)
theme_set(theme_minimal())


ui <- fluidPage(
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
                   inputId = "df_finkey_key", 
                   label = "Select Affordability Set:", 
                   choices = c("HAI", "HAIRW", "HAIRNT", 
                               "HAIIPD", "HAIRAW", "HAILEN"), 
                   selected = c("HAI", "HAIRW", "HAIRNT", 
                                "HAIIPD", "HAIRAW", "HAILEN"), 
                   multiple = T)
               ), # Close sidebar panel for tab 2
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("MethodTab1", plotOutput(outputId = "method1"))
                 ) # End Child Tab Panel of Main Panel 
               ) # End Main Panel 
             ) # End Sidebar layout for tab 2
    ), # End Tab 2
    # Start Tab 3
    tabPanel("Population", fluid = TRUE,
             sidebarLayout(
               sidebarPanel( 
                 selectizeInput(
                   inputId = "barcharthaikey", 
                   label = "Select HAI Method", 
                   choices = unique(d$key), 
                   selected = "HAI", 
                   multiple = T),
                 selectizeInput(
                   inputId = "barcharthaiset", 
                   label = "Select Affordability Set", 
                   choices = unique(d$Set), 
                   selected = "LT100", 
                   multiple = F), 
                 selectizeInput(
                   inputId = "barcharthaikey2", 
                   label = "Select HAI Method", 
                   choices = unique(d$key), 
                   selected = "HAI", 
                   multiple = F)
               ), # close Sidebar Panel for Tab 3 
               mainPanel(fluidRow( # Create main panel Tab 3
                 column(4, plotlyOutput("barcharthai")),
                 column(8, plotOutput("barproportionmsabymethod")),
                 h5("somthing written here"),
                 h6("This is an example of a longer paragraph with sentences 
                      for examplaining the data above. This is an example of a 
                      longer paragraph with sentences for examplaining the data
                      above. This is an example of a longer paragraph with 
                      sentences for examplaining the data above.")
                ) # Close mainPanel fluidRow
               ) # Close main panel 
             ) # End Tab 3 Sidebar Layout 
    ), # End Tab 3
    # Start Tab 4
    tabPanel("Income", fluid = TRUE,
             sidebarLayout(
               sidebarPanel( # Create Sidebar Panel
                 selectizeInput(
                   inputId = "Statisticdftbl", 
                   label = "Select Statistic", 
                   choices = unique(df.tbl$Statistic), 
                   selected = "Income Per Capita", 
                   multiple = F)
               ), # close Sidebar Panel for Tab 5
               mainPanel(fluidRow( # Create main panel Tab 5
                 column(4, plotlyOutput("plotincome")),
                 column(8, plotlyOutput("plotincome2")),
                 h5("somthing written here"),
                 h6("This is an example of a longer paragraph with sentences 
                      for examplaining the data above. This is an example of a 
                      longer paragraph with sentences for examplaining the data
                      above. This is an example of a longer paragraph with 
                      sentences for examplaining the data above.")
                 
               ) # Close mainPanel fluid Row
               ) # Close main panel 
             ) # End Tab 4 Sidebar Layout 
    ),
    # Start tab 5
    tabPanel("Tables", fluid = TRUE,
             sidebarLayout(
               sidebarPanel( # Create sidebar panel for Tab 5
                 selectizeInput(
                   inputId = "haitablestab", 
                   label = "Select Method", 
                   choices = unique(ltdf$key), 
                   selected = "HAI", 
                   multiple = F)
               ), # Close sidebar panel for tab 5 
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Unaffordable", dataTableOutput("ltdftable")),
                             tabPanel("Affordable", dataTableOutput("gtdftable")),
                             h4("some message in heading 4")
                 )
               )
             )
    )
  )
)

# Define server functions
server <- function(input, output){
  
  # Method Tab
  output$method1 <- renderPlot({
    df_finkey %>% 
      filter(key == input$df_finkey_key) %>% 
      ggplot(aes(value, col = key)) + 
      geom_histogram(alpha = .05) + 
      geom_vline(xintercept = 100) + 
      labs(subtitle = "Method Distributions", x = "Selected Statistic", y = "Count") + 
      theme(plot.subtitle = element_text(hjust = 0.5)) + 
      facet_wrap(~key, scales = "free_x", labeller = labeller(key = hainames)) +
      theme(legend.position = "none")
  })
  
  # Income Tab
  output$plotincome <- renderPlotly({
    df.tbl %>% 
      filter(Statistic == input$Statisticdftbl) %>% 
      plot_ly(., x = ~Years, y = ~min, name = "min", type = "scatter", mode = "lines+markers") %>% 
      add_trace(y = ~med, name = 'med', mode = 'lines+markers') %>% 
      add_trace(y = ~max, name = 'max', mode = 'lines+markers')
  })
  
  output$plotincome2 <- renderPlotly({
    df.tbl %>% 
      filter(Statistic == input$Statisticdftbl) %>% 
      plot_ly(., x = ~Years, y = ~min, name = "min", type = "scatter", mode = "lines+markers") %>% 
      add_trace(y = ~med, name = 'med', mode = 'lines+markers') %>% 
      add_trace(y = ~max, name = 'max', mode = 'lines+markers')
  })
  
  
  # Population Tab
  output$barproportionmsabymethod <- renderPlot({
    d %>% 
      filter(key == input$barcharthaikey2) %>% 
      ggplot(aes(year, (TPOP/1000000), fill=Set)) + 
      geom_col(col = "grey38", alpha= 0.25) + 
      # scale_x_discrete(limit = c(2010, 2015, 2019)) + 
      labs(x = "Year (2010 - 2019)", y = "Population (Millions)", subtitle = "Proportion of MSA Population by Method") + 
      theme(axis.text.x = element_blank(), 
            # axis.ticks = element_line(size = .5), 
            plot.subtitle = element_text(hjust = 0.5)) +
      facet_wrap(~key, scales = "fixed", labeller = labeller(key = hainames)) + 
      scale_fill_discrete(limits = c("LT100", "GT100"), labels = c("Unaffordable", "Affordable") )
  })
  
  output$barcharthai <- renderPlotly({
    d %>% 
      filter(Set == input$barcharthaiset) %>%
      filter(key %in% input$barcharthaikey) %>% 
      plot_ly(., x = ~year, y = ~(TPOP/1000000), type = "bar", name = ~key, opacity = 0.75)
  })  
  
  # Tables Tab
  output$ltdftable <- renderDataTable({
    ltdf %>% 
      dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
      filter(key == input$haitablestab) 
  }, filter = 'top',
  rownames = T)
  
  output$gtdftable <- renderDataTable({
    gtdf %>% 
      dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
      filter(key == input$haitablestab) 
  }, filter = 'top',
  rownames = T)
  
} # Close server

shinyApp(ui, server)

