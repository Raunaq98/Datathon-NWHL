# getting feature names and weights
offensive_features <- as.vector(offensive_weights$Variable)
off_weights <- as.vector(offensive_weights$Weight)

# subsetting for required features
off1 <- offensive_players %>% select(Player,Matches,offensive_features)
off2 <- off1 %>% select(-1,-2)

# multiplying weights
off3 <- data.frame(mapply("*",off2,off_weights))

# nowise sum
off3 <- off3 %>%
  replace(is.na(.), 0) %>%
  mutate(sum = rowSums(across(where(is.numeric))))

#forming ratings table
offensive_rating <- data.frame(cbind(off1$Player,off1$Matches, off3$sum))
names(offensive_rating) <- c("Player","Matches","weighted_sum")

# changing to numeric type (mapply changes to character)
offensive_rating$weighted_sum <- as.numeric(offensive_rating$weighted_sum)
offensive_rating$Matches <- as.numeric(offensive_rating$Matches)

# dividing weighted sum by matches to get a standard value
offensive_rating$Sum_by_match <- offensive_rating$weighted_sum/offensive_rating$Matches

# normalising the rating between 0 and 10
offensive_rating$Rating <- ( (offensive_rating$Sum_by_match - min(offensive_rating$Sum_by_match))/(max(offensive_rating$Sum_by_match)-min(offensive_rating$Sum_by_match))*10)

# subsetting for name and rating 
ratings_offensive_players <- offensive_rating %>% select(Player,Rating) %>% arrange(-Rating)

# saving
path_offensive_ratings <- paste0(getwd(),"/offensive_ratings.csv")
write.csv(ratings_offensive_players,path_offensive_ratings)
