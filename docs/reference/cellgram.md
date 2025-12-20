# Draw one cell in a tableplot

Draws a graphic representing one or more values for one cell in a
tableplot, using shapes whose size is proportional to the cell values
and other visual attributes (outline color, fill color, outline line
type, ...). Several values can be shown in a cell, using different
proportional shapes.

## Usage

``` r
cellgram(
  cell,
  shape = 0,
  shape.col = "black",
  shape.lty = 1,
  cell.fill = "white",
  back.fill = "white",
  label = 0,
  label.size = 0.7,
  ref.col = "grey80",
  ref.grid = FALSE,
  scale.max = 1,
  shape.name = ""
)
```

## Arguments

- cell:

  Numeric value(s) to be depicted in the table cell

- shape:

  Integer(s) or character string(s) specifying the shape(s) used to
  encode the numerical value of `cell`. Any of
  `0="circle", 1="diamond", 2="square"`. Recycled to match the number of
  values in the cell.

- shape.col:

  Outline color(s) for the shape(s). Recycled to match the number of
  values in the cell.

- shape.lty:

  Outline line type(s) for the shape(s). Recycled to match the number of
  values in the cell.

- cell.fill:

  Inside color of \|smallest\| shape in a cell

- back.fill:

  Background color of cell

- label:

  Number of cell values to be printed in the corners of the cell; max is
  4

- label.size:

  Character size of cell label(s)

- ref.col:

  color of reference lines

- ref.grid:

  whether to draw ref lines in the cells or not

- scale.max:

  scale values to this maximum

- shape.name:

  character string to uniquely identify shapes to help fill in smallest
  one

## Value

None. Used for its graphic side effect

## Examples

``` r
# None
```
