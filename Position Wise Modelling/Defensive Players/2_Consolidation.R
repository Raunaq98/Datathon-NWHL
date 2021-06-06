# forming a consolidated table

consolidated <- data.frame(id)
colnames(consolidated) <- c("period_id")

consolidated$shot_type_Deflection <- goals$shot_type_Deflection[match(consolidated$period_id,goals$period_id)]
consolidated$shot_type_Fan <- goals$shot_type_Fan[match(consolidated$period_id,goals$period_id)]
consolidated$shot_type_Slapshot <- goals$shot_type_Slapshot[match(consolidated$period_id,goals$period_id)]
consolidated$shot_type_Snapshot <- goals$shot_type_Snapshot[match(consolidated$period_id,goals$period_id)]
consolidated$shot_type_Wrap_Around <- goals$shot_type_Wrap_Around[match(consolidated$period_id,goals$period_id)]
consolidated$shot_type_Wrist_Shot <- goals$shot_type_Wrist_Shot[match(consolidated$period_id,goals$period_id)]

consolidated$shot_dest_On_Net <- goals$shot_dest_On_Net[match(consolidated$period_id,goals$period_id)]
consolidated$shot_dest_Missed <- goals$shot_dest_Missed[match(consolidated$period_id,goals$period_id)]
consolidated$shot_dest_Blocked <- goals$shoot_dest_Blocked[match(consolidated$period_id,goals$period_id)]

consolidated$shot_traffic_TRUE <- goals$traffic_TRUE[match(consolidated$period_id,goals$period_id)]
consolidated$shot_traffic_FALSE <- goals$traffic_FALSE[match(consolidated$period_id,goals$period_id)]

consolidated$shot_one_timer_TRUE <- goals$one_timer_TRUE[match(consolidated$period_id,goals$period_id)]
consolidated$shot_one_timer_FALSE <- goals$one_timer_FALSE[match(consolidated$period_id,goals$period_id)]

consolidated$Unsuccessful_Shots <- goals$Total_Shots[match(consolidated$period_id,goals$period_id)]
consolidated$Goals <- goals$Total_Goals[match(consolidated$period_id,goals$period_id)]

consolidated$incompelete_play_Direct <- passes$incomplete_play_Direct[match(consolidated$period_id,passes$period_id)]
consolidated$incompelete_play_Indirect <- passes$incomplete_play_Indirect[match(consolidated$period_id,passes$period_id)]

consolidated$complete_play_Direct <- passes$complete_Direct[match(consolidated$period_id,passes$period_id)]
consolidated$complete_play_Indirect <- passes$compelte_Indirect[match(consolidated$period_id,passes$period_id)]

consolidated$incompelete_play_Total <- passes$incompelte_Total[match(consolidated$period_id,passes$period_id)]
consolidated$complete_play_Total <- passes$complete_Total[match(consolidated$period_id,passes$period_id)]

consolidated$dumps_Lost <- dt_dump_wide$Lost[match(consolidated$period_id,dt_dump_wide$period_id)]
consolidated$dumps_Retained <- dt_dump_wide$Retained[match(consolidated$period_id,dt_dump_wide$period_id)]

consolidated$faceoffs_Won <- faceoffs$Won[match(consolidated$period_id,faceoffs$period_id)]
consolidated$faceoffs_Lost <- faceoffs$Lost[match(consolidated$period_id,faceoffs$period_id)]

consolidated$Puck_Recovery <- dt_puck_recovery$N[match(consolidated$period_id,dt_puck_recovery$period_id)]

consolidated$penalty_Taken <- penalties$Taken[match(consolidated$period_id,penalties$period_id)]

consolidated$Take_Away <- dt_takeaway$N[match(consolidated$period_id, dt_takeaway$period_id)]

consolidated$zone_entry_Carried <- zone_entry$Carried[match(consolidated$period_id,zone_entry$period_id)]
consolidated$zone_entry_Dumped <- zone_entry$Dumped[match(consolidated$period_id,zone_entry$period_id)]
consolidated$zone_entry_Played <- zone_entry$Played[match(consolidated$period_id,zone_entry$period_id)]


consolidated[is.na(consolidated)] <- 0

dir <- getwd()
path_consolidated <- paste0(dir,"/consolidated_data.csv")
write.csv(consolidated,path_consolidated)


# Preparing outcomes for period wise data

period_data <- Period_Wise_Data

period_data$id1 <- paste(period_data$Date,"-",period_data$Team_1,"-",period_data$Period)
period_data$id2 <- paste(period_data$Date,"-",period_data$Team_2,"-",period_data$Period)

period_data$id1_outcome <- "a"

for(i in 1:length(period_data$id1)){
  if(period_data$Team_1_goals[i] > period_data$Team_2_Goals[i]){
    period_data$id1_outcome[i] <- "won"
  }else{
    period_data$id1_outcome[i] <- "draw_lost"
  }
}

period_data$id2_outcome <- "b"

for(i in 1:length(period_data$id2_outcome)){
  if(period_data$id1_outcome[i] %in% c("won")){
    period_data$id2_outcome[i] <- "draw_lost"
  }else{
    period_data$id2_outcome[i] <- "won"
  }
}


outcome_ids <- data.frame(c(period_data$id1, period_data$id2))
outcomes_all <- data.frame(c(period_data$id1_outcome,period_data$id2_outcome))

outcomes <- data.frame( ids = outcome_ids$c.period_data.id1..period_data.id2.,
                        result = outcomes_all$c.period_data.id1_outcome..period_data.id2_outcome.)

# Adding outcomes to consolidated table

final_data <- consolidated
final_data$Outcome <- outcomes$result[match(final_data$period_id,outcomes$ids)]

path_final_data <- paste0(dir,"/final_data.csv")
write.csv(final_data,path_final_data)
