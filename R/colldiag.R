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
#'
#' @param mod     A model object, such as computed by \code{} or \code{glm}, or a data-frame to be used as predictors in
#'    such a model.
#' @param scale   If \code{FALSE}, the data are left unscaled. If \code{TRUE}, the data are scaled, typically
#'    to mean 0 and variance 1 using \code{\link[base]{scale}}.
#'    Default is \code{TRUE}.
#' @param center  If TRUE, data are centered. Default is FALSE
#' @param add.intercept  if \code{TRUE}, an intercept is added. Default is \code{TRUE}
#'
#' @return
#' A \code{"colldiag"} object, containing:
#'   \item{condindx}{A vector of condition indexes}
#'   \item{pi}{A matrix of variance decomposition proportions}
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
#' D. Belsley, E. Kuh, and R. Welsch (1980).
#' \cite{Regression Diagnostics}, New York: John Wiley & Sons.
#'
#' Belsley, D.A. (1991).
#' \cite{Conditioning diagnostics, collinearity and weak data in regression}.
#' New York: John Wiley & Sons.
#'
#' Friendly, M., & Kwan, E. (2009).
#' Where’s Waldo: Visualizing Collinearity Diagnostics. \emph{The American Statistician}, \bold{63}, 56–65.
#' @export
#' @examples
#' # None yet
#'
colldiag <- function(mod,
                     scale = TRUE,
                     center = FALSE,
                     add.intercept = TRUE) {
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
#' @return
#' @exportS3Method colldiag print
#'
#' @examples
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
