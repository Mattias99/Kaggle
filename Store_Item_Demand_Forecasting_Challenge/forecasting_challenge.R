# Kaggle project
# Store Item Demand Forecasting Challenge
# Author: Mattias Karlsson
# Date: 2018-07-15

#### PACKAGE ####

library("lintr")
library("tidyverse")
library("ggplot2")
library("ggcorrplot")


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

# Preparation before correlogram is used

train_wide <- spread(train, store, sales)

train_group <- spread(train, store, sales) %>%
  select(-date) %>%
  rename_all(paste0, "_store") %>%
  group_by(item_store) %>%
  summarise_all(funs(sum))

cor_group <- cor(train_group[, -1])

#### GGPLOT ####


ggcorrplot(cor_group,
           type = "lower",
           hc.order = FALSE,
           lab = TRUE,
           lab_size = 3,
           method = "circle",
           colors = c("tomato2", "white", "springgreen3"),
           ggtheme = theme_bw,
           title = "Correlogram of Sales")
