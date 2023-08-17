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

<<<<<<< HEAD
print(colldiag(mod0, center=TRUE), fuzz = .3)

=======
>>>>>>> 8a8ca654d635d6543f59eae8aa3e5794e67a34b2
# center the predictors
Acetylene.centered <-
  Acetylene |>
  mutate(temp = temp - mean(temp),
         time = time - mean(time))

mod1 <- lm(yield ~ temp + ratio + time + I(time^2) + temp:time,
           data=Acetylene.centered)

vif(mod1)

<<<<<<< HEAD
print(colldiag(mod1, center=TRUE), fuzz = .3)
=======
>>>>>>> 8a8ca654d635d6543f59eae8aa3e5794e67a34b2
