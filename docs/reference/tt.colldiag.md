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
  font.scale = 1,
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

  Scale breaks for the variance proportions, a vector of length *one
  more* than the number of `prop.col`, whose values are between 0 and 1.

- cond.breaks:

  Scale breaks for the condition indices a vector of length *one more*
  than the number of `cond.col`

- font.scale:

  Controls font size scaling for variance proportions. Either a single
  numeric value (no scaling) or a vector of length 2 specifying the
  minimum and maximum font sizes in `em` units. Default is `1` (no
  scaling). Use `c(1, 1.5)` to scale font sizes from 1em to 1.5em based
  on variance proportion values, making larger proportions more visually
  prominent.

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
tt(cd)
#> 
#> +------------+----------+--------+-------+--------+-------+------+
#> | Cond
#> +------------+----------+--------+-------+--------+-------+------+
#> index | cylinder | engine | horse | weight | accel | year |
#> +============+==========+========+=======+========+=======+======+
#> | 1.00       | 0.00     | 0.00   | 0.01  | 0.00   | 0.01  | 0.01 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.25       | 0.00     | 0.00   | 0.00  | 0.01   | 0.02  | 0.79 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.52       | 0.00     | 0.00   | 0.00  | 0.01   | 0.42  | 0.14 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 5.66       | 0.31     | 0.01   | 0.31  | 0.09   | 0.06  | 0.01 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 8.34       | 0.12     | 0.00   | 0.65  | 0.72   | 0.47  | 0.05 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 10.82      | 0.56     | 0.98   | 0.03  | 0.18   | 0.01  | 0.00 |
#> +------------+----------+--------+-------+--------+-------+------+ 

# show results in percent
tt(cd, percent = TRUE)
#> 
#> +------------+----------+--------+-------+--------+-------+------+
#> | Cond
#> +------------+----------+--------+-------+--------+-------+------+
#> index | cylinder | engine | horse | weight | accel | year |
#> +============+==========+========+=======+========+=======+======+
#> | 1.00       | 0        | 0      | 1     | 0      | 1     | 1    |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.25       | 0        | 0      | 0     | 1      | 2     | 79   |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.52       | 0        | 0      | 0     | 1      | 42    | 14   |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 5.66       | 31       | 1      | 31    | 9      | 6     | 1    |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 8.34       | 12       | 0      | 65    | 72     | 47    | 5    |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 10.82      | 56       | 98     | 3     | 18     | 1     | 0    |
#> +------------+----------+--------+-------+--------+-------+------+ 

# try descending & fuzz
tt(cd, descending = TRUE, fuzz = 0.3)
#> 
#> +------------+----------+--------+-------+--------+-------+------+
#> | Cond
#> +------------+----------+--------+-------+--------+-------+------+
#> index | cylinder | engine | horse | weight | accel | year |
#> +============+==========+========+=======+========+=======+======+
#> | 10.82      | 0.56     | 0.98   |       |        |       |      |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 8.34       |          |        | 0.65  | 0.72   | 0.47  |      |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 5.66       | 0.31     |        | 0.31  |        |       |      |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.52       |          |        |       |        | 0.42  |      |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.25       |          |        |       |        |       | 0.79 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 1.00       |          |        |       |        |       |      |
#> +------------+----------+--------+-------+--------+-------+------+ 

# vary font size from 1em to 1.5em based on variance proportions
tt(cd, font.scale = c(1, 1.5))
#> 
#> +------------+----------+--------+-------+--------+-------+------+
#> | Cond
#> +------------+----------+--------+-------+--------+-------+------+
#> index | cylinder | engine | horse | weight | accel | year |
#> +============+==========+========+=======+========+=======+======+
#> | 1.00       | 0.00     | 0.00   | 0.01  | 0.00   | 0.01  | 0.01 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.25       | 0.00     | 0.00   | 0.00  | 0.01   | 0.02  | 0.79 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 2.52       | 0.00     | 0.00   | 0.00  | 0.01   | 0.42  | 0.14 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 5.66       | 0.31     | 0.01   | 0.31  | 0.09   | 0.06  | 0.01 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 8.34       | 0.12     | 0.00   | 0.65  | 0.72   | 0.47  | 0.05 |
#> +------------+----------+--------+-------+--------+-------+------+
#> | 10.82      | 0.56     | 0.98   | 0.03  | 0.18   | 0.01  | 0.00 |
#> +------------+----------+--------+-------+--------+-------+------+ 
```
