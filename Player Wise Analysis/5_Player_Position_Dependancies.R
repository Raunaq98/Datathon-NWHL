library(caret)

class_data <- position_data %>% select(-(1:2),-(35:36)) # removinf name, matches, x-y coordinates

# Normalization
class_data_ranged_model <- preProcess(class_data,
                                      method = "range")
class_data_ranged <- predict(class_data_ranged_model, class_data)


class_data_ranged$Position <- as.factor(class_data_ranged$Position)

## BOXPLOTS 
featurePlot(x = class_data_ranged[, 1:32], 
            y = class_data_ranged$Position, 
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")))
