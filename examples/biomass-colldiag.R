# Linthall Biomass data - collinearity diagnostics examples

library(VisCollin)
library(car)         # for vif
data(biomass)

biomass.mod <- lm (biomass ~ H2S + sal + Eh7 + pH + buf + P + K + Ca + Mg + Na + Mn + Zn + Cu + NH4, data=biomass)
vif(biomass.mod)

cd <- colldiag(biomass.mod, center=TRUE)
# simplified display
print(colldiag(biomass.mod, center=TRUE), fuzz=.3)

tableplot(cd, show.rows=14:5)

# collinearity biplot of last 2 dimensions
# [the scaling of variable vectors differs from the SAS version]

biomass.pca <- prcomp(biomass[, 4:17], scale. = TRUE)
biplot( biomass.pca,
        choices=13:14,
        scale=0.5,
        cex=c(0.6,1))
