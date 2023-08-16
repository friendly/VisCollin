## Tableplot

# last modified 7/29/2008 11:51AM by MF
#  -- cosmetic changes: <- instead of = for assignment
#  -- changed library() to require()
#  -- moved extra functions to utility.R
#  -- added side.rot argument to rotate side labels
#  -- made gap.list an internal function

## TODO:
# DONE table.plot() should be renamed tableplot() and made object-oriented
#    (tableplot.default) to facilitate extensions for other types of table/matrix inputs
# DONE  Arguments values and types should be renamed values and types
# -- The function should use rownames() and colnames() to set default labels
#    for a matrix argument, when these are available
# DONE Arguments given default values of "yes" or "no" should use TRUE/FALSE instead
# -- Should allow to automatically round or format the values printed in the cells
# -- title should either be NULL by default or use deparse(substitute(values)) to
#    print "Tableplot of X"

#' Tableplot: A Semi-graphic Display of a Table
#'
#' @description
#' A tableplot (Kwan, 2008) is
#' designed as a semi-graphic display in the form of a table with numeric values, but supplemented
#' by symbols with size proportional to cell value(s), and with other visual attributes
#' (shape, color fill, background fill, etc.) that can be used to encode other information
#' essential to direct visual understanding.  Three-way arrays, where the last dimension
#' corresponds to levels of a factor for which the first two dimensions are to be compared
#' are handled by superimposing symbols.
#'
#' The specifications for each cell are given by the \code{types} argument, whose elements refer
#' to the attributes specified in \code{patterns.}
#'
#' @note The original version of tableplots was in the now-defunct tableplot package
#' \url{https://cran.r-project.org/package=tableplot}. The current implementation
#' is a modest re-design focused on its use for collinearity diagnostics, but usable in
#' more general contexts.
#'
#' @param values A matrix or 3-dimensional array of values to be displayed in a tableplot
#' @param types  Matrix of specification assignments, of the same size as the first two dimensions
#'        of \code{values}. Entries refer to the sub-lists of \code{patterns}.
#'        Defaults to a matrix of all 1s, \code{matrix(1, dim(values)[1], dim(values[2]))},
#'        indicating that all cells use the same pattern specification.
#' @param patterns List of lists; each list is one specification for the arguments to \code{\link{cellgram}}.
#' @param title    Main title
#' @param side.label  a character vector providing labels for the rows of the tableplot
#' @param top.label   a character vector providing labels for the columns of the tableplot
#' @param table.label Whether to print row/column labels
#' @param label.size  Character size for labels
#' @param side.rot    Degree of rotation (positive for counter-clockwise)
#' @param gap         Width of the gap in each partition, if partitions are requested by \code{v.parts}
#'        and/or \code{h.parts}
#' @param v.parts     An integer vector giving the number of columns in two or more partitions of
#'        the table. If provided, sum must equal number of columns.
#' @param h.parts     An integer vector giving the number of rows in two or more partitions of
#'        the table. If provided, sum must equal number of rows.
#'
#' @param cor.matrix  Logical. \code{TRUE} for a correlation matrix
#' @param var.names   a list of variable names
#' @param ...         Arguments passed down to \code{tableplot.default}
#'
#' @import grid
#' @author Ernest Kwan and Michael Friendly
#' @seealso \code{\link{cellgram}}
#' @references
#' Kwan, E. (2008).
#' Improving Factor Analysis in Psychology: Innovations Based on the Null Hypothesis Significance
#' Testing Controversy. Ph. D. thesis,  York University.
#
#' @return None. Used for its graphic side effect
#' @export
#'
#' @examples
#' data(cars)
#' cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
#'                 data=cars)
#' car::vif(cars.mod)
#'
#' (cd <- colldiag(cars.mod, center=TRUE))
#' tableplot(cd, title = "Tableplot of cars data", cond.max = 30 )
#'
tableplot <-
  function(values,  ...) UseMethod("tableplot")

#' @rdname tableplot
#' @exportS3Method tableplot default
tableplot.default <- function(

	values, 		# Matrix of values; can be a matrix, or an array of 3 dimensions. If an array, the numbers
	            # along the 3rd dimension are
	types,		  # Matrix of pattern designations (types).
	patterns = list(list(0, "black", 1, "white", "white", 0, 0.5, "grey80", FALSE, 1)),

	title="Tableplot",

	side.label = "row",   # Or provide actual list of labels for each row.
	top.label = "col",    # Or provide actual list of labels for each column.
	table.label = TRUE,   # To have labels around the table or not.
	label.size=1,	        # Size of side/top labels.
	side.rot=0,           # Rotation for side labels

	gap=2, 		    # Width of gaps in partition, if there are partitions.
	v.parts=0, 		# Column clusters; if provided, sum must equal number of columns.
	h.parts=0, 		# Row clusters; if provided, sum must equal number of rows.

	cor.matrix = FALSE,  # For a correlation matrix.
	var.names = "var",  # Or provide a list of variable names.

	...){

#	require(grid)
#	require(lattice)

  ## A function to construct a gap list.
  gap.list <- function(partitions=0,x){
  	if (length(partitions)==1) rep(0,x) else {
  	rep(1:length(partitions), partitions)-1}
  	}

	grid.newpage()

	#---Create labels for a correlation matrix, if no names provided.

	if ((cor.matrix == TRUE) && (length(var.names)==1)) var.names <- paste(var.names,1:dim(values)[1])

	#---Create the pattern designation matrix when there is just one pattern.
	#---Otherwise, the pattern designation matrix is supplied by user.

	if (missing(types) || length(patterns)==1) types <- matrix(1, dim(values)[1], dim(values)[2])

	#---Add on extra dimension to values if values only has two dimensions.

	if (length(dim(values))==2) {
	  dim(values) <- c(dim(values)[1], dim(values)[2], 1)
	  }

	#---Constructing vectors of gaps if partitions provided.

	v.gaps <- gap.list(partitions=v.parts, x=dim(values)[2])
	h.gaps <- gap.list(partitions=h.parts, x=dim(values)[1])

	#---Constructing labels, if no specific labels provided for each row/column.

	if (length(side.label)==1) side.label <- paste(side.label, 1:dim(values)[1])
	if (length(top.label)==1)  top.label  <- paste(top.label,  1:dim(values)[2])

	#---Create Layout 1 and write main title.

	L1 <- grid.layout(2,1,heights=unit(c(3,1),c("lines","null")))
	pushViewport(viewport(layout=L1, width=0.95, height=0.98))

	pushViewport(viewport(layout.pos.row=1)) 			## Push row 1 of Layout 1.
	grid.text(title, x=0.02, just=c("left", "bottom"))
	upViewport()

	#---Create Layout 2.

	L2 <- grid.layout(1,2,widths=unit(c(1,1),c("char","null")))
	pushViewport(viewport(layout.pos.row=2, layout=L2))	## Push row 2 of Layout 1.

	#---Create Layout 3.

	L3 <- grid.layout(dim(values)[1],dim(values)[2],respect=T,just=c("left","top"))
	pushViewport(viewport(layout.pos.col=2))			## Push col 2 of Layout 2;

	#---Push Layout 3, but with adjustments to accomodate possible partitions.

	pushViewport(viewport(layout=L3, x=0, y=1,
				    just=c(0,1),
				    width =unit(1,"npc")-unit(gap,"mm")*(length(v.parts)-1),
				    height=unit(1,"npc")-unit(gap,"mm")*(length(h.parts)-1)))

	#---Draw cellgrams.

	for (i in 1:dim(values)[1]){
		for (j in 1:dim(values)[2]){

			pushViewport(viewport(layout.pos.row=i, layout.pos.col=j))
			pushViewport(viewport(just=c(0,1), height=1, width=1,
							x=unit(gap,"mm")*v.gaps[j],
							y=unit(1,"npc")-unit(gap,"mm")*h.gaps[i]))

			pattern <- patterns[[types[i,j]]]

			if ((cor.matrix == TRUE) && (i==j))

			{
			 grid.rect(gp=gpar(fill="grey90"))
			 grid.text(var.names[i],gp=gpar(cex=1.8))
			} else

			cellgram(cell  = values[i,j,],
				   shape   	 = pattern[[1]],
				   shape.col = pattern[[2]],
				   shape.lty = pattern[[3]],
				   cell.fill = pattern[[4]],
				   back.fill = pattern[[5]],
				   label	   = pattern[[6]],
				   label.size= pattern[[7]],
				   ref.col	 = pattern[[8]],
				   ref.grid	 = pattern[[9]],
				   scale.max = pattern[[10]],
				   shape.name= paste(i,j))

			##grid.rect()
			if ((j==1) && (table.label == TRUE)) {
				if (side.rot==0) {grid.text(side.label[i], x=-0.04, just=1, gp=gpar(cex=label.size))}
				            else {grid.text(side.label[i], x=-0.1, just=c("center"), rot=side.rot, gp=gpar(cex=label.size))}
				}
			if ((i==1) && (table.label == TRUE)) {grid.text(top.label[j],  y=1.05, vjust=0, gp=gpar(cex=label.size))}
			upViewport()
			upViewport()
			}
		}
	popViewport(0)
	}


