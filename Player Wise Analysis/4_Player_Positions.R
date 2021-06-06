# mean of coordinates

library(dplyr)

mean_x <- data %>% group_by(Player) %>% summarise(mean(X.Coordinate)) %>% ungroup()
path_mean_x <- paste0(dir,"/mean_x_coord.csv")
write.csv(mean_x,path_mean_x)

mean_y <- data %>% group_by(Player) %>% summarise(mean(Y.Coordinate)) %>% ungroup()
path_mean_y <- paste0(dir,"/mean_y_coord.csv")
write.csv(mean_y, path_mean_y)


# adding to consolidated table

consolidated$Mean_x <- mean_x$`mean(X.Coordinate)`[match(consolidated$Player,mean_x$Player)]
consolidated$Mean_y <- mean_y$`mean(Y.Coordinate)`[match(consolidated$Player,mean_y$Player)]

# added classes

positions <- function(x){
  out <- NULL
  if( x <50){
    out <- c("Goalie")
  }else if( x >=50 && x<=100){
    out <- c("Defensive")
  }else{
    out <- c("Offensive")
  }
  out
}

position_data <- consolidated[1:126,]
position_data$Position <- sapply(position_data$Mean_x, positions)

path_positions <- paste0(dir,"/data_with_positions.csv")
write.csv(position_data,path_positions)


# visualising

library(ggplot2)
library(ggforce)

myColors <- c("#FF00DBFF", "#4900FFFF", "#FFDB00FF")

gg1 <- ggplot(position_data, aes( x = Mean_x, y = Mean_y, colour = Position))
pp1 <- gg1 + geom_point(size=2) + coord_cartesian(xlim=c(0,200), ylim = c(0,80)) +
  scale_color_manual(values=myColors)+
  labs( x = "X-coordinate", y ="Y-coordinate", title = "NWHL Player Positions") +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  
  geom_vline( xintercept = 0) + geom_vline( xintercept = 200) +
  geom_hline( yintercept = 0) + geom_hline( yintercept =  80) +
  
  geom_segment( aes(x = 100, xend= 100, y=0, yend=80), colour = "red", linetype=2) +
  
  geom_segment( aes(x = 75, xend= 75, y=0, yend=80), colour = "blue") +
  geom_segment( aes(x = 125, xend= 125, y=0, yend=80), colour = "blue") +
  geom_segment( aes(x = 11, xend= 11, y=0, yend=80), colour = "red") +
  geom_segment( aes(x = 189, xend= 189, y=0, yend=80), colour = "red")+
  
  geom_segment( aes(x = 11, xend= 11, y=37, yend=43), colour = "black",  size = 2)+
  geom_segment( aes(x = 8, xend= 8, y=37, yend=43),  colour = "black",  size = 2)+
  geom_segment( aes(x = 8, xend= 11, y=37, yend=37),  colour = "black",  size = 2)+
  geom_segment( aes(x = 8, xend= 11, y=43, yend=43),  colour = "black",  size = 2)+
  
  geom_segment( aes(x = 189, xend= 189, y=37, yend=43), colour = "black",  size = 2)+
  geom_segment( aes(x = 192, xend= 192, y=37, yend=43), colour = "black",  size = 2)+
  geom_segment( aes(x = 192, xend= 189, y=37, yend=37), colour = "black",  size = 2)+
  geom_segment( aes(x = 192, xend= 189, y=43, yend=43), colour = "black",  size = 2)+
  
  geom_circle(aes(x0 = 100, y0 = 40, r=15), inherit.aes = FALSE, colour = "blue")+
  geom_circle(aes(x0 = 32, y0 = 60, r=15), inherit.aes = FALSE, colour = "red")+
  geom_circle(aes(x0 = 158, y0 = 60, r=15), inherit.aes = FALSE, colour = "red")+
  geom_circle(aes(x0 = 32, y0 = 20, r=15), inherit.aes = FALSE, colour = "red")+
  geom_circle(aes(x0 = 158, y0 = 20, r=15), inherit.aes = FALSE, colour = "red")+
  
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
pp1
