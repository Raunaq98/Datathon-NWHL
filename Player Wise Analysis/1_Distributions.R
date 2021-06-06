# NWHL Data
# 26882 Rows X 21 Columns
# handled clock in excel by splitting into seconds and minutes


# importing "data_V1_25-05" as original data
data <- original_data

# Adding "NAs"
data[data == ""] <- NA

# Correcting date and time
library(lubridate)
data$game_date <- dmy(data$game_date)

# Removing Clock column as it was handled in excel
library(dplyr)
data <- data %>% select(-Clock)

# exploring
library(skimr)
skim_eda <- skim_to_wide(data)
dir<- getwd()
path_eda<- paste0(dir,"/eda.csv")
write.csv(skim_eda,path_eda)

event_dist <- data %>% count(Event)
path_event <- paste0(dir,"/event_distribution.csv")
write.csv(event_dist,path_event)

event_det1_dist <- data %>% count(Event, Detail.1)
path_event_det1 <- paste0(dir,"/event_detail1_distribution.csv")
write.csv(event_det1_dist,path_event_det1)

event_det2_dist <- data %>% count(Event, Detail.2)
path_event_det2 <- paste0(dir,"/event_detail2_distribution.csv")
write.csv(event_det2_dist,path_event_det2)

event_det3_dist <- data %>% count(Event, Detail.3)
path_event_det3 <- paste0(dir,"/event_detail3_distribution.csv")
write.csv(event_det3_dist,path_event_det3)

event_det4_dist <- data %>% count(Event, Detail.4)
path_event_det4 <- paste0(dir,"/event_detail4_distribution.csv")
write.csv(event_det4_dist,path_event_det4)

# Unique Player Names
players <- c(data$Player, data$Player.2)    # combined list
unique_players <- unique(players)           # subsetted list
player_names <- data.frame(unique(players)) # subsetted df
path_players <- paste0(dir,"/player_names.csv")
write.csv(player_names,path_players)

