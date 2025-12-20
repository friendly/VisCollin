# Collinearity Diagnostics

Calculates condition indexes and variance decomposition proportions in
order to test for collinearity among the independent variables of a
regression model and identifies the sources of collinearity if present.

## Usage

``` r
colldiag(mod, scale = TRUE, center = FALSE, add.intercept = FALSE)

# S3 method for class 'colldiag'
print(
  x,
  dec.places = 3,
  fuzz = NULL,
  fuzzchar = ".",
  descending = FALSE,
  percent = FALSE,
  ...
)
```

## Source

These functions were taken from the (now defunct) `perturb` package by
John Hendrickx. He credits the Stata program `coldiag` by Joseph
Harkness <joe.harkness@jhu.edu>, Johns Hopkins University.

## Arguments

- mod:

  A model object, such as computed by `lm` or `glm`, or a data-frame to
  be used as predictors in such a model.

- scale:

  If `FALSE`, the data are left unscaled. If `TRUE`, the data are
  scaled, typically to mean 0 and variance 1 using
  [`scale`](https://rdrr.io/r/base/scale.html). Default is `TRUE`.

- center:

  If TRUE, data are centered. Default is `FALSE`.

- add.intercept:

  if `TRUE`, an intercept is added. Default is `FALSE`.

- x:

  A `colldiag` object

- dec.places:

  Number of decimal places to use when printing

- fuzz:

  Variance decomposition proportions less than *fuzz* are printed as
  *fuzzchar*

- fuzzchar:

  Character for small variance decomposition proportion values

- descending:

  Logical; `TRUE` prints the rows in descending order of condition
  indices

- percent:

  Logical; if `TRUE`, the variance proportions are printed as percents,
  0-100

- ...:

  arguments to be passed on to or from other methods (unused)

## Value

A `"colldiag"` object, containing:

- condindx:

  A one-column matrix of condition indexes

- pi:

  A square matrix of variance decomposition proportions. The rows refer
  to the principal component dimensions, the columns to the predictor
  variables.

`print.colldiag` prints the condition indexes as the first column of a
table with the variance decomposition proportions beside them.
`print.colldiag` has a `fuzz` option to suppress printing of small
numbers. If fuzz is used, small values are replaces by a period “.”.
`Fuzzchar` can be used to specify an alternative character.

## Details

`colldiag` is an implementation of the regression collinearity
diagnostic procedures found in Belsley, Kuh, and Welsch (1980). These
procedures examine the “conditioning” of the matrix of independent
variables.

It computes the condition indexes of the model matrix. If the largest
condition index (the condition number) is *large* (Belsley et al suggest
30 or higher), then there may be collinearity problems. All *large*
condition indexes may be worth investigating.

`colldiag` also provides further information that may help to identify
the source of these problems, the *variance decomposition proportions*
associated with each condition index. If a large condition index is
associated two or more variables with *large* variance decomposition
proportions, these variables may be causing collinearity problems.
Belsley et al suggest that a *large* proportion is 50 percent or more.

Note that such collinearity diagnostics are often provided by other
software for the model matrix including the constant term for the
intercept (e.g., SAS PROC REG, with the option COLLIN). However, these
are generally useless and misleading unless the intercept has some real
interpretation and the origin of the regressors is contained within the
prediction space, as explained by Fox (1997, p. 351). The default values
for `scale`, `center` and `add.intercept` exclude the constant term, and
correspond to the SAS option COLLINNOINT.

## Note

Missing data is silently omitted in these calculations

## References

Belsley, D.A., Kuh, E. and Welsch, R. (1980). Regression Diagnostics,
New York: John Wiley & Sons.

Belsley, D.A. (1991). Conditioning diagnostics, collinearity and weak
data in regression. New York: John Wiley & Sons.

Fox, J. (1997). Applied Regression Analysis, Linear Models, and Related
Methods. thousand Oaks, CA: Sage Publications.

Friendly, M., & Kwan, E. (2009). Where’s Waldo: Visualizing Collinearity
Diagnostics. *The American Statistician*, **63**, 56–65.

## See also

[`lm`](https://rdrr.io/r/stats/lm.html),
[`scale`](https://rdrr.io/r/base/scale.html),
[`svd`](https://rdrr.io/r/base/svd.html),
`[car]`[`vif`](https://rdrr.io/pkg/car/man/vif.html),
`[rms]`[`vif`](https://rdrr.io/pkg/rms/man/vif.html)

## Author

John Hendrickx

## Examples

``` r
data(cars, package = "VisCollin")
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                data=cars)
car::vif(cars.mod)
#>  cylinder    engine     horse    weight     accel      year 
#> 10.633049 19.641683  9.398043 10.731681  2.625581  1.244829 

# SAS PROC REG / COLLIN option, including the intercept
colldiag(cars.mod, add.intercept = TRUE)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>           intercept cylinder engine horse weight accel year 
#> 1   1.000 0.000     0.000    0.000  0.000 0.000  0.000 0.000
#> 2   4.821 0.000     0.001    0.013  0.004 0.001  0.012 0.001
#> 3  16.620 0.003     0.023    0.065  0.270 0.006  0.078 0.003
#> 4  25.625 0.008     0.273    0.002  0.088 0.199  0.170 0.017
#> 5  36.384 0.007     0.548    0.914  0.001 0.271  0.021 0.013
#> 6  37.447 0.006     0.134    0.004  0.444 0.468  0.598 0.068
#> 7  91.281 0.976     0.020    0.002  0.191 0.055  0.122 0.898

# Default settings: scaled, not centered, no intercept, like SAS PROC REG / COLLINNOINT
colldiag(cars.mod)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>           cylinder engine horse weight accel year 
#> 1   1.000 0.000    0.000  0.000 0.000  0.000 0.000
#> 2   4.757 0.001    0.013  0.005 0.000  0.023 0.007
#> 3  15.896 0.027    0.085  0.435 0.003  0.054 0.031
#> 4  24.742 0.379    0.004  0.036 0.229  0.157 0.168
#> 5  34.020 0.221    0.666  0.110 0.675  0.285 0.004
#> 6  35.464 0.372    0.230  0.414 0.093  0.480 0.790

(cd <- colldiag(cars.mod, center=TRUE))
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>           cylinder engine horse weight accel year 
#> 1   1.000 0.005    0.003  0.005 0.004  0.009 0.010
#> 2   2.252 0.004    0.002  0.000 0.007  0.022 0.787
#> 3   2.515 0.004    0.001  0.002 0.010  0.423 0.142
#> 4   5.660 0.309    0.014  0.306 0.087  0.063 0.005
#> 5   8.342 0.115    0.000  0.654 0.715  0.469 0.052
#> 6  10.818 0.563    0.981  0.032 0.176  0.013 0.004

# fuzz small values
print(cd, fuzz = 0.5)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>           cylinder engine horse weight accel year 
#> 1   1.000  .        .      .     .      .     .   
#> 2   2.252  .        .      .     .      .    0.787
#> 3   2.515  .        .      .     .      .     .   
#> 4   5.660  .        .      .     .      .     .   
#> 5   8.342  .        .     0.654 0.715   .     .   
#> 6  10.818 0.563    0.981   .     .      .     .   

# Biomass data
data(biomass)

biomass.mod <- lm (biomass ~ H2S + sal + Eh7 + pH + buf + P + K +
                             Ca + Mg + Na + Mn + Zn + Cu + NH4,
                   data=biomass)
car::vif(biomass.mod)
#>       H2S       sal       Eh7        pH       buf         P         K        Ca 
#>  3.027456  3.387615  1.977447 62.080846 34.431748  1.895804  7.367110 16.662146 
#>        Mg        Na        Mn        Zn        Cu       NH4 
#> 23.764229 10.351043  6.185628 11.626479  4.829203  8.376506 

cd <- colldiag(biomass.mod, center=TRUE)
# simplified display
print(colldiag(biomass.mod, center=TRUE), fuzz=.3)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>            H2S sal Eh7   pH    buf   P     K  Ca    Mg    Na Mn    Zn    Cu   
#> 1    1.000  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 2    1.154  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 3    1.750  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 4    1.921  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 5    2.668  .   .   .     .     .    0.426  .  .     .     .  .     .     .   
#> 6    3.136  .   .  0.360  .     .     .     .  .     .     .  .     .     .   
#> 7    3.574  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 8    3.596  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 9    5.447  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 10   5.868  .   .   .     .     .     .     .  .     .     .  .     .     .   
#> 11   7.529  .   .   .     .     .     .     .  .     .     .  .    0.320  .   
#> 12  10.427  .   .   .     .     .     .     .  .     .     .  .     .    0.426
#> 13  12.843  .   .   .     .     .     .     .  .    0.671  .  .    0.453  .   
#> 14  22.775  .   .   .    0.955 0.697  .     . 0.596  .     . 0.338  .     .   
#>    NH4
#> 1   . 
#> 2   . 
#> 3   . 
#> 4   . 
#> 5   . 
#> 6   . 
#> 7   . 
#> 8   . 
#> 9   . 
#> 10  . 
#> 11  . 
#> 12  . 
#> 13  . 
#> 14  . 
```
