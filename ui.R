library(shiny)
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Polynomial Trend Spotter"),
  
  # Sidebar with a slider input
  sidebarPanel(
    sliderInput("sd",
                "Amount of Noise:",
                min = 0,
                max = 1000,
                value = 500,
                step=10),
    numericInput("degree", "Predict the degree", value=5, min = 1, max = 5, step = 1),
    checkboxInput("lm", "Show fitted curve", FALSE),
    checkboxInput("poly", "Show polynomial", FALSE)
    ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("plot1")
  )
))