# imported data_V1_25-05 as "data"

library(dplyr)
library(caret)
library(data.table)

data$match_id <- paste(data$game_date,"-",data$Home.Team)
data$match_Period_id <- paste(data$game_date,"-",data$Home.Team,"-",data$Period)

temp <- data %>% group_by(match_Period_id) %>% slice(which.min(Seconds.Elapsed)) %>% ungroup()
temp2 <- temp %>% group_by(match_Period_id) %>% mutate( Team_1_goals = sum(Home.Team.Goals), Team_2_Goals = sum(Away.Team.Goals)) %>%
  select(Date = game_date, Team_1 = Home.Team, Team_1_goals, Team_2 = Away.Team, Team_2_Goals, Period) %>% ungroup()

dir<- getwd()

# Period Wise Data
Period_Wise_Data <- temp2 %>% select(Date, Period, Team_1, Team_2, Team_1_goals, Team_2_Goals)
path_period <- paste0(dir,"/period_wise.csv")
write.csv(Period_Wise_Data, path_period)


# Match Wise Data
temp2$Match_id <- paste(temp2$Date,"-",temp2$Team_1)
temp3 <- temp2 %>% group_by(Match_id)  %>% slice(which.max(Period)) %>% ungroup()
Match_Wise_Data <- temp3 %>% select(Date, Team_1, Team_2, Team_1_goals, Team_2_Goals)
path_match <- paste0(dir,"/match_wise.csv")
write.csv(Match_Wise_Data, path_match)
