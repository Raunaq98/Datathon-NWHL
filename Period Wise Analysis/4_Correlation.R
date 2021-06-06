#Correlations

correlation_data <- final_data %>% select(-1)

correlation_data$result <- 0
for(i in 1:length(correlation_data$Outcome)){
  if(correlation_data$Outcome[i] %in% "won"){
    correlation_data$result[i] <- 1
  }else{
    correlation_data$result[i] <- 0
  }
}
correlation_data <- correlation_data %>% select(-30)  # removing outcome character
correlation_data <- correlation_data %>% select(-Goals)

library(corrplot)

corrplot(cor(correlation_data, use = "complete.obs"),
         method = "pie")


