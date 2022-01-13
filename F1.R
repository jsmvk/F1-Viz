# colnames(pit_strategy) <- c("driverId", "stop", "lap", "duration")
# 
# colnames(ham) <- c("driverId", "lap", "position", "time", "name", "year", "surname")
# 
# colnames(ver) <- c("driverId", "lap", "position", "time", "name", "year", "surname")
# 
# colnames(fastest_lap_2019) <- c("time","name", "year")

setwd("~/Srodowisko R/Projekt_F1")

library(dplyr)
library(lubridate)
library(ggplot2)
library(ggpubr)
library(readr)
library(forecast)
library(tidyverse)
library(ggfortify)
library(datasets)
library(scatterplot3d)
library(plotly)
# library(seasonal)

# install.packages("plotly")

#plots

ver_ham_time
ros_ham_forecast
fastest_laps_2019_plot 

#######

comments <- c("broken front wing on lap 22", "tire compound change")

pit_strategy <- mutate(pit_strategy, comment = comments)

#lap times plot (Hamilton/Verstappen Austria 2019)

ver_ham_time <- ggplot() +
  geom_line(ver, mapping = aes(x = lap, y = time, color = "ver")) +
  geom_point(ver, mapping = aes(x = lap, y = time, color = "ver")) +
  geom_line(ham, mapping = aes(x = lap, y = time, color = "ham")) +
  geom_point(ham, mapping = aes(x = lap, y = time, color = "ham")) +
  scale_color_manual(values = c("ham" = "darkblue", "ver" = "darkorange")) +
  labs(color = "drivers") +
  ggtitle("Verstappen/Hamilton laps on Austrian GP 2019")

#championship position forecast based on historical data (up to 9th round) in 2014 season

points_2014 <- read_csv("points_2014.csv", 
                        col_names = c("points", "round", "driver", "name"))

ros_ham_points <- points_2014 %>% 
  filter(driver == c("Hamilton", "Rosberg"))

#tried to make time series forecast but points are not seasonal


#ros_ham_points$points <- ros_ham_points[, "points"]

# ros_ham_points$points %>% #must be a vector
#   ts(., start=0, end=165, frequency=10)
# 
# seas(ros_ham_points$points)
# 
# ros_ham_points$points %>%
#   stlf(lambda = 0, h = 18) %>%
#   autoplot()

# ros_ham_historical <- ggplot(ros_ham_points, aes(x = round, y = points, color = driver)) +
#     geom_line() +
#     ylim(0, 200) +
#     scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9)) +
#     ggtitle("First half of 2014 F1 Championship battle") +
#     labs(color = "legend") +
#     scale_color_manual(values = c("Hamilton" = "green", 
#                                   "Rosberg" = "darkblue"))

ros_ham_forecast <- ggplot(ros_ham_points, aes(x = round, y = points, color = driver)) +
        geom_line() +
        #geom_point() +
        geom_forecast(inherit.aes = TRUE,
                  stat = "forecast",
                  position = "identity",
                  showgap = FALSE, 
                  PI = FALSE,
                  show.legend = TRUE) +
        ggtitle("2014 F1 Championship battle forecast") +
        geom_vline(aes(xintercept = 9, color = "9th round/Forecast border")) +
        labs(color = "legend") +
        scale_color_manual(values = c("9th round/Forecast border" = "Grey", 
                                      "Hamilton" = "green", 
                                      "Rosberg" = "darkblue"))

ros_ham_forecast <- ros_ham_forecast + 
  ylim(80, 400) +
  scale_x_continuous(breaks = c(3, 6, 9, 12, 15, 18)) 

# championship_battle_2014 <- ggarrange(ros_ham_historical, ros_ham_forecast)

#top 5 fastest laps 2019
# x_axis <- gsub("Grand Prix","", fastest_lap_2019$name)

top_5_fastest <- fastest_lap_2019 %>%
  group_by(time) %>% 
  arrange(time) %>% 
  ungroup %>% 
  slice(1:5)

top_5_fastest$name <- factor(top_5_fastest$name, levels = top_5_fastest$name[order(top_5_fastest$time)])

fastest_laps_2019_plot <- ggplot(top_5_fastest, aes(x = name, y = time, fill = name)) +
          geom_bar(stat = "identity", width = 0.3) +
          labs(fill = "GP") +
          scale_fill_brewer(palette = "Accent") +
          scale_x_discrete(labels = c("Verstappen",
                                      "Bottas",
                                      "Bottas",
                                      "Gasly",
                                      "Verstappen")) +
          ggtitle(" Top 5 Fastest laps 2019 season") +
          theme(axis.title.x = element_blank())

 


