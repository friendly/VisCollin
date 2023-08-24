#' ---
#' title: Acetylene data
#' ---

library(VisCollin)
library(car)
library(dplyr)

data(Acetylene, package = "genridge")

# model with naive quadratic and interaction
mod0 <- lm(yield ~ temp + ratio + time + I(time^2) + temp:time,
           data=Acetylene)

vif(mod0)

print(colldiag(mod0, center=TRUE), fuzz = .3)

# center the predictors
Acetylene.centered <-
  Acetylene |>
  mutate(temp = temp - mean(temp),
         time = time - mean(time))

mod1 <- lm(yield ~ temp + ratio + time + I(time^2) + temp:time,
           data=Acetylene.centered)

vif(mod1)

print(colldiag(mod1, center=TRUE), fuzz = .3)

mod2 <- lm(yield ~ temp + ratio + poly(time, 2) + temp:time,
           data=Acetylene.centered)

vif(mod2, type = "predictor")

print(colldiag(mod2, center=TRUE), fuzz = .3)

