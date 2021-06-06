
# forming a consolidated table

consolidated <- player_names
colnames(consolidated) <- c("Player")

consolidated$Matches <- matches_played$n[match(consolidated$Player,matches_played$Player)]

consolidated$shot_type_Deflection <- goals$shot_type_Deflection[match(consolidated$Player,goals$Player)]
consolidated$shot_type_Fan <- goals$shot_type_Fan[match(consolidated$Player,goals$Player)]
consolidated$shot_type_Slapshot <- goals$shot_type_Slapshot[match(consolidated$Player,goals$Player)]
consolidated$shot_type_Snapshot <- goals$shot_type_Snapshot[match(consolidated$Player,goals$Player)]
consolidated$shot_type_Wrap_Around <- goals$shot_type_Wrap_Around[match(consolidated$Player,goals$Player)]
consolidated$shot_type_Wrist_Shot <- goals$shot_type_Wrist_Shot[match(consolidated$Player,goals$Player)]

consolidated$shot_dest_On_Net <- goals$shot_dest_On_Net[match(consolidated$Player,goals$Player)]
consolidated$shot_dest_Missed <- goals$shot_dest_Missed[match(consolidated$Player,goals$Player)]
consolidated$shot_dest_Blocked <- goals$shoot_dest_Blocked[match(consolidated$Player,goals$Player)]

consolidated$shot_traffic_TRUE <- goals$traffic_TRUE[match(consolidated$Player,goals$Player)]
consolidated$shot_traffic_FALSE <- goals$traffic_FALSE[match(consolidated$Player,goals$Player)]

consolidated$shot_one_timer_TRUE <- goals$one_timer_TRUE[match(consolidated$Player,goals$Player)]
consolidated$shot_one_timer_FALSE <- goals$one_timer_FALSE[match(consolidated$Player,goals$Player)]

consolidated$Unsuccessful_Shots <- goals$Total_Shots[match(consolidated$Player,goals$Player)]
consolidated$Goals <- goals$Total_Goals[match(consolidated$Player,goals$Player)]

consolidated$incompelete_play_Direct <- passes$incomplete_play_Direct[match(consolidated$Player,passes$Player)]
consolidated$incompelete_play_Indirect <- passes$incomplete_play_Indirect[match(consolidated$Player,passes$Player)]

consolidated$complete_play_Direct <- passes$complete_Direct[match(consolidated$Player,passes$Player)]
consolidated$complete_play_Indirect <- passes$compelte_Indirect[match(consolidated$Player,passes$Player)]

consolidated$incompelete_play_Total <- passes$incompelte_Total[match(consolidated$Player,passes$Player)]
consolidated$complete_play_Total <- passes$complete_Total[match(consolidated$Player,passes$Player)]

consolidated$dumps_Lost <- dt_dump_wide$Lost[match(consolidated$Player,dt_dump_wide$Player)]
consolidated$dumps_Retained <- dt_dump_wide$Retained[match(consolidated$Player,dt_dump_wide$Player)]

consolidated$faceoffs_Won <- faceoffs$Won[match(consolidated$Player,faceoffs$Player)]
consolidated$faceoffs_Lost <- faceoffs$Lost[match(consolidated$Player,faceoffs$Player)]

consolidated$Puck_Recovery <- dt_puck_recovery$N[match(consolidated$Player,dt_puck_recovery$Player)]

consolidated$penalty_Taken <- penalties$Taken[match(consolidated$Player,penalties$Player)]
consolidated$penalty_Given <- penalties$Given[match(consolidated$Player,penalties$Player)]

consolidated$zone_entry_Carried <- zone_entry$Carried[match(consolidated$Player,zone_entry$Player)]
consolidated$zone_entry_Dumped <- zone_entry$Dumped[match(consolidated$Player,zone_entry$Player)]
consolidated$zone_entry_Played <- zone_entry$Played[match(consolidated$Player,zone_entry$Player)]
consolidated$zone_entry_Target <- zone_entry$Targetted[match(consolidated$Player,zone_entry$Player)]

consolidated[is.na(consolidated)] <- 0

player_wise_data <- consolidated[1:126,]
path_player_wise <- paste0(dir,"/player_wise_data.csv")
write.csv(player_wise_data,path_player_wise)

summary_data <- skim_to_wide(player_wise_data)
path_summary <-paste0(dir,"/summary_data.csv")
write.csv(summary_data,path_summary)
