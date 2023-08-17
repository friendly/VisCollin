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

# center the predictors
Acetylene.centered <-
  Acetylene |>
  mutate(temp = temp - mean(temp),
         time = time - mean(time))

mod1 <- lm(yield ~ temp + ratio + time + I(time^2) + temp:time,
           data=Acetylene.centered)

vif(mod1)

