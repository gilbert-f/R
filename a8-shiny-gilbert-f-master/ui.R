library(shiny)
library(scatterD3)

fluidPage(
  titlePanel("Cereal Dataset"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "number of observations:",
                  value = 10, min = 1, max = 77,
                  step = 1),
      uiOutput("x_axis"),
      uiOutput("y_axis"),
      uiOutput("color"),
      sliderInput("pointSize", "point size:",
                  value = 50, min = 0, max = 100,
                  step = 0.1),
      sliderInput("pointAlpha", "alpha:",
                  value = 0.7, min = 0, max = 1,
                  step = 0.1),
      sliderInput("labelSize", "label size:",
                  value = 11, min = 0, max = 25,
                  step = 1),
      checkboxInput("transitions", "use transitions:", 
                    value = TRUE),
      hr(),
      helpText("Data available at many grocery stores.")
    ),
    
    mainPanel(
      scatterD3Output("cerealPlot", height = "600px")
    )
  )
)