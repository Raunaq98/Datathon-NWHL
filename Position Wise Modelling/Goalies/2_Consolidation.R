# forming a consolidated table

consolidated <- data.frame(id)
colnames(consolidated) <- c("period_id")

consolidated$incompelete_play_Direct <- passes$incomplete_play_Direct[match(consolidated$period_id,passes$period_id)]
consolidated$incompelete_play_Indirect <- passes$incomplete_play_Indirect[match(consolidated$period_id,passes$period_id)]

consolidated$complete_play_Direct <- passes$complete_Direct[match(consolidated$period_id,passes$period_id)]
consolidated$complete_play_Indirect <- passes$compelte_Indirect[match(consolidated$period_id,passes$period_id)]

consolidated$incompelete_play_Total <- passes$incompelte_Total[match(consolidated$period_id,passes$period_id)]
consolidated$complete_play_Total <- passes$complete_Total[match(consolidated$period_id,passes$period_id)]

consolidated$dumps_Lost <- dt_dump_wide$Lost[match(consolidated$period_id,dt_dump_wide$period_id)]
consolidated$dumps_Retained <- dt_dump_wide$Retained[match(consolidated$period_id,dt_dump_wide$period_id)]

consolidated$Puck_Recovery <- dt_puck_recovery$N[match(consolidated$period_id,dt_puck_recovery$period_id)]

consolidated$Take_aways <- dt_takeaway$N[match(consolidated$period_id, dt_takeaway$period_id)]

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
