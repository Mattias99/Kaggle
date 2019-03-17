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
library("magrittr")
library("Metrics")
library("forecast")


#### VARIABLES ####


#setwd("E:/Projekt/R-kod/Kaggle/Kaggle/Store_Item_Demand_Forecasting_Challenge")
setwd("~/Projekt/R/Kaggle/Store_Item_Demand_Forecasting_Challenge")

data <- "src/data/data.R"
trans <- "src/features/transform.R"
plot <- "src/visualization/plot.R"
analyzes <- "src/features/analyzes.R"
model_arima <- "src/models/arima.R"


#### MAIN ####


source(data)
source(trans)
source(analyzes)
source(plot)
source(model_arima)

#### lintr ####


lintr::lint(data)
lintr::lint(trans)
lintr::lint(analyzes)
lintr::lint(plot)
lintr::lint(model_arima)