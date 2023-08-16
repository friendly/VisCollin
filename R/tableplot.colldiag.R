# make a tableplot for collinearity diagnostics


#' Tableplot for Collinearity Diagnostics
#'
#' @description
#' These methods produce a tableplot of collinearity diagnostics, showing the condition indices and variance
#' proportions for predictors in a linear or generalized linear regression model. This encodes the
#' condition indices using \emph{squares} whose background color is red for condition indices > 10,
#' green for values > 5 and green otherwise, reflecting danger, warning and OK respectively.
#' The value of the condition index is encoded within this using a white square proportional to the value
#' (up to some maximum value, \code{cond.max}),
#'
#' Variance decomposition proportions are shown by filled \emph{circles} whose radius is proportional to those values
#' and are filled (by default) with shades ranging from white through pink to red. Rounded values of those diagnostics
#' are printed in the cells.
#'
#' @note
#' Tableplots are produced using \code{grid} graphics using viewports to draw each successive cell in the display.
#' For use in \code{.Rmd} documents using \code{knitr}, you should use the chunk option \code{fig.keep = "last"}
#' so that only the final figure is shown in the output.
#'
#' @name tableplot.colldig
#' @aliases tableplot.colldig tableplot.lm tableplot.glm
#' @param values     A \code{"colldiag"}, \code{"lm"} or \code{"glm"} object
#' @param prop.col   A vector of colors used for the variance proportions. The default is \code{c("white", "pink", "red")}.
#' @param cond.col   A vector of colors used for the condition indices
#' @param cond.max   Maximum value to scale the white squares for the condition indices
#' @param prop.breaks Scale breaks for the variance proportions
#' @param cond.breaks Scale breaks for the condition indices
#' @param show.rows  Rows of the eigenvalue decompositon of the model matrix to show in the display. The default \code{nvar:1}
#'        puts the smallest dimensions at the top of the display.
#' @param title      title used for the resulting graphic
#' @param patterns   pattern matrix used for table plot.
#' @param ...        other arguments, for consistency with generic
#'
#' @return None. Used for its graphic side-effect
#'
#' @author Michael Friendly
#' @references
#' Friendly, M., & Kwan, E. (2009).
#' "Where’s Waldo: Visualizing Collinearity Diagnostics." \emph{The American Statistician}, \bold{63}, 56–65.
#' Online: \url{https://www.datavis.ca/papers/viscollin-tast.pdf}.
#'
#' @importFrom stats xtabs
#' @return NULL
#' @exportS3Method tableplot colldiag
#'
#' @examples
#' # None yet
#'

#' @rdname tableplot.colldiag
#' @exportS3Method tableplot lm
tableplot.lm <- function(values, ...) {
  x <- colldiag(values, add.intercept = FALSE, center = TRUE)
  tableplot.colldiag(x, ...)
}

#' @rdname tableplot.colldiag
#' @exportS3Method tableplot glm
tableplot.glm <- function(values, ...) {
  x <- colldiag(values, add.intercept = FALSE, center = TRUE)
  tableplot.colldiag(x, ...)
}


#' @rdname tableplot.colldiag
#' @exportS3Method tableplot colldiag
tableplot.colldiag <- function(
       values,
       prop.col = c("white", "pink", "red"),        # colors for variance proportions
       cond.col = c("#A8F48D", "#DDAB3E", "red"),   # colors for condition indices
       cond.max = 100,                              # scale.max for condition indices
       prop.breaks = c(0, 20, 50, 100),
       cond.breaks = c(0, 5, 10, 1000),
       show.rows = nvar:1,
       title = "",
       patterns,
       ...) {

  x <- values

  collin <- round(100 * x$pi)      # variance proportions
  condind <- round(x$condindx, 2)  # condition indices
  vars <- colnames(x$pi)           # variable names
  nvar <- ncol(x$pi)               # number of variables

  if (missing(patterns)) {
    patterns <- make.patterns(
      shape = c(rep(0, 3), rep(2, 3)), # squares and circles
      cell.fill = c(prop.col, rep("white", 3)),
      back.fill = c(rep("white", 3), cond.col),
      scale.max = rep(c(100, cond.max), each = 3),
      label = 1,
      label.size = 1,
      ref.grid = rep(c(TRUE, FALSE), each = 3)
    )
  }

  type.mat <- matrix(cut(collin, breaks = prop.breaks - 0.1, labels = FALSE), dim(collin))
  type.cond <- 3 + cut(condind, breaks = cond.breaks - 0.1, labels = FALSE)

  r.label <- paste("#", show.rows, sep = "")
  values <- cbind(condind, collin)[show.rows, ]
  types <- cbind(type.cond, type.mat)[show.rows, ]
  vars <- c("CondIndex", vars)
  #  print(values, digits=4)
  #  print(types)

  #  h.parts <- as.vector(xtabs(~ cut(condind, breaks=cond.breaks-0.1, labels=FALSE)))
  h.parts <- rev(as.vector(xtabs(~type.cond)))
  #  print(h.parts)

  tableplot(values, types,
    title = title,
    top.label = vars,
    side.label = r.label,
    patterns = patterns,
    v.parts = c(1, nvar),
    h.parts = h.parts,
    gap = 2
  )
}
