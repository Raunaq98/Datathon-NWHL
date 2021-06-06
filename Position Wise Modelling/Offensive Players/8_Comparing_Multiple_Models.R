library(gridExtra)

grid.arrange(plot(importance2, main = "Feature Importance including Goals"),
             plot(importance, main = "Feature Importance excluding Goals"), nrow=2)


grid.arrange(ggplot(results2) + 
               labs(y = "Accuracy", title = "Model Accuracy with Goals") + 
               theme_bw(),
             ggplot(results) + 
               labs(y = "Accuracy", title = "Model Accuracy without Goals") + 
               theme_bw(),
             ncol = 2)
