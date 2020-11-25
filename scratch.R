library(tidyverse)
library(janitor)
library(nflfastR)
library(glue)

raw <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2020.rds'))

player <- 'R.Jones'

rushing_data <- raw %>%
  filter(rusher == player) 

simple_rushing_table <- rushing_data %>%
  group_by(week) %>%
  summarise(rush_yards = sum(yards_gained),
            rushes = n(),
            yards_per_carry = rush_yards/rushes)

simple_rushing_table

rushing_data %>%
  filter(yards_gained < 80) %>%
  ggplot() +
  geom_histogram(aes(x = yards_gained), binwidth = 1, fill = 'white', color = "blue") +
  scale_x_continuous(limits = c(-8, 30), n.breaks = 25) +
  geom_vline(aes(xintercept = mean(yards_gained)), color = "red") +
  labs(y = "Rushes",
       x = "Yards Gained",
       title = glue::glue("{player} Rush Length Breakdown 2020"))

