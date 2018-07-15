# MNIST handwritten digits

#### PACKAGE ####

library(caret) 
library(xgboost)
library(xgbTree)

#### PARAMETERS ####

setwd("E:/Projekt/R-kod/Kaggle/MNIST digits")
set.seed(12345)



#### IMPORT DATA ####

train <- read.csv(file = 'Data/train.csv', colClasses = c("label" = "factor"))
test <- read.csv(file = 'Data/test.csv')

#### MODEL ####

trControl = trainControl(method = 'cv',
                         number = 2,
                         verboseIter = TRUE,
                         allowParallel = TRUE)

tuneGridXGB <- expand.grid(nrounds=c(350),
                           max_depth = c(4, 6),
                           eta = c(0.05, 0.1),
                           gamma = c(0.01),
                           colsample_bytree = c(0.75),
                           subsample = c(0.50),
                           min_child_weight = c(0))

start <- Sys.time() # Run-time
start


trainCaret <- train(label ~ .,
                    data = train,
                    method = 'xgbTree',
                    trControl = trControl)

paste0('Start: ', start)
paste0('End: ', Sys.time())
paste0('Runtime: ', Sys.time() - start)




#### EVALUATION ####

plot(trainCaret)

testCaret <- predict(trainCaret, newdata = test)

confusionMatrix(trainCaret)


#### SUBMISSION ####

submission <- data.frame("ImageID" = 1:28000, "Label" = testCaret)

write.csv(x = submission, file = 'Submission/Submission.csv',row.names = FALSE)


