# cars data - collinearity diagnostics examples


library(VisCollin)
library(car)         # for vif
library(dplyr)
#library(perturb)     # for colldiag

data(cars)

# correlation matrix of predictors

R <- cars |>
  select(cylinder:year) |>
  tidyr::drop_na() |>
  cor()

100 * R |> round(digits = 2)

library(corrplot)
corrplot.mixed(R, lower = "square", upper = "ellipse", tl.col = "black")


# model
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                data=cars)
vif(cars.mod)

# SAS: / collin option
#colldiag(cars.mod)

# SAS: / collinnoint option
cd <- colldiag(cars.mod, add.intercept=FALSE, center=TRUE)

# simplified display
print(colldiag(cars.mod, add.intercept=FALSE, center=TRUE), fuzz=.3)

# source("c:/R/tableplot/tableplot.R")
# source("c:/R/tableplot/cellgram.R")
# source("c:/R/tableplot/make.patterns.R")
# source("c:/R/tableplot/tableplot.colldiag.R")
#
# library(tableplot)

tableplot.colldiag(cd)

# Biplots
# cars.numeric  <- cars[,sapply(cars,is.numeric)]
# cars.complete <- cars.numeric[complete.cases(cars.numeric),]

cars.X <- cars |>
  select(where(is.numeric)) |>
  select(-mpg) |>
  tidyr::drop_na()
cars.pca <- prcomp(cars.X, scale. = TRUE)
cars.pca

# NB: The relative scaling of the variable vectors and scores differs
#     from the SAS versions.
# standard biplot of predictors

# Make labels for dimensions include % of variance
pct <- 100 *(cars.pca$sdev^2) / sum(cars.pca$sdev^2)
lab <- glue::glue("Dimension {1:6} ({round(pct, 2)}%)")

# reflect dimensions
cars.pca$rotation <- -cars.pca$rotation

op <- par(lwd = 2, xpd = NA )
biplot( cars.pca,
        scale=0.5,
        cex=c(0.6,1),
        col = c("black", "blue"),
        expand = 1.7,
        xlab = lab[6],
        ylab = lab[5]
)
par(op)

#last 2 dimensions for VIF
op <- par(lwd = 2, xpd = NA )
biplot(cars.pca,
       choices=6:5,           # only the last two dimensions
       scale=0.5,             # symmetric biplot scaling
       cex=c(0.6, 1),         # character sizes for points and vectors
       col = c("black", "blue"),
       expand = 1.7,          # expand variable vectors for visibility
       xlab = lab[6],
       ylab = lab[5],
       xlim = c(-0.7, 0.5),
       ylim = c(-0.8, 0.5)
)
par(op)
