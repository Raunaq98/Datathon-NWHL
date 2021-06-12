library(dplyr)
library(data.table)
library(ggplot2)
library(tidyr)
library(caret)


# imported "data_V1_25.05"

data <- data_V1_25.05

# imported "data_with_ratings_and_positions"

rating_data <- data_with_ratings_and_positions
rating_data <- rating_data %>% select(-1)

# adding ratings to raw data

data$rating <- rating_data$Rating[match(data$Player,rating_data$Player)]

# mean rating for each time

dt <- data.table(data)
team_ratings <- dt[,mean(rating),by=.(Team)]
names(team_ratings) <- c("Team","Rating")
team_ratings <- team_ratings %>% arrange(-Rating)

# saving

path_team_ratings <- paste0(getwd(),"/team_ratings.csv")
write.csv(team_ratings,path_team_ratings)
