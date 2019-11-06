#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# set slider min and max before the app runs 
min.carat <- min(diamonds$carat)
max.carat <- max(diamonds$carat)

# Define UI for application that draws a histogram
# every input and output has a name ex output$
ui <- fluidPage(

    # Application title
    titlePanel("Diamonds data set viewer"),
    #actionButton("do", "Click me"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("carat.adjuster",
                        "Carats",
                        min = min.carat,
                        max = max.carat,
                        value = c(min.carat, max.carat)),
            
            submitButton(text = "apply")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("diamonds_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    
    d_filt <- reactive({
        
        low.carat <- input$carat.adjuster[1]
        hi.carat <- input$carat.adjuster[2]
        
        
        #d_filt <- diamonds %>%
        diamonds %>%
            filter(carat >= low.carat) %>%
            filter(carat <= hi.carat)
        
    })

    output$diamonds_plot <- renderPlot({
        
        # filter the dimaonds plot so that it only ocntains the specified range 
       
        # look at radio buttons and switch statements 
        
        ggplot(d_filt(), aes_string(x="carat", y="y", color = "clarity")) +
            geom_point()
        # generate bins based on input$bins from ui.R
        #x    <- faithful[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
