goalie_weights <- importance$importance
goalie_weights <- goalie_weights %>% arrange(-won)
goalie_weights <- goalie_weights %>% select(-draw_lost)

g_weights$Weight <- goalie_weights$won

path_g_weight <- paste0(dir,"/goalie_weights.csv")
write.csv(g_weights,path_g_weight)
