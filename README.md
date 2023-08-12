
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
Diagnostics”, The American Statistician, 63, 56–65. These include a
semi-graphic tableplot of the diagnostics and a collinearity biplot of
the smallest dimensions of predictor space, where collinearity is most
apparent.

## Installation

You can install the development version of VisCollin from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("friendly/VisCollin")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(VisCollin)
## basic example code
```

## References

Belsley, D.A., Kuh, E. and Welsch, R. (1980). *Regression Diagnostics*,
New York: John Wiley & Sons.

Belsley, D.A. (1991). *Conditioning diagnostics, collinearity and weak
data in regression*. New York: John Wiley & Sons.

Friendly, M., & Kwan, E. (2009). “Where’s Waldo: Visualizing
Collinearity Diagnostics.” *The American Statistician*, **63**, 56–65.
