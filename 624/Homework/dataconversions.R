
# Zachary Palmore
# DATA 624-01 Group 3 
# Data Collection and Hosting



# Data Set: Chemical Manufacturing Process
require(AppliedPredictiveModeling)
data(ChemicalManufacturingProcess)
write.csv(ChemicalManufacturingProcess, 
          "C:/data/624/ChemicalManufacturingProcess.csv")


# Data Set: mlbench.friedman training data
require(mlbench)
set.seed(200)
trainingData <- mlbench.friedman1(200, sd = 1)
trainingData$x <- data.frame(trainingData$x)
featurePlot(trainingData$x, trainingData$y)
write.csv(ChemicalManufacturingProcess, 
          "C:/data/624/ChemicalManufacturingProcess.csv")

require(mlbench)
set.seed(200)
testData <- mlbench.friedman1(5000, sd = 1)
testData$x <- data.frame(testData$x)
write.csv(ChemicalManufacturingProcess, 
          "C:/data/624/ChemicalManufacturingProcess.csv")