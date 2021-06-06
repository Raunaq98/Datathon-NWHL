# imported "data_V1_25.05"
# imported "final_data_with_position

library(dplyr)
library(caret)
library(ggplot2)
library(data.table)


data <- data_V1_25.05
position_data <- Final_data_with_positions %>% select(-1)

data$Position <- position_data$Position[match(data$Player, position_data$Player)]

dt2 <- data.table(data)

dt <- dt2 %>% filter( Position %in% c("Goalie"))
dt <- dt %>% select(-Position)

dt$period_id <- paste(dt$game_date,"-",dt$Team,"-",dt$Period)



#####################################################

data$match_id <- paste(data$game_date,"-",data$Home.Team)
data$match_Period_id <- paste(data$game_date,"-",data$Home.Team,"-",data$Period)

temp <- data %>% group_by(match_Period_id) %>% slice(which.min(Seconds.Elapsed)) %>% ungroup()
temp2 <- temp %>% group_by(match_Period_id) %>% mutate( Team_1_goals = sum(Home.Team.Goals), Team_2_Goals = sum(Away.Team.Goals)) %>%
  select(Date = game_date, Team_1 = Home.Team, Team_1_goals, Team_2 = Away.Team, Team_2_Goals, Period) %>% ungroup()

dir<- getwd()

# Period Wise Data
Period_Wise_Data <- temp2 %>% select(Date, Period, Team_1, Team_2, Team_1_goals, Team_2_Goals)

# Match Wise Data
temp2$Match_id <- paste(temp2$Date,"-",temp2$Team_1)
temp3 <- temp2 %>% group_by(Match_id)  %>% slice(which.max(Period)) %>% ungroup()
Match_Wise_Data <- temp3 %>% select(Date, Team_1, Team_2, Team_1_goals, Team_2_Goals)


########################################################################


dt_player_event <- dt[, .N, by =.(period_id,Event)]
dt_detail1 <- dt[, .N, by =.(period_id,Event, Detail.1)]
dt_detail2 <- dt[, .N, by=.(period_id,Event, Detail.2)]
dt_detail3 <- dt[, .N, by=.(period_id,Event, Detail.3)]
dt_detail4 <- dt[, .N, by=.(period_id, Event, Detail.4)]

id <- unique(dt$period_id)



# Passes

passes_and_misses <- dt_player_event %>% filter( Event %in% c("Play","Incomplete Play") )
passes_and_misses_wide <- dcast(passes_and_misses, period_id~Event, value.var = "N")

play_direct_indirect <- dt_detail1 %>% filter(Event %in% c("Play"))
play_direct_indirect <- play_direct_indirect %>% select(-Event)
plays <- dcast(play_direct_indirect, period_id~Detail.1, value.var = "N")

incomplete_plays_direct_indirect <- dt_detail1 %>% filter(Event %in% c("Incomplete Play"))
incomplete_plays_direct_indirect <- incomplete_plays_direct_indirect %>% select(-Event)
incomplete_plays <- dcast(incomplete_plays_direct_indirect, period_id~Detail.1, value.var = "N")

passes <- data.frame(id)
colnames(passes) <- c("period_id")

passes$incomplete_play_Direct <- incomplete_plays$Direct[match(passes$period_id, incomplete_plays$period_id)]
passes$incomplete_play_Indirect <- incomplete_plays$Indirect[match(passes$period_id, incomplete_plays$period_id)]
passes$incompelte_Total <- passes_and_misses_wide$`Incomplete Play`[match(passes$period_id,passes_and_misses_wide$period_id)]

passes$complete_Direct <- plays$Direct[match(passes$period_id,plays$period_id)]
passes$compelte_Indirect <- plays$Indirect[match(passes$period_id,plays$period_id)]
passes$complete_Total <- passes_and_misses_wide$Play[match(passes$period_id,passes_and_misses_wide$period_id)]


# Take-aways

dt_takeaway <- dt_player_event %>% filter(Event %in% c("Takeaway"))


# Puck Recovery

dt_puck_recovery <- dt_player_event %>% filter(Event %in% c("Puck Recovery"))


# Dump-In

dt_dump <- dt_detail1 %>% filter( Event %in% c("Dump In/Out"))
dt_dump <- dt_dump %>% select(-Event)
dt_dump_wide <- dcast(dt_dump, period_id ~ Detail.1 , value.var = "N")








