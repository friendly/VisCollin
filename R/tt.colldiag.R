#' @title tinytable output method for colldiag objects
#'
#'
#' @param x        A \code{colldiag} object
#' @param dec.places Number of decimal places to use when printing
#' @param fuzz     Variance decomposition proportions less than \emph{fuzz} are printed as \emph{fuzzchar}
#' @param fuzzchar Character for small variance decomposition proportion values
#' @param descending Logical; \code{TRUE} prints the values in descending order of condition indices
#' @param ...      arguments to be passed on to or from other methods (unused)
#'
#' ##@rdname colldiag
#' @exportS3Method tt colldiag
#'
tt.colldiag <- function(x,
                           dec.places = 3,
                           fuzz = NULL,
                           fuzzchar = ".",
                           descending = FALSE,
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
  cat("Condition\nIndex\t  -- Variance Decomposition Proportions --\n")
  rows <- 1:nrow(pi)
  ord <- if (descending) rev(rows) else rows
  out <- noquote(cbind(condindx, pi)[ord,])

  res <- tinytable::tt(out, ...)
}
