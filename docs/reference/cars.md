# Cars Data

Data from the 1983 ASA Data Exposition, held in conjunction with the
Annual Meetings in Toronto, August 15-18, 1983,
<https://community.amstat.org/jointscsg-section/dataexpo/dataexpobefore1993>
The data set was collected by Ernesto Ramos and David Donoho on
characteristics of automobiles.

## Format

A data frame with 406 observations on the following 10 variables:

- `make`:

  make of car, a factor with levels `amc` `audi` `bmw` `buick`
  `cadillac` `chev` `chrysler` `citroen` `datsun` `dodge` `fiat` `ford`
  `hi` `honda` `mazda` `mercedes` `mercury` `nissan` `oldsmobile` `opel`
  `peugeot` `plymouth` `pontiac` `renault` `saab` `subaru` `toyota`
  `triumph` `volvo` `vw`

- `model`:

  model of car, a character vector

- `mpg`:

  miles per gallon, a numeric vector

- `cylinder`:

  number of cylinders, a numeric vector

- `engine`:

  engine displacement (cu. inches), a numeric vector

- `horse`:

  horsepower, a numeric vector

- `weight`:

  vehicle weight (lbs.), a numeric vector

- `accel`:

  time to accelerate from O to 60 mph (sec.), a numeric vector

- `year`:

  model year (modulo 100), a numeric vector ranging from 70 – 82

- `origin`:

  region of origin, a factor with levels `Amer` `Eur` `Japan`

## Source

The data was provided for the ASA Data Exposition in a "shar" file,
<http://lib.stat.cmu.edu/datasets/cars.data>. It is a version of that
used by Donoho and Ramos (1982) to illustrate PRIM-H.

## References

Donoho, David and Ramos, Ernesto (1982), “PRIMDATA: Data Sets for Use
With PRIM-H” (Draft).

## Examples

``` r
data(cars, package = "VisCollin")
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                data=cars)
car::vif(cars.mod)
#>  cylinder    engine     horse    weight     accel      year 
#> 10.633049 19.641683  9.398043 10.731681  2.625581  1.244829 

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

# simplified display
print(cd, fuzz=.3)
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>           cylinder engine horse weight accel year 
#> 1   1.000  .        .      .     .      .     .   
#> 2   2.252  .        .      .     .      .    0.787
#> 3   2.515  .        .      .     .     0.423  .   
#> 4   5.660 0.309     .     0.306  .      .     .   
#> 5   8.342  .        .     0.654 0.715  0.469  .   
#> 6  10.818 0.563    0.981   .     .      .     .   
```
