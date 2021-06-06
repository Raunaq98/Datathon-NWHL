defensive_weights <- importance2$importance
defensive_weights <- defensive_weights %>% arrange(-Overall)

def_weights <- data.frame(Variable = rownames(defensive_weights))
def_weights$Weight <- defensive_weights$Overall

path_def_weight <- paste0(dir,"/defensive_weights.csv")
write.csv(def_weights,path_def_weight)
