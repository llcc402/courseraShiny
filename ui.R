library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
        headerPanel("Classification of The Iris Data Set"),
        
        sidebarPanel(
                numericInput("seed", "Seed:", value = 10, min = 1, max = 10000),
                helpText("Please choose a seed between 1 and 10000."),
                
                br(),
                
                sliderInput("prop", "Training Percentage:", value = 0.6, min = .1,
                            max = .9, step = .1),            
                helpText("Please choose the percentage of data for training."),
                
                br(),
                
                selectInput("method", "Method:", choices = 
                                    c("k-Nearest Neighbors" = "knn",
                                      "Neural Network" = "nnet",
                                      "Classification and Regression Tree" = "rpart")),
                helpText("Please choose a method for classification"),
                
                submitButton("Submit"),
                
                br(),
                helpText(a("Click here to see the code of ui.R and server.R",
                           target = "_blank",
                           href = "http://www.baidu.com"))
        ),
        
        mainPanel(
                tabsetPanel(
                        tabPanel(
                                "Data Summary",
                                
                                h4("Summary"),
                                verbatimTextOutput("summary"),
                
                                h4("Feature plot"),
                                plotOutput("featureplot")
                        ),
                        tabPanel(
                                "Classification",
                                h4("The trained model"),
                                verbatimTextOutput("fit"),
                                
                                h4("The performance of the trained model on the 
                                   testing data"),
                                verbatimTextOutput("result")
                        )
                )
        )
)) 