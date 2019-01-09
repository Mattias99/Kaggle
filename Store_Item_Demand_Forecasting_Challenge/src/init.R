# Kaggle project
# Store Item Demand Forecasting Challenge
# Author: Mattias Karlsson
# Date: 2019-01-07

#### PACKAGE ####


library("lintr")
library("tidyverse")
library("ggplot2")
library("ggcorrplot")


#### VARIABLES ####


#setwd("E:/Projekt/R-kod/Kaggle/Kaggle/Store_Item_Demand_Forecasting_Challenge")
setwd("~/Projekt/R/Kaggle/Store_Item_Demand_Forecasting_Challenge")


#### MAIN ####


source("src/data/data.R")
source("src/features/transform.R")
source("src/visualization/plot.R")


#### lintr ####


lintr::lint("src/data/data.R")
lintr::lint("src/features/transform.R")
lintr::lint("src/visualization/plot.R")