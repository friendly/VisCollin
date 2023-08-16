# last modified 7/29/2008 2:36PM by MF
#  -- allow named shapes in addition to 0,1,2

#' Draw one cell in a tableplot
#'
#' @description Draws a graphic representing one or more values for one cell in a tableplot,
#' using shapes whose size is proportional to the cell values and other visual attributes
#' (outline color, fill color, outline line type, ...).
#' Several values can be shown in a cell, using different proportional shapes.
#'
#'
#' @param cell        Numeric value(s) to be depicted in the table cell
#' @param shape       Integer(s) or character string(s) specifying the shape(s) used to encode the numerical value of
#'                    \code{cell}.
#'                    Any of \code{0="circle", 1="diamond", 2="square"}. Recycled to match the number of values
#'                    in the cell.
#' @param shape.col   Outline color(s) for the shape(s). Recycled to match the number of values
#'                    in the cell.
#' @param shape.lty   Outline line type(s) for the shape(s). Recycled to match the number of values
#'                    in the cell.
#' @param cell.fill   Inside color of |smallest| shape in a cell
#' @param back.fill   Background color of cell
#' @param label       Number of cell values to be printed in the corners of the cell; max is 4
#' @param label.size  Character size of cell label(s)
#' @param ref.col     color of reference lines
#' @param ref.grid    whether to draw ref lines in the cells or not
#' @param scale.max   scale values to this maximum
#' @param shape.name  character string to uniquely identify shapes to help fill in smallest one
#'
#' @return None. Used for its graphic side effect
#' @export
#'
#' @examples
#' # None
#'
cellgram = function(

	## Arguments that may be vectorized:

	cell,  		           # actual cell value(s)
	shape = 0,		       # shape of cell value(s); 0 = "circle", 1 = "diamond", 2 = "square"
	shape.col = "black", # color of shape(s), outline only
	shape.lty = 1,	     # line type used for shape(s)

	## Arguments that will never be vectorized:

	cell.fill = "white", # fill color of smallest cell value
	back.fill = "white", # back fill color
	label = 0,		       # how many cell values will be printed; max is 4
	label.size = 0.7,    # size of cell label(s)
	ref.col = "grey80",
	ref.grid = FALSE,
	scale.max = 1,
	shape.name = "")	 # uniquely identify shapes to help fill in smallest one

	{

	grid.rect(gp=gpar(fill=back.fill, lwd=0.2))

	if (length(cell)>length(shape))     shape=rep(shape, length(cell))
	if (length(cell)>length(shape.col)) shape.col=rep(shape.col, length(cell))
	if (length(cell)>length(shape.lty)) shape.lty=rep(shape.lty, length(cell))

	## Draw grid reference lines:

	if (ref.grid==TRUE) {
		grid.segments(x0=0,y0=.5,x1=1,y1=.5, gp=gpar(col=ref.col, lwd=0.2))
		grid.segments(x0=.5,y0=0,x1=.5,y1=1, gp=gpar(col=ref.col, lwd=0.2))
		}

	## Rescale cell values:

	s.cell = cell / scale.max

	## Draw cell values:

	for (k in 1:length(cell)){

		if (!is.na(cell[k])) { ## This is to allow missing values; but if all missing, then error ensues!

			if (cell[k] < 0) this.col="red" else this.col=shape.col[k]
			#this.col = shape.col[k]

			#if (cell[k] < 0) this.lty=3 else this.lty=shape.lty[k]
			this.lty = shape.lty[k]

			if (cell[k] < 0) this.shape = 1 else this.shape=shape[k]

			if (this.shape==0 || this.shape=="circle")
				grid.circle(name=paste(shape.name, k, sep=""),
					r=abs(s.cell[k]/2),
					gp=gpar(col=this.col, lty=this.lty, lwd=0.1))

			if (this.shape==1 || this.shape=="diamond") {
				r1 = 0.5 - 0.5*abs(s.cell[k])
				r2 = 0.5*abs(s.cell[k]) + 0.5
				grid.polygon(name=paste(shape.name,k,sep=""),
					x=c(r1, .5, r2, .5), y=c(.5, r2, .5, r1),
					gp=gpar(col=this.col, lty=this.lty, lwd=0.1)) }

			if (this.shape==2 || this.shape=="square")
				grid.rect(name=paste(shape.name,k,sep=""), height=abs(s.cell[k]), width=abs(s.cell[k]),
					gp=gpar(col=this.col, lty=this.lty))
		}}

	grid.edit(paste(shape.name,which.min(abs(cell)),sep=""), gp=gpar(fill=cell.fill))

	## Labels
	if (label > 0){
		cell = sort(cell,decreasing=T)
		d = matrix(c(1, 1,
		             0, 0,
		             0, 1,
		             1, 0), 4,2)
		for (k in 1:min(label,4,length(cell))){
			grid.text(cell[k], gp=gpar(cex=label.size),
			    x=unit(c(.97,.97,.03,.03)[k],"npc"),
			    y=unit(c(.03,.97,.97,.03)[k],"npc"), just=d[k,])
			}
		}
	}
