## make a collection of patterns for tableplot
#
#  each argument is repeated up to the required length
#  # of patterns = n (if specified), or the maximum length of any argument

#  list of lists to data.frame and back:
#    Given pats as a list of lists:
#      pats.df <- do.call(rbind, lapply(pats, data.frame))
#      pats.df <- do.call(rbind.data.frame, pats)    ## works best
#      pats.df <- do.call(rbind, lapply(pats, data.frame))  ## works same -- real data frame
#      pats.df <- data.frame(do.call(rbind,lapply(pats,function(x) t(as.matrix(x,ncol=10)))))
#    Given pats.df: pats <- lapply(seq(along = rownames(pats.df)),function(i) as.list(pats.df[i, ]))

#' Construct collection of pattern specifications for tableplot
#'
#' @param n           Number of patterns
#' @param shape       Shape(s) used to encode the numerical value of \code{cell}.
#'                    Any of \code{0="circle", 1="diamond", 2="square"}. Recycled to match the number of values
#'                    in the cell.
#' @param shape.col   Outline color(s) for the shape(s)
#' @param shape.lty   Outline line type(s) for the shape(s)
#' @param cell.fill   inside color of |smallest| shape in a cell
#' @param back.fill   background color of cell
#' @param label       how many cell values will be labeled in the cell; max is 4
#' @param label.size  size of cell label(s)
#' @param ref.col     color of reference lines
#' @param ref.grid    whether to draw ref lines in the cells or not
#' @param scale.max   scale values to this maximum
#' @param as.data.frame whether to return a data.frame or a list.
#' @return Returns either a data.frame of a list. If a data.frame, the pattern specifications appear as columns
#' @export
#'
#' @examples
#' # None

make.patterns <- function(
    n = NULL,
    shape = 0,
    shape.col = "black",
    shape.lty = 1,
    cell.fill = "white",
    back.fill = "white",
    label = 0,
    label.size = 0.7,
    ref.col = "gray80",
    ref.grid = FALSE,
    scale.max = 1,
    as.data.frame = FALSE) {

  if (is.null(n)) {
    len <- max(unlist(lapply(list(shape,
                                  shape.col,
                                  shape.lty,
                                  cell.fill,
                                  back.fill,
                                  label,
                                  label.size,
                                  ref.col,
                                  ref.grid,
                                  scale.max),
                             FUN = length)))
  } else {
    len <- n
  }

  # replicate the elements in each, to required length
  shape <- rep(shape, len)
  shape.col <- rep(shape.col, len)
  shape.lty <- rep(shape.lty, len)
  cell.fill <- rep(cell.fill, len)
  back.fill <- rep(back.fill, len)
  label <- rep(label, len)
  label.size <- rep(label.size, len)
  ref.col <- rep(ref.col, len)
  ref.grid <- rep(ref.grid, len)
  scale.max <- rep(scale.max, len)

  # easier to work with as a table
  if (as.data.frame) {
    result <- data.frame(cbind(
      shape,
      shape.col,
      shape.lty,
      cell.fill,
      back.fill,
      label,
      label.size,
      ref.col,
      ref.grid,
      scale.max
    ), stringsAsFactors = FALSE)
    result <- result[1:len, ]
  } else {
    result <- as.list(vector(length = len))
    for (i in 1:len) {
      item <- list(
        shape = shape[i],
        shape.col = shape.col[i],
        shape.lty = shape.lty[i],
        cell.fill = cell.fill[i],
        back.fill = back.fill[i],
        label = label[i],
        label.size = label.size[i],
        ref.col = ref.col[i],
        ref.grid = ref.grid[i],
        scale.max = scale.max[i]
      )
      result[[i]] <- item
    }
  }
  return(result)
}
