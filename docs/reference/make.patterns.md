# Construct collection of pattern specifications for tableplot

Construct collection of pattern specifications for tableplot

## Usage

``` r
make.patterns(
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
  as.data.frame = FALSE
)
```

## Arguments

- n:

  Number of patterns

- shape:

  Shape(s) used to encode the numerical value of `cell`. Any of
  `0="circle", 1="diamond", 2="square"`. Recycled to match the number of
  values in the cell.

- shape.col:

  Outline color(s) for the shape(s)

- shape.lty:

  Outline line type(s) for the shape(s)

- cell.fill:

  inside color of \|smallest\| shape in a cell

- back.fill:

  background color of cell

- label:

  how many cell values will be labeled in the cell; max is 4

- label.size:

  size of cell label(s)

- ref.col:

  color of reference lines

- ref.grid:

  whether to draw ref lines in the cells or not

- scale.max:

  scale values to this maximum

- as.data.frame:

  whether to return a data.frame or a list.

## Value

Returns either a data.frame of a list. If a data.frame, the pattern
specifications appear as columns

## Examples

``` r
# None
```
