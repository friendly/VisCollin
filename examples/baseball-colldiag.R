library(VisCollin)
library(car)         # for vif


data(baseball, package = "corrgram")

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

