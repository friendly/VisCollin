# make a tableplot for collinearity diagnostics


tableplot.colldiag <- function(x, 
		prop.col = c("white", "pink", "red"),      # colors for variance proportions
		cond.col = c("#A8F48D", "#DDAB3E", "red"), # colors for condition indices
		cond.max = 100,                            # scale.max for condition indices
		prop.breaks = c(0, 20, 50, 100),
		cond.breaks = c(0, 5, 10, 1000),
		show.rows = nvar:1,
		title="",
		patterns
)
{
  if(inherits(x,"lm")) {
  	if(!require("perturb")) stop("requires perturb package for lm objects")
  	x <- colldiag(x, add.intercept=FALSE, center=TRUE)
  } else {
  	stopifnot(inherits(x,"colldiag"))
  }

	collin <- round(100 * x$pi)        # variance proportions
	condind <- round(x$condindx,2)     # condition indices
	vars <- colnames(x$pi)             # variable names
	nvar <- ncol(x$pi)                 # number of variables

  if(missing(patterns)) {
    patterns <- make.patterns(
    	shape=c(rep(0,3), rep(2,3)),           # squares and circles
      cell.fill=c(prop.col, rep("white",3)),
    	back.fill=c(rep("white",3), cond.col),
    	scale.max=rep(c(100,cond.max), each=3),
    	label=1, label.size=1, 
    	ref.grid=rep(c("yes","no"), each=3) 
    	)
  	}

  type.mat <- matrix(cut(collin, breaks=prop.breaks-0.1, labels=FALSE), dim(collin))  
  type.cond <- 3+cut(condind, breaks=cond.breaks-0.1, labels=FALSE)

	r.label = paste("#", show.rows, sep="")
  values <-cbind(condind, collin)[show.rows,]
  types <- cbind(type.cond, type.mat)[show.rows,]
  vars <- c("CondIndex", vars)
#  print(values, digits=4)
#  print(types)

#  h.parts <- as.vector(xtabs(~ cut(condind, breaks=cond.breaks-0.1, labels=FALSE)))
  h.parts <- rev(as.vector(xtabs(~ type.cond)))
#  print(h.parts)
  table.plot(values, types,
  	title=title,
  	top.label=vars, side.label=r.label,
  	patterns=patterns, 
  	v.parts=c(1,nvar), 
  	h.parts=h.parts,
  	gap=2
  	)
}
