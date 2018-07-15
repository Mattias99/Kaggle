# Kaggle project
# Store Item Demand Forecasting Challenge
# Author: Mattias Karlsson
# Date: 2018-07-15

#### PACKAGE ####


library("tidyverse")
library("lintr")


#### VARIABLES ####


setwd("E:/Projekt/R-kod/Kaggle/Kaggle/Store_Item_Demand_Forecasting_Challenge")


#### IMPORT ####


train <- read_csv(file = "data/train.csv")
test <- read_csv(file = "data/test.csv")


##### DATA TRANSFORMATION ####

example <- train %>%
  group_by(store) %>%
  summarise(numItems = n_distinct(item))
example


#### GGPLOT ####


