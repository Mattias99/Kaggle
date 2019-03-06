# Kaggle project
# Store Item Demand Forecasting Challenge
# Author: Mattias Karlsson
# Date: 2019-01-07

#### PACKAGE ####


library("lintr")
library("tidyverse")
library("ggplot2")
library("ggcorrplot")
library("mice")
library("lubridate")
library("tseries") # Dickey-Fuller test


#### VARIABLES ####


#setwd("E:/Projekt/R-kod/Kaggle/Kaggle/Store_Item_Demand_Forecasting_Challenge")
setwd("~/Projekt/R/Kaggle/Store_Item_Demand_Forecasting_Challenge")

data <- "src/data/data.R"
trans <- "src/features/transform.R"
plot <- "src/visualization/plot.R"


#### MAIN ####


source(data)
source(trans)
source(plot)


#### lintr ####


lintr::lint(data)
lintr::lint(trans)
lintr::lint(plot)