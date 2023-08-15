library(car)         # for vif
#library(perturb)     # for colldiag

#baseball <- read.csv("c:/sasuser/data/baseball.csv")
#baseball <- read.csv("http://www.math.yorku.ca/SCS/viscollin/data/baseball.csv")

data(baseball, package = "corrgram")

#baseball$logsal <- log(baseball$salary)
baseball$Years7 <- pmin(baseball$Years,7)

base.mod <- lm(logSal ~ Years7 + Atbatc + Hitsc + Homerc + Runsc + RBIc + Walksc,
               data=baseball)
vif(base.mod)

# SAS: / collin option
colldiag(base.mod)

# SAS: / collinoint option
cd <- colldiag(base.mod, center=TRUE)
# simplified display
print(colldiag(base.mod, center=TRUE), fuzz=.3)


# source("c:/R/tableplot/tableplot.R")
# source("c:/R/tableplot/cellgram.R")
# source("c:/R/tableplot/make.patterns.R")
# source("c:/R/tableplot/tableplot.colldiag.R")
# setwd("c:/sasuser/datavis/collin/")

tableplot.colldiag(cd)

# same result, using the lm() object:
# tableplot.colldiag(base.mod)

# do collinearity biplot
base.pca <- princomp( ~ Years7 + Atbatc + Hitsc + Homerc + Runsc + RBIc + Walksc,
                 data=baseball, cor=TRUE)

biplot(base.pca,
       choices=c(6,7),
       expand=1.5,
       cex=c(0.5, 1.5),
       xlim=c(-0.3,0.4))

