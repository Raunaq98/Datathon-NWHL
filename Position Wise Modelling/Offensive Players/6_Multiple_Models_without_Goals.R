library(dplyr)
library(caret)

class_data <- modeling_data[,c(-1,-12)]

preproc <- c("center","scale")

control <- trainControl(method = "cv",
                        number = 10)

control2 <- trainControl(method="repeatedcv", number=20, repeats = 20,
                         verbose = TRUE, search = "grid",
                         savePredictions = 'final',
                         classProbs = T,
                         summaryFunction=twoClassSummary)

performance_metric <- "Accuracy"

LDA <- train( Outcome~.,
              class_data,
              method="lda",
              metric = performance_metric,
              trControl = control2,
              preProcess = preproc)

CART <- train( Outcome~.,
               class_data,
               method="rpart",
               metric = performance_metric,
               trControl = control2,
               preProcess = preproc)

SVM <- train( Outcome~.,
              class_data,
              method="svmRadial",
              metric = performance_metric,
              trControl = control2,
              preProcess = preproc)

RF <- train( Outcome~.,
             class_data,
             method="rf",
             metric = performance_metric,
             trControl = control2,
             preProcess = preproc)

Decision_Tree_C5 <- train( Outcome~.,
                           class_data,
                           method="C5.0",
                           metric = performance_metric,
                           trControl = control2,
                           preProcess = preproc)

Naive <- train( class_data[,1:20],
                class_data$Outcome,
                method="nb",
                metric = performance_metric,
                trControl = control2,
                preProcess = preproc)

NN <- train( class_data[,1:20],
             class_data$Outcome,
             method="nnet",
             metric = performance_metric,
             trControl = control2,
             preProcess = preproc)

results <- resamples(list(Linear_Discriminant_Analysis = LDA,  
                          CART_Analysis = CART, 
                          SVM_Radial = SVM, RF_Analysis = RF,
                          Decision_Tree_C_Analysis = Decision_Tree_C5,
                          Naive_Bayes = Naive, Neural_Network = NN))

ggplot(results) + 
  labs(y = "Accuracy") + 
  theme_bw()

importance <- varImp(RF, scale = FALSE)
plot(importance)
