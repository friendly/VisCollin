
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VisCollin

<!-- badges: start -->

[![License](https://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-2.0.html)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Last
Commit](https://img.shields.io/github/last-commit/friendly/VisCollin)](https://github.com/friendly/VisCollin)
<!-- badges: end -->

The `VisCollin` package provides methods to calculate diagnostics for
multicollinearity among predictors in a linear or generalized linear
model. Also provides methods to visualize those diagnostics following
Friendly & Kwan (2009), “Where’s Waldo: Visualizing Collinearity
Diagnostics”, *The American Statistician*, **63**, 56–65.

These include:

- better tabular presentation of collinearity diagnostics that highlight
  the important numbers.
- a semi-graphic tableplot of the diagnostics and
- a collinearity biplot of the *smallest dimensions* of predictor space,
  where collinearity is most apparent.

## Installation

You can install the development version of VisCollin from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("friendly/VisCollin")
```

## Example

This example uses the `cars` data set.

``` r
library(VisCollin)
library(car)
#> Loading required package: carData

data(cars)
str(cars)
#> 'data.frame':    406 obs. of  10 variables:
#>  $ make    : Factor w/ 30 levels "amc","audi","bmw",..: 6 4 22 1 12 12 6 22 23 1 ...
#>  $ model   : chr  "chevelle" "skylark" "satellite" "rebel" ...
#>  $ mpg     : num  18 15 18 16 17 15 14 14 14 15 ...
#>  $ cylinder: int  8 8 8 8 8 8 8 8 8 8 ...
#>  $ engine  : num  307 350 318 304 302 429 454 440 455 390 ...
#>  $ horse   : int  130 165 150 150 140 198 220 215 225 190 ...
#>  $ weight  : int  3504 3693 3436 3433 3449 4341 4354 4312 4425 3850 ...
#>  $ accel   : num  12 11.5 11 12 10.5 10 9 8.5 10 8.5 ...
#>  $ year    : int  70 70 70 70 70 70 70 70 70 70 ...
#>  $ origin  : Factor w/ 3 levels "Amer","Eur","Japan": 1 1 1 1 1 1 1 1 1 1 ...
```

Fit model

``` r
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year, 
                data=cars)
Anova(cars.mod)
#> Anova Table (Type II tests)
#> 
#> Response: mpg
#>           Sum Sq  Df  F value Pr(>F)    
#> cylinder    11.6   1   0.9865 0.3212    
#> engine      12.9   1   1.0891 0.2973    
#> horse        0.0   1   0.0008 0.9775    
#> weight    1213.6   1 102.8374 <2e-16 ***
#> accel        8.2   1   0.6984 0.4038    
#> year      2419.1   1 204.9945 <2e-16 ***
#> Residuals 4543.3 385                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Check the VIFs

``` r
vif(cars.mod)
#>  cylinder    engine     horse    weight     accel      year 
#> 10.633049 19.641683  9.398043 10.731681  2.625581  1.244829
```

Diagnostics

``` r
cd <- colldiag(cars.mod, 
               add.intercept=FALSE, center=TRUE)

print(cd, fuzz = 0.3)
#> Condition
#> Index    Variance Decomposition Proportions
#>           cylinder engine horse weight accel year 
#> 1   1.000  .        .      .     .      .     .   
#> 2   2.252  .        .      .     .      .    0.787
#> 3   2.515  .        .      .     .     0.423  .   
#> 4   5.660 0.309     .     0.306  .      .     .   
#> 5   8.342  .        .     0.654 0.715  0.469  .   
#> 6  10.818 0.563    0.981   .     .      .     .
```

## References

Belsley, D.A., Kuh, E. and Welsch, R. (1980). *Regression Diagnostics*,
New York: John Wiley & Sons.

Belsley, D.A. (1991). *Conditioning diagnostics, collinearity and weak
data in regression*. New York: John Wiley & Sons.

Friendly, M., & Kwan, E. (2009). “Where’s Waldo: Visualizing
Collinearity Diagnostics.” *The American Statistician*, **63**, 56–65.
