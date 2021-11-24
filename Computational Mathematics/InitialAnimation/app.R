#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Animation of Initials ZP"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        x  <- c(seq(-1,0,length.out =500), seq(-1,0,length.out =500), seq(-1,0,length.out =500), # Shows the letter Z
                       rep(2,500), rep(1,500), seq(1,2,length.out = 500), seq(1,2,length.out = 500),
                       rep(1, 500) # Shows the letter P
        y <- c(rep(-1,500),seq(-1,1,length.out=500), rep(1,500), # Shows the letter Z
                       seq(0,1,length.out = 500),seq(0,1, length.out = 500), rep(1,500),rep(0,500),
                       seq(-1,1,length.out = 500) # Shows the letter P
                )
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        plot(x, y)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

x11()
x <- c(seq(-1,0,length.out =500), seq(-1,0,length.out =500), seq(-1,0,length.out =500), # Shows the letter Z
       rep(2,500), rep(1,500), seq(1,2,length.out = 500), seq(1,2,length.out = 500),
       rep(1, 500) # Shows the letter P
)
y <- c(rep(-1,500),seq(-1,1,length.out=500), rep(1,500), # Shows the letter Z
       seq(0,1,length.out = 500),seq(0,1, length.out = 500), rep(1,500),rep(0,500),
       seq(-1,1,length.out = 500) # Shows the letter P
)
z <- rbind(x,y)
xA <- function(x,y){
    x %*% y
}
# Shear
for (i in seq(0,3, length.out = 12)) {
    id_m  <- 1L * i
    shear <- (x * i) + (y * id_m)
    plot(shear~x,
         xlim=c(-5,5), ylim=c(-6,6))
}
# Scale
for (i in seq(1,3, length.out = 12)){
    id_m <- 1L * i
    scale_y <- y * id_m
    scale_x <- x * id_m
    plot(scale_y~scale_x,
         xlim=c(-5,5), ylim=c(-6,6))
}
# Rotate
for (i in seq(0, 2*pi, length.out = 12)) {
    rotated <- apply(z, 2, function(x)
        xA(x, matrix(c(
            cos(i), -sin(i), sin(i), cos(i)), ncol = 2,nrow = 2)))
    plot(rotated[2,]~rotated[1,],
         xlim=c(-5,5), ylim=c(-6,6))
}
# Project
for (i in seq(0, 2*pi, length.out = 12)) {
    proj <- rbind(z, rep(0, ncol(z)))
    projected <- apply(proj, 2, function(x)
        xA(x, matrix(c(1, 0, 0, 0,
                       cos(i), -sin(i), 0, sin(i), cos(i)), ncol = 3, nrow = 3)))
    plot(projected[2,]~projected[1,],
         xlim=c(-5,5), ylim=c(-6,6))
}
