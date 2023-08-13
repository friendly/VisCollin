# cars data - collinearity diagnostics examples


library(car)         # for vif
#library(perturb)     # for colldiag

data(cars)


cars.mod <- lm (mpg ~ cylinder+engine+horse+weight+accel+year, data=cars)
vif(cars.mod)

# SAS: / collin option
#colldiag(cars.mod)

# SAS: / collinoint option
cd <- colldiag(cars.mod, add.intercept=FALSE, center=TRUE)

# simplified display
print(colldiag(cars.mod, add.intercept=FALSE, center=TRUE), fuzz=.3)

source("c:/R/tableplot/tableplot.R")
source("c:/R/tableplot/cellgram.R")
source("c:/R/tableplot/make.patterns.R")
source("c:/R/tableplot/tableplot.colldiag.R")

library(tableplot)
#setwd("c:/sasuser/datavis/collin/")

tableplot.colldiag(cd)

# Biplots
cars.numeric <- cars[,sapply(cars,is.numeric)]
cars.complete<-cars.numeric[complete.cases(cars.numeric),]

# NB: The relative scaling of the variable vectors and scores differs
#     from the SAS versions.
# standard biplot of predictors
biplot( prcomp(cars.complete[,-1]), scale=0.5, cex=c(0.6,1), cex=c(0.6,1))
#last 2 dimensions for VIF
biplot( prcomp(cars.complete[,-1]), scale=0.5, choices=5:6, cex=c(0.6,1))

