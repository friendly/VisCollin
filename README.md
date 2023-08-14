
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VisCollin <img src="man/figures/logo.png" style="float:right; height:200px;" />

**Visualizing Collinearity Diagnostics**

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN](https://www.r-pkg.org/badges/version/VisCollin)](https://cran.r-project.org/package=VisCollin)
[![License](https://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-2.0.html)
[![Last
Commit](https://img.shields.io/github/last-commit/friendly/VisCollin)](https://github.com/friendly/VisCollin)
<!-- badges: end -->

The `VisCollin` package provides methods to calculate diagnostics for
multicollinearity among predictors in a linear or generalized linear
model. It also provides methods to visualize those diagnostics following
Friendly & Kwan (2009), “Where’s Waldo: Visualizing Collinearity
Diagnostics”, *The American Statistician*, **63**, 56–65.

These include:

- better tabular presentation of collinearity diagnostics that highlight
  the important numbers.
- a semi-graphic tableplot of the diagnostics to make warning and danger
  levels more salient and
- a collinearity biplot of the *smallest dimensions* of predictor space,
  where collinearity is most apparent.

## Installation

`VisCollin` is not yet on CRAN. You can install the development version
of VisCollin from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("friendly/VisCollin")
```

## Example

This example uses the `cars` data set containing various measures of
size and performance on 406 models of automobiles from 1982.

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

Fit a model predicting gas mileage (`mpg`) from the number of cylinders,
engine displacement, horsepower, weight, time to accelerate from 0 – 60
mph and model year (1970–1982). Perhaps surprisingly, only `weight` and
`year` appear to significantly predict gas mileage. What’s going on
here?

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

`lmtest::coeftest()` shows the coefficients, $\hat{\beta_j}$, their
standard errors $s(\hat{\beta_j})$ and associated t statistics,
$t = \hat{\beta_j} / s(\hat{\beta_j})$. As we will see, the standard
errors of the non-significant predictors have been inflated due to high
multiple correlations among the predictors, making the $t$ statistics
smaller.

``` r
lmtest::coeftest(cars.mod)
#> 
#> t test of coefficients:
#> 
#>                Estimate  Std. Error  t value  Pr(>|t|)    
#> (Intercept) -1.4535e+01  4.7639e+00  -3.0511  0.002438 ** 
#> cylinder    -3.2986e-01  3.3210e-01  -0.9932  0.321217    
#> engine       7.6784e-03  7.3577e-03   1.0436  0.297332    
#> horse       -3.9136e-04  1.3837e-02  -0.0283  0.977450    
#> weight      -6.7946e-03  6.7002e-04 -10.1409 < 2.2e-16 ***
#> accel        8.5273e-02  1.0204e-01   0.8357  0.403830    
#> year         7.5337e-01  5.2618e-02  14.3176 < 2.2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### Variance inflation factors

Variance inflation factors measure the effect of multicollinearity on
the standard errors of the estimated coefficients and are proportional
to $1 / (1 - R^2_{x_j | \text{others}})$.

We check the variance inflation factors, using `car::vif()`. We see that
most predictors have very high VIFs, indicating severe
multicollinearity.

``` r
vif(cars.mod)
#>  cylinder    engine     horse    weight     accel      year 
#> 10.633049 19.641683  9.398043 10.731681  2.625581  1.244829
sqrt(vif(cars.mod))
#> cylinder   engine    horse   weight    accel     year 
#> 3.260836 4.431894 3.065623 3.275924 1.620364 1.115719
```

According to $\sqrt{VIF}$, the standard error of `cylinder` has been
multiplied by 3.26 compared with the case when all predictors are
uncorrelated.

### Diagnostics

The diagnostic measures introduced by Belsley (1991) are based on the
eigenvalues $\lambda_1, \lambda_2, \dots \lambda_p$ of the correlation
matrix $R_{X}$ of the predictors (preferably centered and scaled, and
not including the constant term for the intercept), and the
corresponding eigenvectors in the columns of $\mathbf{V}_{p \times p}$.

`colldiag()` calculates:

- **Condition indices**: The smallest of the eigenvalues, those for
  which $\lambda_j \approx 0$, indicate collinearity and the number of
  small values indicates the number of near collinear relations.  
  Because the sum of the eigenvalues, $\Sigma \lambda_i = p$ which
  increases with the number of predictors, it is useful to scale them
  all in relation to the largest. This leads to *condition indices*,
  defined as $\kappa_j = \sqrt{ \lambda_1 / \lambda_j}$. These have the
  property that the resulting numbers have common interpretations
  regardless of the number of predictors. For completely uncorrelated
  predictors, all $\kappa_j = 1$.

- **Variance decomposition proportions**: Large VIFs indicate variables
  that are involved in *some* nearly collinear relations, but they don’t
  indicate *which* other variable(s) each is involved with. For this
  purpose, Belsley et. al. (1980) and Belsley (1991) proposed
  calculation of the proportions of variance of each variable associated
  with each principal component as a decomposition of the coefficient
  variance for each dimension.

For the current model, the usual display contains both the condition
indices and variance proportions. However, even for a small example, it
is often difficult to know what numbers to pay attention to.

``` r
(cd <- colldiag(cars.mod, center=TRUE))
#> Condition
#> Index    Variance Decomposition Proportions
#>           cylinder engine horse weight accel year 
#> 1   1.000 0.005    0.003  0.005 0.004  0.009 0.010
#> 2   2.252 0.004    0.002  0.000 0.007  0.022 0.787
#> 3   2.515 0.004    0.001  0.002 0.010  0.423 0.142
#> 4   5.660 0.309    0.014  0.306 0.087  0.063 0.005
#> 5   8.342 0.115    0.000  0.654 0.715  0.469 0.052
#> 6  10.818 0.563    0.981  0.032 0.176  0.013 0.004
```

Belsley (1991) recommends that the sources of collinearity be diagnosed
(a) only for those components with large $\kappa_j$, and (b) for those
components for which the variance proportion is large (say, $\ge 0.5$)
on *two* or more predictors. The print method for `"colldiag"` objects
has a `fuzz` argument controlling this.

``` r
print(cd, fuzz = 0.5)
#> Condition
#> Index    Variance Decomposition Proportions
#>           cylinder engine horse weight accel year 
#> 1   1.000  .        .      .     .      .     .   
#> 2   2.252  .        .      .     .      .    0.787
#> 3   2.515  .        .      .     .      .     .   
#> 4   5.660  .        .      .     .      .     .   
#> 5   8.342  .        .     0.654 0.715   .     .   
#> 6  10.818 0.563    0.981   .     .      .     .
```

The mystery is solved: There are two nearly collinear relations among
the predictors, corresponding to the two smallest dimensions.

- Dimension 5 reflects the high correlation between horsepower and
  weight,
- Dimension 6 reflects the high correlation between number of cylinders
  and engine displacement.

### Tableplot

The simplified tabular display above can be improved to make the
patterns of collinearity more visually apparent and to signify warnings
directly to the eyes. A “tableplot” (Kwan, 2009) is a semi-graphic
display that presents numerical information in a table using shapes
proportional to the value in a cell and other visual attributes (shape
type, color fill, and so forth) to encode other information.

For collinearity diagnostics, these show:

- the condition indices, using using *squares* whose background color is
  red for condition indices \> 10, green for values \> 5 and green
  otherwise, reflecting danger, warning and OK respectively. The value
  of the condition index is encoded within this using a white square
  whose side is proportional to the value (up to some maximum value,
  `cond.max`).
- Variance decomposition proportions are shown by filled *circles* whose
  radius is proportional to those values and are filled (by default)
  with shades ranging from white through pink to red. Rounded values of
  those diagnostics are printed in the cells.

The tableplot below encodes all the information from the values of
`colldiag()` printed above (but using `prop.col` color breaks such that
variance proportions \< 0.3 are shaded white). The visual message is
that one should attend to collinearities with large condition indices
**and** large variance proportions implicating two or more predictors.

<!-- ```{r cars-tableplot0} -->
<!-- knitr::include_graphics("man/figures/cars-tableplot.png") -->
<!-- ``` -->

``` r
tableplot(cd, title = "Tableplot of cars data", cond.max = 30 )
```

<img src="man/figures/README-cars-tableplot-1.png" width="100%" />

## References

Belsley, D.A., Kuh, E. and Welsch, R. (1980). *Regression Diagnostics*,
New York: John Wiley & Sons.

Belsley, D.A. (1991). *Conditioning diagnostics, collinearity and weak
data in regression*. New York: John Wiley & Sons.

Friendly, M., & Kwan, E. (2009). “Where’s Waldo: Visualizing
Collinearity Diagnostics.” *The American Statistician*, **63**, 56–65.
Online: <https://www.datavis.ca/papers/viscollin-tast.pdf>. Supp.
materials: <https://www.datavis.ca/papers/viscollin/>
