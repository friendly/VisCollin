library(VisCollin)
library(tinytable)

# fully reproducible example
data(cars, package = "VisCollin")

cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
  data = cars)
x <- colldiag(cars.mod, center=TRUE)

percent = FALSE
descending = TRUE
fuzz <- 0.3

cond <- x$condindx
pi <- x$pi

pi[pi < fuzz] <- NA

vars <- colnames(pi)           # variable names
nvar <- ncol(pi)               # number of variables
if (percent) pi <- 100*pi
res <- cbind(cond, pi)
colnames(res)[1] <- "Cond\nindex"


rows <- 1:nrow(pi)
ord <- if (descending) rev(rows) else rows
res <- res[ord,]
res <- as.data.frame(res)

# background color indices
idx <- as.matrix(res[, -1])
bg <- matrix(NA, ncol = ncol(res) - 1, nrow = nrow(res))
bg[idx > .5] <- "pink"
bg[idx > .9] <- "red"

# tinytable
tt(res) |>
  tt_format(digits = 2) |>
  tt_format(replace=TRUE) |>
  style_tt(j = 1, align = "r") |>
  style_tt(i = 1:nrow(res),
    j = 2:ncol(res),
    background = bg)
