#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Question 1:
# As a researcher, you frequently compare mortality rates from particular causes across
# different States. You need a visualization that will let you see (for 2010 only) the crude
# mortality rate, across all States, from one cause (for example, Neoplasms, which are
# effectively cancers). Create a visualization that allows you to rank States by crude mortality
# for each cause of death.


# Question 2: 
# Often you are asked whether particular States are improving their mortality rates (per cause)
# faster than, or slower than, the national average. Create a visualization that lets your clients
# see this for themselves for one cause of death at the time. Keep in mind that the national
# average should be weighted by the national population.


library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)
df <- data %>%
    filter(Year == 2010) %>% 
    group_by(State, ICD.Chapter) %>% 
    summarise(Crude_Mortality = sum(Deaths), 
              Population = sum(Population), 
              Crude_Mortality_Rate = Crude_Mortality / Population * 100000)

ui <- fluidPage(
    titlePanel("States Ranked by Cause of Death"), 
    sidebarLayout(
        sidebarPanel(
            selectInput("COD", "Cause of Death:", 
                        choices = df$ICD.Chapter), 
            hr(), 
            helpText("Data Source: CDC")
    ), 
    mainPanel(
        plotOutput("Crude_Mortality_Plot")
    )
)) 
server <- function(input, output) {
    
    # Fill in the spot we created for a plot
    output$Crude_Mortality_Plot <- renderPlot({
        
        
        # filter data by user input
        if(input$COD != ""){
            df <- filter(df, ICD.Chapter == input$COD)}
        
        # make barplot
        ggplot(df, aes(x = Crude_Mortality_Rate, y = reorder(State, Crude_Mortality_Rate))) +
            geom_col() + 
            labs(title = "Crude Mortality Rate by State", 
                 x = "Crude Rate (Per 100,000)", 
                 y ="State") + 
            
        
        
    }, height = 800, width = 800)
}

shinyApp(ui = ui, server = server)