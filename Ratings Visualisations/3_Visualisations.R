gg_goals <- team_data %>% ggplot(aes(x=Rating, y = goals_per_match)) + 
  geom_point(colour= "red", size = 2.5)+
  xlim(4.5,6.2)+
  ylim(0,5) +
  theme_bw()+
  geom_smooth(method = "lm")+
  labs( x = "Team Rating", y = "Goals per Match")
gg_goals


gg_passes <- team_data %>% ggplot(aes(x=Rating, y = completed_passes_per_match)) + 
  geom_point(colour= "red", size = 2.5)+
  xlim(4.5,6.2)+
  ylim(50,350) +
  theme_bw()+
  geom_smooth(method = "lm")+
  labs( x = "Team Rating", y = "Passes Completed per Match")
gg_passes

team_data$pass_completion <- team_data$Play/(team_data$`Incomplete Play` + team_data$Play)*100
gg_pass_completion <- team_data %>% ggplot(aes(x=Rating, y = pass_completion)) + 
  geom_point(colour= "red", size = 2.5)+
  xlim(4.5,6.2)+
  ylim(35,100)+
  theme_bw()+
  geom_smooth(method = "lm")+
  labs( x = "Team Rating", y = "Pass Completion Percentage")
gg_pass_completion


library(gridExtra)
grid.arrange(gg_goals,gg_passes,gg_pass_completion, ncol= 3)

