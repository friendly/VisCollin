# `tinytable` Output Method for "colldiag" Objects

This function uses the tinytable package to give a display of
collinearity diagnostics with shaded backgrounds indicating the severity
of collinearity in the dimensions of the data and the proportions of
variance related to each variable in these dimensions. It gives a table
version of the graphic shown by
[`tableplot`](https://friendly.github.io/VisCollin/reference/tableplot.md),
but something that can be rendered in HTML, PDF and other formats.

## Usage

``` r
# S3 method for class 'colldiag'
tt(
  x,
  digits = 2,
  fuzz = NULL,
  descending = FALSE,
  percent = FALSE,
  prop.col = c("white", "pink", "red"),
  cond.col = c("#A8F48D", "#DDAB3E", "red"),
  prop.breaks = c(0, 0.2, 0.5, 1),
  cond.breaks = c(0, 5, 10, 1000),
  ...
)
```

## Arguments

- x:

  A `"colldiag"` object

- digits:

  Number of digits to use when printing; set to 0 when `percent = TRUE`

- fuzz:

  Variance decomposition proportions less than *fuzz* are printed as
  *fuzzchar*

- descending:

  Logical; `TRUE` prints the values in descending order of condition
  indices

- percent:

  Logical; if `TRUE`, the variance proportions are printed as percents,
  0-100

- prop.col:

  A vector of colors used for the variance proportions. The default is
  `c("white", "pink", "red")`.

- cond.col:

  A vector of colors used for the condition indices, according to
  `cond.breaks`

- prop.breaks:

  Scale breaks for the variance proportions, a vector of length one more
  than the number of `prop.col`, whose values are between 0 and 1.

- cond.breaks:

  Scale breaks for the condition indices a vector of length one more
  than the number of `cond.col`

- ...:

  arguments to be passed on to or from other methods (unused)

## Value

a `"tinytable"` object

## Details

The `"tinytable"` object returned can be customized using other
functions from the tinytable package.

## See also

[`colldiag`](https://friendly.github.io/VisCollin/reference/colldiag.md),
[`tableplot`](https://friendly.github.io/VisCollin/reference/tableplot.md),
[`tinytable`](https://vincentarelbundock.github.io/tinytable/man/tinytable-package.html)

## Author

Michael Friendly

## Examples

``` r
library(VisCollin)
library(tinytable)
data(cars, package = "VisCollin")
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                data = cars)
cd <- colldiag(cars.mod, center=TRUE)
# show all values, in same order as `cd`
tt(cd) |> print(output = "html")
#> Error: `x` must be a data.frame.

# show results in percent
tt(cd, percent = TRUE) |> print(output = "html")
#> Error: `x` must be a data.frame.

# try descending & fuzz
tt(cd, descending = TRUE, fuzz = 0.3) |> print(output = "html")
#> Error: `x` must be a data.frame.
```
