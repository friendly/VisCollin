# FIXME: Why is "Cond\nindex" not rendered on two lines in the header row?
# FIXME: How to render tt() in pkgdown examples so it appears as a graphic with shaded backgrounds? ? It appears as a text table in the `pkgdown` documentation. I tried using `|> print(output = "html")`
#        in the documentation examples but this gave an error: "Error: `x` must be a data.frame".
# TODO: 🚩 Handle changing font family for headers, numbers in the body. The examples I've run use a serif font, but I'd prefer a sans-serif font which is better for tables. I can't find any info on font family for tinytable.
# DONE: ✓ Font size now varies with variance proportions (1em to 1.5em). Larger proportions appear in larger font sizes.

#' `tinytable` Output Method for "colldiag" Objects
#'
#' This function uses the \pkg{tinytable} package to give a display of collinearity diagnostics with
#' shaded backgrounds indicating the severity of collinearity in the dimensions of the data
#' and the proportions of variance related to each variable in these dimensions. It gives
#' a table version of the graphic shown by \code{\link{tableplot}}, but something that
#' can be rendered in HTML, PDF and other formats.
#'
#' @details
#' The \code{"tinytable"} object returned can be customized using other functions from
#' the \pkg{tinytable} package.
#'
#'
#' @param x        A \code{"colldiag"} object
#' @param digits   Number of digits to use when printing; set to 0 when \code{percent = TRUE}
#' @param fuzz     Variance decomposition proportions less than \emph{fuzz} are printed as \emph{fuzzchar}
#' @param descending Logical; \code{TRUE} prints the values in descending order of condition indices
#' @param percent  Logical; if \code{TRUE}, the variance proportions are printed as percents, 0-100
#' @param prop.col   A vector of colors used for the variance proportions. The default is \code{c("white", "pink", "red")}.
#' @param cond.col   A vector of colors used for the condition indices, according to \code{cond.breaks}
#' @param prop.breaks Scale breaks for the variance proportions, a vector of length \emph{one more} than the number of \code{prop.col}, whose values are
#'                  between 0 and 1.
#' @param cond.breaks Scale breaks for the condition indices a vector of length \emph{one more} than the number of \code{cond.col}
#' @param font.scale Controls font size scaling for variance proportions. Either a single numeric value (no scaling) or a vector of length 2
#'                  specifying the minimum and maximum font sizes in \code{em} units. Default is \code{1} (no scaling). Use \code{c(1, 1.5)}
#'                  to scale font sizes from 1em to 1.5em based on variance proportion values, making larger proportions more visually prominent.
#' @param ...      arguments to be passed on to or from other methods (unused)
#'
#' @return a \code{"tinytable"} object
#'
#' @importFrom tinytable tt style_tt tt_format
#'
#' @author Michael Friendly
#' @seealso \code{\link{colldiag}}, \code{\link{tableplot}},
#'          \code{\link[tinytable]{tinytable}}
#' @exportS3Method
#' @examples
#' library(VisCollin)
#' library(tinytable)
#' data(cars, package = "VisCollin")
#' cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
#'                 data = cars)
#' cd <- colldiag(cars.mod, center=TRUE)
#' # show all values, in same order as `cd`
#' tt(cd)
#'
#' # show results in percent
#' tt(cd, percent = TRUE)
#'
#' # try descending & fuzz
#' tt(cd, descending = TRUE, fuzz = 0.3)
#'
#' # vary font size from 1em to 1.5em based on variance proportions
#' tt(cd, font.scale = c(1, 1.5))


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
    font.scale = 1,
    ...) {

  if (!all(prop.breaks >= 0 & prop.breaks <= 1)) stop("`prop.breaks` must be between 0 and 1")
  if (!all(cond.breaks >= 0)) stop("`cond.breaks` must be non-negative.")
  if (!(length(font.scale) %in% c(1, 2))) stop("`font.scale` must be a numeric vector of length 1 or 2")
  if (!all(font.scale > 0)) stop("`font.scale` values must be positive")

  cond <- x$condindx
  pi <- x$pi
  vars <- colnames(pi)           # variable names
  nvar <- ncol(pi)               # number of variables

  if (!is.null(fuzz)) {          # prop < fuzz --> NA
  pi[pi < fuzz] <- NA
  }
  if (percent) {
    pi <- 100*pi
    prop.breaks <- 100 * prop.breaks
    }

  res <- cbind(cond, pi)
  colnames(res)[1] <- "Cond\nindex"

  # reorder rows, if descending
  rows <- 1:nrow(pi)
  ord <- if (descending) rev(rows) else rows
  res <- res[ord,]

  # determine cuts for colors applied to condition indices and variance proportions

  cond.cat <- cut(res[, 1],  breaks = cond.breaks - 0.1, labels = FALSE)

  prop.cat <-  matrix(cut(res[, -1],
                          breaks = prop.breaks - 0.0001,
                          labels = FALSE),
                      dim(pi))
  colnames(prop.cat) <- vars

  cond.style <- cond.col[cond.cat]
  prop.style <- prop.col[prop.cat]

  # if(verbose) {
  # cat("Proportion categories\n")
  # print(prop.cat)
  # cat("Proportion colors (col major order)\n")
  # print(prop.style)
  # }


  # Convert prop.style matrix to vector in column-major order for tinytable
  prop.style_vec <- as.vector(prop.style)

  # Create font size matrix for variance proportions
  # Map proportions to font sizes: larger proportions get larger fonts
  prop_values <- res[, 2:ncol(res)]

  if (length(font.scale) == 1) {
    # No scaling: use constant font size
    prop_fontsize <- matrix(font.scale, nrow = nrow(prop_values), ncol = ncol(prop_values))
  } else {
    # Scale between min and max based on proportion values
    # Normalize to 0-1 range (handle percent case)
    prop_normalized <- if (percent) prop_values / 100 else prop_values
    # Map to font sizes: min + (max - min) * proportion
    font_min <- font.scale[1]
    font_max <- font.scale[2]
    prop_fontsize <- font_min + (font_max - font_min) * prop_normalized
    # For NA values (from fuzz), use minimum font size
    prop_fontsize[is.na(prop_fontsize)] <- font_min
  }

  # Convert to matrix and then to vector in column-major order
  prop_fontsize_vec <- as.vector(as.matrix(prop_fontsize))

  # Determine digits for variance proportions: 0 if percent, else digits
  var_digits <- if (percent) 0 else digits

  # Round values before passing to tt() to ensure proper display
  res[, 1] <- round(res[, 1], digits)           # condition index
  res[, 2:ncol(res)] <- round(res[, 2:ncol(res)], var_digits)  # variance proportions

  res <- as.data.frame(res)
  tt(res) |>
    tt_format(replace = TRUE) |>
    style_tt(j = 1, align = "r") |>
    style_tt(i = 1:nrow(res),
             j = 1,
             background = cond.style) |>
    style_tt(i = 1:nrow(res),
             j = 2:ncol(res),
             align = "r",
             background = prop.style_vec,
             fontsize = prop_fontsize_vec)

}

