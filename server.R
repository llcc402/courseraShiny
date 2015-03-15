library(shiny)
library(ggplot2)
library(lattice)
library(caret)
library(rpart)
library(nnet)

shinyServer(function(input,output){
        data(iris)
        
        result <- reactive({
                method <- switch(input$method,
                                 "knn" = "knn",
                                 "nnet" = "nnet",
                                 "rpart" = "rpart")
                
                ## set the seed
                set.seed(input$seed)
                
                ## create training and testing data 
                inTrain <- createDataPartition(iris$Species, p = input$prop, 
                                               list = FALSE)
                training <- iris[inTrain, ]
                testing <- iris[-inTrain, ]
                
                ## train the model
                if(method == "nnet"){
                        fit <- train(Species ~ ., data = training, method = method,
                                     trace = FALSE)
                }else{
                        fit <- train(Species ~ ., data = training, method = method)
                }
                        
                ## predict the classes of the testing data
                predict <- predict(fit, testing[,1:4])
                
                ## compare the prediction with the true classes
                result <- confusionMatrix(predict, testing$Species)
                
                return(list(fit = fit,result = result))
        })
                
        
        ## The output
        output$summary <- renderPrint(summary(iris))
        
        output$featureplot <- renderPlot(featurePlot(iris[,1:4], iris[,5], 
                                                     plot = "pairs"))
        
        
        output$fit <- renderPrint(result()$fit)
        
        output$result <- renderPrint(result()$result)
})