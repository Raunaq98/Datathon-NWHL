# getting feature names and weights
defensive_features <- as.vector(defensive_weights$Variable)
def_weights <- as.vector(defensive_weights$Weight)

# subsetting for required features
def1 <- defensive_players %>% select(Player,Matches,defensive_features)
def2 <- def1 %>% select(-1,-2)

# multiplying weights
def3 <- data.frame(mapply("*",def2,def_weights))

# nowise sum
def3 <- def3 %>%
  replace(is.na(.), 0) %>%
  mutate(sum = rowSums(across(where(is.numeric))))

#forming ratings table
defensive_rating <- data.frame(cbind(def1$Player,def1$Matches, def3$sum))
names(defensive_rating) <- c("Player","Matches","weighted_sum")

# changing to numeric type (mapply changes to character)
defensive_rating$weighted_sum <- as.numeric(defensive_rating$weighted_sum)
defensive_rating$Matches <- as.numeric(defensive_rating$Matches)

# dividing weighted sum by matches to get a standard value
defensive_rating$Sum_by_match <- defensive_rating$weighted_sum/defensive_rating$Matches

# normalising the rating between 0 and 10
defensive_rating$Rating <- ( (defensive_rating$Sum_by_match - min(defensive_rating$Sum_by_match))/(max(defensive_rating$Sum_by_match)-min(defensive_rating$Sum_by_match))*10)

# subsetting for name and rating 
ratings_defensive_players <- defensive_rating %>% select(Player,Rating) %>% arrange(-Rating)

# saving
path_defensive_ratings <- paste0(getwd(),"/defensive_ratings.csv")
write.csv(ratings_defensive_players,path_defensive_ratings)
