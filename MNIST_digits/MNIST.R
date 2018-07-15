# MNIST handwritten digits

#### PACKAGE ####

library(ggplot2) # Data visualization
library(randomForest) # Random Forest
library(lattice) # Connected to caret-package
library(psych) # Connected to caret-package
library(caret) # ConfusionMatrix

#### PARAMETERS ####

setwd("E:/Projekt/R-kod/Kaggle/MNIST digits")
set.seed(12345)



#### IMPORT DATA ####

train <- read.csv(file = 'Data/train.csv')
test <- read.csv(file = 'Data/test.csv')

#### MODEL ####

trainTree <- randomForest(y = train$label, # Not advised to use formula with 
                          x = train[,c(2:785)],
                          maxnodes = 6,
                          replace = FALSE,
                          keep.forest = FALSE)

#### EVALUATION ####



#### SUBMISSION ####

write.csv(x = submission, file = 'Submission/Submission.csv',row.names = FALSE)


