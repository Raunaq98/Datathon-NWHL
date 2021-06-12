# getting feature names and weights
goalie_features <- c("Puck_Recovery","Take_Away","dumps_Lost","complete_play_Total")
gol_weights <- as.vector(goalie_weights$Weight)

# subsetting for required features
gol1 <- goalie_players %>% select(Player,Matches,goalie_features)
gol2 <- gol1 %>% select(-1,-2)

# multiplying weights
gol3 <- data.frame(mapply("*",gol2,gol_weights))

# nowise sum
gol3 <- gol3 %>%
  replace(is.na(.), 0) %>%
  mutate(sum = rowSums(across(where(is.numeric))))

#forming ratings table
goalie_rating <- data.frame(cbind(gol1$Player,gol1$Matches, gol3$sum))
names(goalie_rating) <- c("Player","Matches","weighted_sum")

# changing to numeric type (mapply changes to character)
goalie_rating$weighted_sum <- as.numeric(goalie_rating$weighted_sum)
goalie_rating$Matches <- as.numeric(goalie_rating$Matches)

# dividing weighted sum by matches to get a standard value
goalie_rating$Sum_by_match <- goalie_rating$weighted_sum/goalie_rating$Matches

# normalising the rating between 0 and 10
goalie_rating$Rating <- ( (goalie_rating$Sum_by_match - min(goalie_rating$Sum_by_match))/(max(goalie_rating$Sum_by_match)-min(goalie_rating$Sum_by_match))*10)

# subsetting for name and rating 
ratings_goalie_players <- goalie_rating %>% select(Player,Rating) %>% arrange(-Rating)

# saving
path_goalie_ratings <- paste0(getwd(),"/goalie_ratings.csv")
write.csv(ratings_goalie_players,path_goalie_ratings)
