#' ---
#' title: cars data
#' ---

library(dplyr)
cars <- read.csv(here::here("data-raw", "cars.csv"))
str(cars)

cars <- cars |>
  mutate(make = as.factor(make),
#         model = as.factor(model),
         origin = factor(origin,
                         labels = c("Amer", "Eur", "Japan")))


save(cars, file = here::here("data", "cars.RData"))

prompt(cars, filename = here::here("man-old", "cars.Rd"))
