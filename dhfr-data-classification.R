####################################
# Farhan Rahman                    #
# http://github.com/frh02          #
####################################
# Importing libraries
library(datasets) # Contains the Iris data set
library(caret) # Package for machine learning algorithms / CARET stands for Classification And REgression Training

# Importing the Iris data set
data(dhfr)

# Check to see if there are missing data?
sum(is.na(dhfr))

# To achieve reproducible model; set the random seed number
set.seed(100)

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(dhfr$Y, p=0.8, list = FALSE)
TrainingSet <- dhfr[TrainingIndex,] # Training Set
TestingSet <- dhfr[-TrainingIndex,] # Test Set

# Compare scatter plot of the 80 and 20 data subsets

plot(TrainingSet$moe2D_zagreb, TrainingSet$moe2D_weinerPol, col ="blue", 
     xlab = "Zagreb", ylab = "Weiner Pol")

plot(TestingSet$moe2D_zagreb, TestingSet$moe2D_weinerPol, col ="blue", 
     xlab = "Zagreb", ylab = "Weiner Pol")


###############################
# SVM model (polynomial kernel)

# Build Training model
Model <- train(Y ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess=c("scale","center"),
               trControl= trainControl(method="none"),
               tuneGrid = data.frame(degree=1,scale=1,C=1)
)

# Build CV model
Model.cv <- train(Y ~ ., data = TrainingSet,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess=c("scale","center"),
                  trControl= trainControl(method="cv", number=10),
                  tuneGrid = data.frame(degree=1,scale=1,C=1)
)


# Apply model for prediction
Model.training <-predict(Model, TrainingSet) # Apply model to make prediction on Training set
Model.testing <-predict(Model, TestingSet) # Apply model to make prediction on Testing set
Model.cv <-predict(Model.cv, TrainingSet) # Perform cross-validation

# Model performance (Displays confusion matrix and statistics)
Model.training.confusion <-confusionMatrix(Model.training, TrainingSet$Y)
Model.testing.confusion <-confusionMatrix(Model.testing, TestingSet$Y)
Model.cv.confusion <-confusionMatrix(Model.cv, TrainingSet$Y)

print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)

# Feature importance
Importance <- varImp(Model)
plot(Importance, top = 25)
plot(Importance, col = "red")
