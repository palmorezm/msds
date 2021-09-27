#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

mort <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)

# create subset with just 2010 data
mort_2010 <- subset(mort, Year == "2010")

# group by state and disease, with new variables showing the sum of deaths & pop in that grouping
mort_2010 <- mort_2010 %>%
    group_by(State, ICD.Chapter) %>%
    summarize(tot_deaths = sum(Deaths), tot_pop = sum(Population))

# create new variable crude_rate to recalculate the crude rate at this grouping level
mort_2010$crude_rate <- round((mort_2010$tot_deaths / mort_2010$tot_pop) * 100000, 4)

# Use a fluid Bootstrap layout
ui <- fluidPage(    
    
    # Give the page a title
    titlePanel("Crude Mortality Rates by Cause in 2010, by State"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            selectInput("cause", "Cause:", 
                        choices=mort_2010$ICD.Chapter),
            hr(),
            helpText("Taken from the CDC.")
        ),
        
        # Create a spot for the barplot
        mainPanel(
            plotOutput("crude_plot")  
        )
        
    )
)
# Define a server for the Shiny app
server <- function(input, output) {
    
    # Fill in the spot we created for a plot
    output$crude_plot <- renderPlot({
        
        
        # filter data by user input
        if(input$cause != ""){
            mort_2010 <- filter(mort_2010, ICD.Chapter == input$cause)}
        
        # make barplot
        ggplot(mort_2010, aes(x = crude_rate, y = reorder(State, crude_rate))) +
            geom_bar(stat = "identity") + 
            labs(title = "2010 Crude Mortality Rates, by State", 
                 x = "Crude Rate (Per 100,000)", 
                 y ="State")
        
        
    }, height = 800, width = 800)
}

# Run the application 
shinyApp(ui = ui, server = server)
