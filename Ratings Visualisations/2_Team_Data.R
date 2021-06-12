# event distribution per team

teamwise_events<- dt[,.N, by=.(Team,Event)]
teamwise_events <- teamwise_events %>% arrange(Team)

teamwise_wide <- dcast(teamwise_events, Team~Event, value.var = "N")

team_matches <- dt[,.N,by=.(Team,game_date)]
matches <- team_matches %>% count(Team)
  
team_data <- teamwise_wide
team_data$Matches <- matches$n[match(team_data$Team,matches$Team)]
team_data$Rating <- team_ratings$Rating[match(team_data$Team,team_ratings$Team)]

team_data <- team_data %>% mutate( dumps_per_match = `Dump In/Out`/Matches,
                                   faceoff_wins_per_match = `Faceoff Win`/Matches,
                                   goals_per_match = Goal/Matches,
                                   Incomplete_passes_per_match = `Incomplete Play`/Matches,
                                   penalties_per_match = `Penalty Taken`/Matches,
                                   completed_passes_per_match = Play/Matches,
                                   puck_recoveries_per_match = `Puck Recovery`/Matches,
                                   takeaways_per_match = Takeaway/Matches,
                                   zone_entries_per_match = `Zone Entry`/Matches)

path_team_data <-paste0(getwd(),"/team_data.csv")
write.csv(team_data,path_team_data)
