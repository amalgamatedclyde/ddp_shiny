library(shiny)
shinyUI(fluidPage(
  tags$head(
    tags$style(HTML("
h1 {color: firebrick;}
div #rss {margin-left: 60%; margin-top: -400px; margin-left: 70%;}
.col-sm-8 {float:left}                    "
))),
  # Application title
  headerPanel("Polynomial Trend Spotter"),

  # Sidebar with a slider input
  mainPanel(withMathJax(helpText(
  h4("The scatterplot shown below is a polynomial function with normally-distributed noise added to it.
    It has the form: $$y = ax^5 + bx^4 + cx^3 + dx^2 + x + constant +\\epsilon$$
    where epsilon is the noise term and any of the coefficients can be zero."),
  h4(" Can you guess the degree of the polynomial?"),
  p("The side panel can help you check your guess."),
  plotOutput("plot1", height = 600, width = 600),
  tableOutput("rss")))),
  
  sidebarPanel(
    p("You can reduce the noise if detection of the polynomial signal is too difficult. The noise slider 
      changes the standard deviation of the added noise term."),
    sliderInput("sd",
                "Amount of Noise:",
                min = 0,
                max = 1000,
                value = 500,
                step=10),
    p("When you select the 'degree', a linear model will fit a curve to the data using that degree as the highest power term.
      For example, if you set 'degree' to 5 you will build a model that has terms up to x^5. Try to determine which degree best fits
      your noisy polynomial."),
    selectInput("degree", "Predict the degree", c(1:5), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
    p("This button will toggle the display of the fitted curve. How well does it fit the data?"),
    checkboxInput("lm", "Show fitted curve", FALSE),
    p("If you need help, remember the goal is to minmize the residual sum of squares (RSS). This button
      will display the RSS, as well as the degree you chose."),
    checkboxInput("show_rss", "Show RSS", TRUE),
    p("Do you want to see the true curve? This button shows the polynomial to which we added noise."),
    checkboxInput("poly", "Show polynomial", FALSE)
    )
))