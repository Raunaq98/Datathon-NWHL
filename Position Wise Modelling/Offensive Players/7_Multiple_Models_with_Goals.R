class_data2 <- modeling_data[,-1]

preproc <- c("center","scale")

control <- trainControl(method = "cv",
                        number = 10)

control2 <- trainControl(method="repeatedcv", number=20, repeats = 20,
                         verbose = TRUE, search = "grid",
                         savePredictions = 'final',
                         classProbs = T,
                         summaryFunction=twoClassSummary)

performance_metric <- "Accuracy"

LDA2 <- train( Outcome~.,
               class_data2,
               method="lda",
               metric = performance_metric,
               trControl = control2,
               preProcess = preproc)

CART2 <- train( Outcome~.,
                class_data2,
                method="rpart",
                metric = performance_metric,
                trControl = control2,
                preProcess = preproc)

SVM2 <- train( Outcome~.,
               class_data2,
               method="svmRadial",
               metric = performance_metric,
               trControl = control2,
               preProcess = preproc)

RF2 <- train( Outcome~.,
              class_data2,
              method="rf",
              metric = performance_metric,
              trControl = control2,
              preProcess = preproc)

Decision_Tree_C52 <- train( Outcome~.,
                            class_data2,
                            method="C5.0",
                            metric = performance_metric,
                            trControl = control2,
                            preProcess = preproc)

Naive2 <- train( class_data2[,1:20],
                 class_data2$Outcome,
                 method="nb",
                 metric = performance_metric,
                 trControl = control2,
                 preProcess = preproc)

NN2 <- train( class_data2[,1:20],
              class_data2$Outcome,
              method="nnet",
              metric = performance_metric,
              trControl = control2,
              preProcess = preproc)

results2 <- resamples(list(Linear_Discriminant_Analysis = LDA2,  
                           CART_Analysis = CART2, 
                           SVM_Radial = SVM, RF_Analysis = RF2,
                           Decision_Tree_C_Analysis = Decision_Tree_C52,
                           Naive_Bayes = Naive, Neural_Network = NN2))

ggplot(results2) + 
  labs(y = "Accuracy") + 
  theme_bw()

importance2 <- varImp(RF2, scale = FALSE)
plot(importance2)

