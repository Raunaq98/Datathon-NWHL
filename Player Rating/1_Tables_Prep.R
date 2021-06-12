# imported final_data_with_positions

library(dplyr)
library(caret)
library(ggplot2)
library(data.table)
library(tidyr)


data <- Final_data_with_positions

offensive_players <- data %>% filter( Position %in% c("Offensive"))
defensive_players <- data %>% filter( Position %in% c("Defensive"))
goalie_players <- data %>% filter( Position %in% c("Goalie"))


# imported weights

offensive_weights <- offensive_weights %>% select(-1)
defensive_weights <- defensive_weights %>% select(-1)
goalie_weights <- goalie_weights %>% select(-1)


