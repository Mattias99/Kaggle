# Kaggle-project
# ID: Titanic: Machine Learning from Disaster

# Work-order
#  1. Load data
#  2. Evaluate features, quantitative or categorical?
#     2.1 Need of data cleaning?
#     2.2 Count frequencies
#     2.3 Variables with unique values?
#     2.4 Duplicates?
#  3. Missing values?
#     3.1 Possible to use imputation?
#  4. 


#### Packages and set working-directory ####
#setwd("E:/Projekt/R-kod/Kaggle/Titanic/R-Code")

library(plyr)
library(party)
library(ggplot2)
library(GGally)
library(randomForest)
library(rpart) # RandomForest
library(lattice) # Connected to caret-package
library(psych) # Connected to caret-package
library(caret) # ConfusionMatrix
library(Hmisc) # Correlation matrix


#### Import and manipulaton of Data ####

# Load train and test-data. Attach train dataset

train <- read.csv(file = "train.csv", dec = ".")
test <- read.csv(file = "test.csv", dec = ".")

# Inspect summary for abnormal and missing values

summary(train)

# Change response variable to factor
#train$Survived <- as.factor(Survived)


# The Cabin feature contains multiple values and missing values
# Replace missing values with 'None' and convert to factor

train$Cabin <- as.character(train$Cabin)
train$Cabin[train$Cabin == ""] <- "None"
train$Cabin <- as.factor(train$Cabin)

train$Embarked <- as.character(train$Embarked)
train$Embarked[train$Embarked == ""] <- "None"
train$Embarked <- as.factor(train$Embarked)


# Age-variable contain 177 NA-values
# Further investigate if there is any connection between these observations.
# Age might be an important feature to predict the number of survivals
# Imputation can solve this problem.

trainNoMiss <- na.omit(train)
testNoMiss <- na.omit(test)
summary(trainNoMiss)

# Checks if there exists any duplicate observations


#### Plots ####

# Wich variables might be interesting and valueable for predicting survivability

# First plot to verify is the boxplots, an easy way to discover abnormal values

# Correlation matrix, pearson and spearman

rcorr(as.matrix(trainNoMiss[,c(2,3)]),type=c("pearson","spearman"))



# Multiple matrix-plot
# Age, Sex and Parch is important variables for predicting the number of survived passengers

ggscatmat(data = trainNoMiss, color = "Sex")


#### Models ####
# Supervised classification, tree

# Random Forest
trainTree <- cforest(formula = Survived ~ Age + Sex + Parch,
                     data = trainNoMiss)

# Random Forest
trainTree <- randomForest(formula = Survived ~ Age + Sex + Parch,
                          type = classification,
                          data = trainNoMiss)

# Random Forest, rpart library
trainTree <- rpart(formula = Survived ~ Age + Sex + Parch + Pclass,
                   data = trainNoMiss)

# Space for logistic-regression

trainTree <- glm(formula = Survived ~ Age + Sex + Pclass,
                 family = binomial(),
                 data = trainNoMiss)


#### Summary of model ####
summary(trainTree)
print(trainTree)

printcp(trainTree)
rsq.rpart(trainTree)
plot(trainTree)
text(trainTree)

# Predictions
trainPred <- as.numeric(predict(trainTree) > 0.5)
testPred <- as.numeric(predict(trainTree, testNoMiss) > 0.5)
testPred <- as.numeric(predict(trainTree, newdata = testNoMiss) > 0.5) # Used with cforest

# confusionMatrix training dataset
confusionMatrix(data = table(trainPred, trainNoMiss$Survived))

# confusionMatrix test dataset
table(testPred)


