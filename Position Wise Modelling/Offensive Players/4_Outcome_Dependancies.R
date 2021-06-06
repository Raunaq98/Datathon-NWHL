library(caret)

class_data <- final_data[,-c(1,16)]   # removing id and goals

# Normalization
class_data_ranged_model <- preProcess(class_data,
                                      method = "range")
class_data_ranged <- predict(class_data_ranged_model, class_data)


class_data_ranged$Outcome <- as.factor(class_data_ranged$Outcome)

## BOXPLOTS 
featurePlot(x = class_data_ranged[, 1:28], 
            y = class_data_ranged$Outcome, 
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")))
