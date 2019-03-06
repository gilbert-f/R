library(shiny)
library(dplyr)
library(scatterD3)

filename <- 'data/cereal.tsv'
ds <- as.data.frame(read.delim(filename, stringsAsFactors = FALSE,
                               header = TRUE))
colnames(ds) <- c('Name',	'Manufacturer',	'Type',	'Calories',
                  'Protein',	'Fat',	'Sodium',	'Fiber',	
                  'Carbohydrates',	'Sugars',	'Potassium',
                  'Vitamins',	'Shelf', 'Weight', 'Cups',	'Rating')
ds <- ds %>% 
  mutate(Name = gsub("_", " ", Name)) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'A', 
                                'American Home Food Products')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'G', 
                                'General Mills')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'K', 
                                'Kelloggs')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'N', 
                                'Nabisco')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'P', 
                                'Post')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'Q', 
                                'Quaker Oats')) %>%
  mutate(Manufacturer = replace(Manufacturer, Manufacturer == 'R', 
                                'Ralston Purina')) %>%
  mutate(Type = replace(Type, Type == 'C',
                        'Cold')) %>%
  mutate(Type = replace(Type, Type == 'H', 
                        'Hot')) 

function(input, output) {
  output$x_axis <- renderUI({
    selectInput("x", "x variable:",
                choices=c(colnames(ds[4:16])),
                selected = "Calories")
  })
  
  output$y_axis <- renderUI({
    selectInput("y", "y variable:", 
                choices=c(colnames(ds[4:16])),
                selected = "Protein")
  })
  
  output$color <- renderUI({
    selectInput("color", "color:", 
                choices=c(colnames(ds[2:16])),
                selected = "Manufacturer")
  })
  
  data <- reactive({
    ds[1:input$obs,]
  })
  
  output$cerealPlot <- renderScatterD3({
    scatterD3(x = data()[,input$x], 
              y = data()[,input$y], 
              lab = data()[,'Name'],
              xlab = input$x,
              ylab = input$y,
              col_var = data()[,input$color], 
              col_lab = input$color,
              symbol_var = data()[,'Type'],
              symbol_lab = 'Type',
              point_opacity = input$pointAlpha,
              point_size = input$pointSize,
              labels_size = input$labelSize,
              transitions = input$transitions
    )
  })
}