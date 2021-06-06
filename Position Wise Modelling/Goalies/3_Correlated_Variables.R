library(dplyr)
library(tidyr)

correlated_vars <- cor(final_data[,c(-1,-11)]) %>% as.data.frame() %>%
  mutate( Var1 = rownames(.)) %>%
  gather( Var2, value, -Var1) %>%
  arrange(desc(value)) %>%
  group_by(value) %>%
  filter(row_number() == 1)

remove_cor <- correlated_vars %>% filter( value >= 0.7)

remove_cor_names <- c(unique(remove_cor$Var1), unique(remove_cor$Var2))
remove_cor_names <- unique(remove_cor_names)                      

remove <- c( "complete_play_Direct",
             "complete_play_Indirect",
             "incompelete_play_Direct",
             "incompelete_play_Total",
             "incompelete_play_Indirect")


modeling_data <- final_data %>% select(-remove)
