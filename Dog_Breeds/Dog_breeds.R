# Kaggle-Project
# Dog Breed Identification
# Author: Mattias Karlsson
# Date: 2018-02-06

# Packages

library(imager)
library(dplyr)
library(nnet)
library(h2o)

#### Variables ####

setwd("~/Projekt/R-kod/Kaggle/Dog Breeds/Data")
trPath <- 'train_sample2' # Path to training data. 'train_sample' or 'train' or 'train_sample2'
imageRes <- 64 # Image resolution, 64 x 64
set.seed(123456789)


#### Import data ####

lables <- read.csv(file = 'labels.csv', stringsAsFactors = FALSE) # Lables for each image in training set
#sample_submission <- read.csv(file = 'sample_submission.csv') # Submission format. Probability for each breed.


trName <- list.files(path = trPath, pattern = '.jpg') # Read all file names with .JPG extension
trNamePath <- paste(trPath, trName, sep = '\\') # Locate the right folder
trSampleAll <- lapply(trNamePath, load.image) # Import all images to a list

trSampleAll <- lapply(trNamePath, FUN = function(x){ resize(im=grayscale(load.image(x)),64,64)}) # Import all images to a list
# 6108 elements imported

#### Image manipulations ####



trSampleGray <- lapply(trSampleAll, grayscale) # Convert to grayscale

trSampleSize <- lapply(trSampleGray, # Crop images to the same size
                       FUN = function(x) {
                         resize(im = x, size_x = imageRes, size_y = imageRes)
                         }
                       ) 

#### Data manipulations ####

# Transform to data.frame-objects. Loop over each image
# 

imageF <- function(sample, length){
  
  df <- matrix(nrow = length, ncol = imageRes+1)
  
  for(i in 1:length){
    
    imageVec <- as.vector(sample[[i]][,1]) # Extract the pixels for each image.
    nameVec <- tools::file_path_sans_ext(noquote(trName[i])) # Remove quote and file extension
    
    vec <- c(nameVec, imageVec)
    
    df[i,] <- vec
    
  }
  
  df <- as.data.frame(df, stringsAsFactors = FALSE)
  df <- rename(df, id = V1)
  
  dfLables <- join(x = df, y = lables, by = 'id')  
  
  return(dfLables)
}


trDf <- imageF(sample = trSampleSize, length = length(trSampleAll))

trDf <- imageF(sample = trSampleAll, length = length(trNamePath)) # 'train_sample2'

trDf[, 2:65] <- sapply(trDf[, 2:65], as.numeric) # Convert from character variables to numeric, can be done earlier.


#### Temporary sample with training data ####

trSample <- sample_frac(tbl = trDf,size = 0.5)
teSample <- sample_frac(tbl = trDf,size = 0.5)

# Test manipulations

teSample$breed <- NULL # Remove response variable from test dataset
teSample$id <- NULL # Remove ID variable

# Training manipulations

trSample$id <- NULL # Remove ID variable, no use after join with lables


#### Training with NNET, NNET-package ####


trNnet <- nnet(formula = id ~ ., data = trSample, size = 1, MaxNWts = 500000)


#### Training with h2o, H2O-package ####

# Export training data to csv-file


write.csv(x = noquote(trSample), file = "training_h2o.csv", row.names = FALSE) # Training sample
write.csv(x = noquote(teSample), file = "test_h2o.csv", row.names = FALSE) # Test sample

h2o.init()

h2oTrain <- h2o.importFile(path = 'training_h2o.csv', 
                           destination_frame = 'h2oTrain',
                           col.types = c(rep("int", 64), "factor"))

h2oTest <- h2o.importFile(path = 'test_h2o.csv',
                          destination_frame = 'h2oTest',
                          col.types = c(rep("int", 64), "factor"))

h2o.ls() # Check if files are imported

# Model

h2oModel <- h2o.deeplearning(x = 1:64,
                             y = 'breed',
                             training_frame = h2oTrain,
                             distribution = 'multinomial',
                             model_id = 'h2oModel',
                             l2 = 0.4,
                             ignore_const_cols = FALSE,
                             hidden = 10,
                             export_weights_and_biases = TRUE,
                             validation_frame = h2oTest)
h2oModel

h2o.confusionMatrix(h2oModel, h2oTest)
