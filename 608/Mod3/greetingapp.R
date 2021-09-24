#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

ui <- fluidPage(
     textInput("name", "What's your name?"),
     numericInput("age", "How old are you?", value = updateNumericInput()),
     textOutput("greeting"),
     textOutput("age")
 )
 
server <- function(input, output, session) {
     output$greeting <- renderText({
         paste0("Hello ", input$name)
     })
     output$age <- renderText({
         paste("Are you really", input$age, "years old")
     })
 }

shinyApp(ui = ui, server = server)


