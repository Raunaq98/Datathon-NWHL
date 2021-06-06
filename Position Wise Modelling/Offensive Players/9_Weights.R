offensive_weights <- importance2$importance
offensive_weights <- offensive_weights %>% arrange(-Overall)

off_weights <- data.frame(Variable = rownames(offensive_weights))
off_weights$Weight <- offensive_weights$Overall

path_off_weight <- paste0(dir,"/offensive_weights.csv")
write.csv(off_weights,path_off_weight)
