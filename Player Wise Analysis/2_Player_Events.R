
library(data.table)
dt <- data.table(data)

dt_player_event <- dt[, .N, by =.(Player,Event)]
dt_detail1 <- dt[, .N, by =.(Player,Event, Detail.1)]
dt_detail2 <- dt[, .N, by=.(Player,Event, Detail.2)]
dt_detail3 <- dt[, .N, by=.(Player,Event, Detail.3)]
dt_detail4 <- dt[, .N, by=.(Player, Event, Detail.4)]

# Goals

shots_and_goals <- dt_player_event %>% filter(Event %in% c("Shot","Goal"))
shots_and_goals_wide <- dcast(shots_and_goals, Player ~ Event, value.var = "N")

shot_type <- dt_detail1 %>% filter(Event %in% c("Shot"))
shot_type <- shot_type %>% select(-Event)
shot_type_wide <- dcast(shot_type, Player~Detail.1, value.var = "N")

shot_dest <- dt_detail2 %>% filter( Event %in% c("Shot"))
shot_dest <- shot_dest %>% select(-Event)
shot_dest_wide  <- dcast(shot_dest, Player~Detail.2, value.var = "N")

shot_traffic <- dt_detail3 %>% filter( Event %in% c("Shot"))
shot_traffic <- shot_traffic %>% select(-Event)
shot_traffic_wide <- dcast(shot_traffic, Player~Detail.3, value.var = "N")

shot_one_timer <- dt_detail4 %>% filter( Event %in% c("Shot"))
shot_one_timer <- shot_one_timer %>% select(-Event)
shot_one_timer_wide <- dcast(shot_one_timer, Player~Detail.4, value.var = "N")

goals <- player_names
colnames(goals) <- c("Player")
goals$shot_type_Deflection <- shot_type_wide$Deflection[match(goals$Player,shot_type_wide$Player)]
goals$shot_type_Fan <- shot_type_wide$Fan[match(goals$Player,shot_type_wide$Player)]
goals$shot_type_Slapshot <- shot_type_wide$Slapshot[match(goals$Player,shot_type_wide$Player)]
goals$shot_type_Snapshot <- shot_type_wide$Snapshot[match(goals$Player,shot_type_wide$Player)]
goals$shot_type_Wrap_Around <- shot_type_wide$`Wrap Around`[match(goals$Player,shot_type_wide$Player)]
goals$shot_type_Wrist_Shot <- shot_type_wide$Wristshot[match(goals$Player, shot_type_wide$Player)]

goals$shot_dest_On_Net <- shot_dest_wide$`On Net`[match(goals$Player,shot_dest_wide$Player)]
goals$shot_dest_Missed <- shot_dest_wide$Missed[match(goals$Player,shot_dest_wide$Player)]
goals$shoot_dest_Blocked <- shot_dest_wide$Blocked[match(goals$Player,shot_dest_wide$Player)]

goals$traffic_TRUE <- shot_traffic_wide$t[match(goals$Player, shot_traffic_wide$Player)]
goals$traffic_FALSE <- shot_traffic_wide$f[match(goals$Player, shot_traffic_wide$Player)]

goals$one_timer_TRUE <- shot_one_timer_wide$t[match(goals$Player, shot_one_timer_wide$Player)]
goals$one_timer_FALSE <- shot_one_timer_wide$f[match(goals$Player, shot_one_timer_wide$Player)]

goals$Total_Shots <- shots_and_goals_wide$Shot[match(goals$Player, shots_and_goals_wide$Player)]
goals$Total_Goals <- shots_and_goals_wide$Goal[match(goals$Player,shots_and_goals_wide$Player)]

path_shots_and_goals <- paste0(dir,"/goals.csv")
write.csv(goals,path_shots_and_goals)



# Passes

passes_and_misses <- dt_player_event %>% filter( Event %in% c("Play","Incomplete Play") )
passes_and_misses_wide <- dcast(passes_and_misses, Player~Event, value.var = "N")

play_direct_indirect <- dt_detail1 %>% filter(Event %in% c("Play"))
play_direct_indirect <- play_direct_indirect %>% select(-Event)
plays <- dcast(play_direct_indirect, Player~Detail.1, value.var = "N")

incomplete_plays_direct_indirect <- dt_detail1 %>% filter(Event %in% c("Incomplete Play"))
incomplete_plays_direct_indirect <- incomplete_plays_direct_indirect %>% select(-Event)
incomplete_plays <- dcast(incomplete_plays_direct_indirect, Player~Detail.1, value.var = "N")

passes <- player_names
colnames(passes) <- c("Player")

passes$incomplete_play_Direct <- incomplete_plays$Direct[match(passes$Player, incomplete_plays$Player)]
passes$incomplete_play_Indirect <- incomplete_plays$Indirect[match(passes$Player, incomplete_plays$Player)]
passes$incompelte_Total <- passes_and_misses_wide$`Incomplete Play`[match(passes$Player,passes_and_misses_wide$Player)]

passes$complete_Direct <- plays$Direct[match(passes$Player,plays$Player)]
passes$compelte_Indirect <- plays$Indirect[match(passes$Player,plays$Player)]
passes$complete_Total <- passes_and_misses_wide$Play[match(passes$Player,passes_and_misses_wide$Player)]

path_passes <- paste0(dir,"/passes.csv")
write.csv(passes,path_passes)



# Matches played by a player

dt_player_matches <- dt[, .N, by=.(Player, game_date)]  # gives entries of a player per match
matches_played <- dt_player_matches %>% count(Player)

path_match_count <- paste0(dir,"/player_matches.csv")
write.csv(matches_played,path_match_count)



# Face-offs

dt_faceoff <- dt_player_event %>% filter( Event %in% c("Faceoff Win"))

dt_faceofflost <- data %>% select(Player.2, Event) %>% filter( Event %in% c("Faceoff Win"))
dt_2 <- data.table(dt_faceofflost)
dt_faceoff_lost <- dt_2[, .N, by=.(Player.2)]

faceoffs <- player_names
colnames(faceoffs) <- c("Player")
faceoffs$Won <- dt_faceoff$N[match(faceoffs$Player, dt_faceoff$Player)]
faceoffs$Lost <- dt_faceoff_lost$N[match(faceoffs$Player,dt_faceoff_lost$Player.2)]
faceoffs[is.na(faceoffs)] <- 0

path_faceoff <- paste0(dir,"/faceoffs.csv")
write.csv(faceoffs, path_faceoff)



# Take-aways

dt_takeaway <- dt_player_event %>% filter(Event %in% c("Takeaway"))

path_takeaway <- paste0(dir,"/takeaway.csv")
write.csv(dt_takeaway,path_takeaway)



# Puck Recovery

dt_puck_recovery <- dt_player_event %>% filter(Event %in% c("Puck Recovery"))

path_recovery <- paste0(dir,"/puck_recovery.csv")
write.csv(dt_puck_recovery, path_recovery)



# Dump-In

dt_detail1 <- dt[, .N, by =.(Player,Event, Detail.1)]

dt_dump <- dt_detail1 %>% filter( Event %in% c("Dump In/Out"))
dt_dump <- dt_dump %>% select(-Event)
dt_dump_wide <- dcast(dt_dump, Player ~ Detail.1 , value.var = "N")

path_dump <- paste0(dir,"/dumps.csv")
write.csv(dt_dump_wide,path_dump)



# Penalties

dt_penalty <- dt_player_event %>% filter( Event %in% c("Penalty Taken"))

dt_penaltygiven <- data %>% select(Player.2, Event) %>% filter( Event %in% c("Penalty Taken"))
dt_3 <- data.table(dt_penaltygiven)
dt_penalty_given <- dt_3[, .N, by=.(Player.2)]

penalties <- player_names
colnames(penalties) <- c("Player")
penalties$Taken <- dt_penalty$N[match(penalties$Player,dt_penalty$Player)]
penalties$Given <- dt_penalty_given$N[match(penalties$Player,dt_penalty_given$Player.2)]

path_penalty <- paste0(dir,"/penalties.csv")
write.csv(penalties,path_penalty)



# Zone Entry

dt_zone <- dt_detail1 %>% filter( Event %in% c("Zone Entry"))
dt_zone <- dt_zone %>% select( -Event)
dt_zone_wide <- dcast(dt_zone, Player ~ Detail.1, value.var = "N")

dt_zone_target <- data %>% select(Player.2, Event) %>% filter( Event %in% c("Zone Entry"))
dt_4 <- data.table(dt_zone_target)
dt_zone_targetted <- dt_4[, .N, by=.(Player.2)]

zone_entry <- player_names
colnames(zone_entry) <- c("Player")
zone_entry$Carried <- dt_zone_wide$Carried[match(zone_entry$Player, dt_zone_wide$Player)]
zone_entry$Dumped <- dt_zone_wide$Dumped[match(zone_entry$Player,dt_zone_wide$Player)]
zone_entry$Played <- dt_zone_wide$Played[match(zone_entry$Player, dt_zone_wide$Player)]
zone_entry$Targetted <- dt_zone_targetted$N[match(zone_entry$Player, dt_zone_targetted$Player.2)]

path_zone <- paste0(dir,"/zone_entry.csv")
write.csv(zone_entry,path_zone)


