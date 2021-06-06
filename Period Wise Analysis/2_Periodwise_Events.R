# imported "data_V1_25.05" as"data"

library(dplyr)
library(caret)
library(data.table)

temp <- data


library(data.table)
dt <- data.table(data)

dt$period_id <- paste(dt$game_date,"-",dt$Team,"-",dt$Period)


dt_player_event <- dt[, .N, by =.(period_id,Event)]
dt_detail1 <- dt[, .N, by =.(period_id,Event, Detail.1)]
dt_detail2 <- dt[, .N, by=.(period_id,Event, Detail.2)]
dt_detail3 <- dt[, .N, by=.(period_id,Event, Detail.3)]
dt_detail4 <- dt[, .N, by=.(period_id, Event, Detail.4)]

id <- unique(dt$period_id)

# Goals

shots_and_goals <- dt_player_event %>% filter(Event %in% c("Shot","Goal"))
shots_and_goals_wide <- dcast(shots_and_goals, period_id ~ Event, value.var = "N")

shot_type <- dt_detail1 %>% filter(Event %in% c("Shot"))
shot_type <- shot_type %>% select(-Event)
shot_type_wide <- dcast(shot_type, period_id~Detail.1, value.var = "N")

shot_dest <- dt_detail2 %>% filter( Event %in% c("Shot"))
shot_dest <- shot_dest %>% select(-Event)
shot_dest_wide  <- dcast(shot_dest, period_id~Detail.2, value.var = "N")

shot_traffic <- dt_detail3 %>% filter( Event %in% c("Shot"))
shot_traffic <- shot_traffic %>% select(-Event)
shot_traffic_wide <- dcast(shot_traffic, period_id~Detail.3, value.var = "N")

shot_one_timer <- dt_detail4 %>% filter( Event %in% c("Shot"))
shot_one_timer <- shot_one_timer %>% select(-Event)
shot_one_timer_wide <- dcast(shot_one_timer, period_id~Detail.4, value.var = "N")

goals <- data.frame(id)
colnames(goals) <- c("period_id")
goals$shot_type_Deflection <- shot_type_wide$Deflection[match(goals$period_id,shot_type_wide$period_id)]
goals$shot_type_Fan <- shot_type_wide$Fan[match(goals$period_id,shot_type_wide$period_id)]
goals$shot_type_Slapshot <- shot_type_wide$Slapshot[match(goals$period_id,shot_type_wide$period_id)]
goals$shot_type_Snapshot <- shot_type_wide$Snapshot[match(goals$period_id,shot_type_wide$period_id)]
goals$shot_type_Wrap_Around <- shot_type_wide$`Wrap Around`[match(goals$period_id,shot_type_wide$period_id)]
goals$shot_type_Wrist_Shot <- shot_type_wide$Wristshot[match(goals$period_id, shot_type_wide$period_id)]

goals$shot_dest_On_Net <- shot_dest_wide$`On Net`[match(goals$period_id,shot_dest_wide$period_id)]
goals$shot_dest_Missed <- shot_dest_wide$Missed[match(goals$period_id,shot_dest_wide$period_id)]
goals$shoot_dest_Blocked <- shot_dest_wide$Blocked[match(goals$period_id,shot_dest_wide$period_id)]

goals$traffic_TRUE <- shot_traffic_wide$t[match(goals$period_id, shot_traffic_wide$period_id)]
goals$traffic_FALSE <- shot_traffic_wide$f[match(goals$period_id, shot_traffic_wide$period_id)]

goals$one_timer_TRUE <- shot_one_timer_wide$t[match(goals$period_id, shot_one_timer_wide$period_id)]
goals$one_timer_FALSE <- shot_one_timer_wide$f[match(goals$period_id, shot_one_timer_wide$period_id)]

goals$Total_Shots <- shots_and_goals_wide$Shot[match(goals$period_id, shots_and_goals_wide$period_id)]
goals$Total_Goals <- shots_and_goals_wide$Goal[match(goals$period_id,shots_and_goals_wide$period_id)]



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


# Face-offs

dt_faceoff <- dt_player_event %>% filter( Event %in% c("Faceoff Win"))


faceoffs <- data.frame(id)
colnames(faceoffs) <- c("period_id")

faceoffs$Won <- dt_faceoff$N[match(faceoffs$period_id, dt_faceoff$period_id)]


# Take-aways

dt_takeaway <- dt_player_event %>% filter(Event %in% c("Takeaway"))



# Puck Recovery

dt_puck_recovery <- dt_player_event %>% filter(Event %in% c("Puck Recovery"))



# Dump-In


dt_dump <- dt_detail1 %>% filter( Event %in% c("Dump In/Out"))
dt_dump <- dt_dump %>% select(-Event)
dt_dump_wide <- dcast(dt_dump, period_id ~ Detail.1 , value.var = "N")



# Penalties

dt_penalty <- dt_player_event %>% filter( Event %in% c("Penalty Taken"))


penalties <-  data.frame(id)
colnames(penalties) <- c("period_id")

penalties$Taken <- dt_penalty$N[match(penalties$period_id,dt_penalty$period_id)]



# Zone Entry

dt_zone <- dt_detail1 %>% filter( Event %in% c("Zone Entry"))
dt_zone <- dt_zone %>% select( -Event)
dt_zone_wide <- dcast(dt_zone, period_id ~ Detail.1, value.var = "N")

zone_entry <- data.frame(id)
colnames(zone_entry) <- c("period_id")

zone_entry$Carried <- dt_zone_wide$Carried[match(zone_entry$period_id, dt_zone_wide$period_id)]
zone_entry$Dumped <- dt_zone_wide$Dumped[match(zone_entry$period_id,dt_zone_wide$period_id)]
zone_entry$Played <- dt_zone_wide$Played[match(zone_entry$period_id, dt_zone_wide$period_id)]


