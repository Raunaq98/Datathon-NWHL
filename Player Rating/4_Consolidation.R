# offensive players consolidated table

offensive_consolidated <- offensive_players
offensive_consolidated <- offensive_consolidated %>% select(-1)
offensive_consolidated$Rating <- ratings_offensive_players$Rating[match(offensive_consolidated$Player,ratings_offensive_players$Player)]

path_offensive_consolidated <- paste0(getwd(),"/offensive_consolidated.csv")
write.csv(offensive_consolidated,path_offensive_consolidated)

# defensive players consolidated table

defensive_consolidated <- defensive_players
defensive_consolidated <- defensive_consolidated %>% select(-1)
defensive_consolidated$Rating <- ratings_defensive_players$Rating[match(defensive_consolidated$Player, ratings_defensive_players$Player)]

path_defensive_consolidated <- paste0(getwd(),"/defensive_consolidated.csv")
write.csv(defensive_consolidated,path_defensive_consolidated)

# goalie consolidated table

goalie_consolidated <- goalie_players
goalie_consolidated <- goalie_consolidated %>% select(-1)
goalie_consolidated$Rating <- ratings_goalie_players$Rating[match(goalie_consolidated$Player,ratings_goalie_players$Player)]

path_goalie_consolidated <- paste0(getwd(),"/goalie_consolidated.csv")
write.csv(goalie_consolidated,path_goalie_consolidated)


# final table with positions and ratings

data_with_ratings_and_positions <- data.frame(rbind(offensive_consolidated, defensive_consolidated, goalie_consolidated))

path_overall_consolidated <- paste0(getwd(),"/data_with_ratings_and_positions.csv")
write.csv(data_with_ratings_and_positions, path_overall_consolidated)
