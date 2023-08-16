#'
#' @name colldiag
#' @aliases colldiag print.colldiag
#' @title Collinearity Diagnostics
#'
#' @description
#' Calculates condition indexes and variance decomposition proportions in order to test
#' for collinearity among the independent variables of a regression model and
#' identifies the sources of collinearity if present.
#'
#' @details
#' \code{colldiag} is an implementation of the regression collinearity diagnostic procedures found in Belsley, Kuh, and Welsch (1980). These procedures examine the \dQuote{conditioning} of the matrix of independent variables.
#'
#' It computes the condition indexes of the model matrix. If the largest condition index (the condition number) is
#' \emph{large} (Belsley et al suggest 30 or higher), then there may be collinearity problems.
#' All \emph{large} condition indexes may be worth investigating.
#'
#' \code{colldiag} also provides further information that may help to identify the source of these problems,
#' the \emph{variance decomposition proportions} associated with each condition index.
#' If a large condition index is associated two or more variables with \emph{large} variance decomposition proportions,
#' these variables may be causing collinearity problems.  Belsley et al suggest that a \emph{large} proportion is
#' 50 percent or more.
#'
#' Note that such collinearity diagnostics are often provided by other software
#' for the model matrix including
#' the constant term for the intercept (e.g., SAS PROC REG, with the option COLLIN).
#' However, these are generally useless and misleading unless the intercept has some
#' real interpretation and the origin of the regressors is contained within the
#' prediction space, as explained by Fox (1997, p. 351). The default values
#' for \code{scale}, \code{center} and \code{add.intercept} exclude the constant
#' term, and correspond to the SAS option COLLINNOINT.
#'
#' @note
#' Missing data is silently omitted in these calculations
#'
#' @param mod     A model object, such as computed by \code{lm} or \code{glm}, or a data-frame to be used as predictors in
#'    such a model.
#' @param scale   If \code{FALSE}, the data are left unscaled. If \code{TRUE}, the data are scaled, typically
#'    to mean 0 and variance 1 using \code{\link[base]{scale}}.
#'    Default is \code{TRUE}.
#' @param center  If TRUE, data are centered. Default is \code{FALSE}.
#' @param add.intercept  if \code{TRUE}, an intercept is added. Default is \code{FALSE}.
#'
#' @return
#' A \code{"colldiag"} object, containing:
#'   \item{condindx}{A one-column matrix of condition indexes}
#'   \item{pi}{A square matrix of variance decomposition proportions. The rows refer to the principal component dimensions,
#'             the columns to the predictor variables.}
#'
#' \code{print.colldiag} prints the condition indexes as the first column of a table with the variance decomposition
#' proportions beside them. \code{print.colldiag} has a \code{fuzz} option to suppress printing of small numbers.
#' If fuzz is used, small values are replaces by a period \dQuote{.}. \code{Fuzzchar} can be used to specify an alternative character.
#'
#' @author John Hendrickx
#' @source These functions were taken from the (now defunct) \code{perturb} package by John Hendrickx.
#' He credits the Stata program \code{coldiag} by Joseph Harkness \email{joe.harkness@jhu.edu}, Johns Hopkins University.
#
#' @seealso \code{\link{lm}}, \code{\link{scale}}, \code{\link{svd}},
#'     \code{[car]}\code{\link[car]{vif}}, \code{[rms]}\code{\link[rms]{vif}}
#'
#' @references
#' Belsley, D.A.,  Kuh, E. and Welsch, R. (1980).
#' \cite{Regression Diagnostics}, New York: John Wiley & Sons.
#'
#' Belsley, D.A. (1991).
#' \cite{Conditioning diagnostics, collinearity and weak data in regression}.
#' New York: John Wiley & Sons.
#'
#' Fox, J. (1997). \cite{Applied Regression Analysis, Linear Models, and Related Methods}.
#' thousand Oaks, CA: Sage Publications.
#'
#' Friendly, M., & Kwan, E. (2009).
#' Where’s Waldo: Visualizing Collinearity Diagnostics. \emph{The American Statistician}, \bold{63}, 56–65.
#' @export
#' @importFrom stats na.omit
#' @examples
#' data(cars)
#' cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
#'                 data=cars)
#' car::vif(cars.mod)
#'
#' # SAS PROC REG / COLLIN option, including the intercept
#' colldiag(cars.mod, add.intercept = TRUE)
#'
#' # Default settings: scaled, not centered, no intercept, like SAS PROC REG / COLLINNOINT
#' colldiag(cars.mod)
#'
#' (cd <- colldiag(cars.mod, center=TRUE))
#'
#' # fuzz small values
#' print(cd, fuzz = 0.5)
#'
#' # Biomass data
#' data(biomass)
#'
#' biomass.mod <- lm (biomass ~ H2S + sal + Eh7 + pH + buf + P + K +
#'                              Ca + Mg + Na + Mn + Zn + Cu + NH4,
#'                    data=biomass)
#' car::vif(biomass.mod)
#'
#' cd <- colldiag(biomass.mod, center=TRUE)
#' # simplified display
#' print(colldiag(biomass.mod, center=TRUE), fuzz=.3)
#'

colldiag <- function(mod,
                     scale = TRUE,
                     center = FALSE,
                     add.intercept = FALSE) {
  result <- NULL
  if (center) add.intercept <- FALSE
  if (is.matrix(mod) || is.data.frame(mod)) {
    X <- as.matrix(mod)
    nms <- colnames(mod)
  } else if (!is.null(mod$call$formula)) {
    X <- mod$model[, -1] # delete the dependent variable
  }
  X <- na.omit(X) # delete missing cases
  if (add.intercept) {
    X <- cbind(1, X) # add the intercept
    colnames(X)[1] <- "intercept"
  }
  X <- scale(X, scale = scale, center = center)

  svdX <- svd(X)
  svdX$d
  condindx <- svdX$d[1] / svdX$d

  Phi <- svdX$v %*% diag(1 / svdX$d)
  Phi <- t(Phi^2)
  pi <- prop.table(Phi, 2)

  dim(condindx) <- c(length(condindx), 1)
  colnames(condindx) <- "cond.index"
  rownames(condindx) <- 1:nrow(condindx)
  colnames(pi) <- colnames(X)
  result$condindx <- condindx
  result$pi <- pi
  class(result) <- "colldiag"
  result
}

#'
#'
#' @param x        A \code{colldiag} object
#' @param dec.places Number of decimal places to use when printing
#' @param fuzz     Variance decomposition proportions less than \emph{fuzz} are printed as \emph{fuzzchar}
#' @param fuzzchar Character for small variance decomposition proportion values
#' @param ...      arguments to be passed on to or from other methods (unused)
#'
#' @rdname colldiag
#' @exportS3Method print colldiag
#'
#' @examples
#' # None yet
print.colldiag <- function(x,
                           dec.places = 3,
                           fuzz = NULL,
                           fuzzchar = ".",
                           ...) {
  stopifnot(fuzz > 0 & fuzz < 1)
  stopifnot(is.character(fuzzchar))
  stopifnot(nchar(fuzzchar) == 1)

  fuzzchar <- paste(" ", fuzzchar, sep = "")
  width <- dec.places + 2
  pi <- formatC(x$pi, format = "f", width = width, digits = dec.places)
  if (!is.null(fuzz)) {
    pi[pi < fuzz] <- fuzzchar
  }
  width <- max(nchar(trunc(max(x$condindx)))) + dec.places + 2
  condindx <- formatC(x$condindx, format = "f", width = width, digits = dec.places)
  colnames(condindx) <- NULL
  cat("Condition\nIndex\tVariance Decomposition Proportions\n")
  print(noquote(cbind(condindx, pi)))
}
