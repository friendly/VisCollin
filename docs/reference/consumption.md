# Consumption Function Dataset

Example from pp 149-154 of Belsley (1991), Conditioning Diagnostics

## Format

A data frame with 28 observations on the following 5 variables.

- year:

  1947 to 1974

- cons:

  total consumption, 1958 dollars

- rate:

  the interest rate (Moody's Aaa)

- dpi:

  disposable income, 1958 dollars

- d_dpi:

  annual change in disposable income

## References

Belsley, D.A. (1991). Conditioning diagnostics, collinearity and weak
data in regression. New York: John Wiley & Sons.

## Examples

``` r
data(consumption)

ct1 <- with(consumption, c(NA,cons[-length(cons)]))
# compare (5.3)
m1 <- lm(cons ~ ct1 + dpi + rate + d_dpi, data = consumption)
anova(m1)
#> Analysis of Variance Table
#> 
#> Response: cons
#>           Df Sum Sq Mean Sq    F value    Pr(>F)    
#> ct1        1 300165  300165 23721.4022 < 2.2e-16 ***
#> dpi        1   1653    1653   130.6481 1.006e-10 ***
#> rate       1     24      24     1.9073    0.1811    
#> d_dpi      1     10      10     0.7685    0.3902    
#> Residuals 22    278      13                         
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# compare exhibit 5.11
with(consumption, cor(cbind(ct1, dpi, rate, d_dpi), use="complete.obs"))
#>             ct1       dpi      rate     d_dpi
#> ct1   1.0000000 0.9973816 0.9746852 0.3138422
#> dpi   0.9973816 1.0000000 0.9669347 0.3765246
#> rate  0.9746852 0.9669347 1.0000000 0.2290986
#> d_dpi 0.3138422 0.3765246 0.2290986 1.0000000
# compare exhibit 5.12
cd<-colldiag(m1)
cd
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>            ct1   dpi   rate  d_dpi
#> 1    1.000 0.000 0.000 0.000 0.003
#> 2    3.767 0.000 0.000 0.003 0.178
#> 3   26.437 0.005 0.003 0.827 0.053
#> 4  256.573 0.995 0.997 0.169 0.765
print(cd,fuzz=.3)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>            ct1   dpi   rate  d_dpi
#> 1    1.000  .     .     .     .   
#> 2    3.767  .     .     .     .   
#> 3   26.437  .     .    0.827  .   
#> 4  256.573 0.995 0.997  .    0.765

```
