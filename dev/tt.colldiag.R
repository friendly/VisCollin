tt.colldiag <- function(
    x,
    digits = 2,
    fuzz = NULL,
    descending = FALSE,
    percent = FALSE,
    prop.col = c("white", "pink", "red"),        # colors for variance proportions
    cond.col = c("#A8F48D", "#DDAB3E", "red"),   # colors for condition indices
    prop.breaks = c(0, 0.20, 0.50, 1.00),
    cond.breaks = c(0, 5, 10, 1000),
    ...) {

  cond <- x$condindx
  pi <- x$pi
  vars <- colnames(pi)           # variable names
  nvar <- ncol(pi)               # number of variables

  if (!is.null(fuzz)) {          # prop < fuzz --> NA
  pi[pi < fuzz] <- NA
  }
  if (percent) pi <- 100*pi

  res <- cbind(cond, pi)
  colnames(res)[1] <- "Cond\nindex"

  # reorder rows, if descending
  rows <- 1:nrow(pi)
  ord <- if (descending) rev(rows) else rows
  res <- res[ord,]

  # determine cuts for colors applied to condition indices and variance proportions
  # -- TODO: need to handle percent for variance props
  cond.cat <- cut(res[, 1],  breaks = cond.breaks - 0.1, labels = FALSE)
  prop.cat <- cut(res[, -1], breaks = prop.breaks - 0.1, labels = FALSE)

  cond.style <- cond.col[cond.cat]

  res <- as.data.frame(res)
  tt(res) |>
    tt_format(digits = digits) |>
    tt_format(replace=TRUE) |>
    style_tt(j = 1, align = "r") |>
    style_tt(i = 1:nrow(res),
             j = 1,
             background = cond.style)

}

if (FALSE) {
  library(VisCollin)
  library(tinytable)
  data(cars, package = "VisCollin")
  cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                  data = cars)
  cd <- colldiag(cars.mod, center=TRUE)
  cond <- cd$condindx
  pi <- cd$pi

  # try out formatting manually
  res <- tt.colldiag(cd, fuzz = 0.3, descending = TRUE)

  prop.col = c("white", "pink", "red")        # colors for variance proportions
  cond.col = c("#A8F48D", "#DDAB3E", "red")   # colors for condition indices
  prop.breaks = c(0, 20, 50, 100)
  cond.breaks = c(0, 5, 10, 1000)

  cond.cat <- cut(cond, breaks = cond.breaks - 0.1, labels = FALSE)
  prop.cat <- cut(pi,   breaks = prop.breaks - 0.1, labels = FALSE)

  # add tt styling
  res |>
    tt_format(digits = 2) |>
    tt_format(replace=TRUE)
    # style_tt(j = 1,
    #     background = cond.col[cond.cat])


}
