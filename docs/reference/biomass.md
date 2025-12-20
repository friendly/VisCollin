# Biomass Production in the Cape Fear Estuary

Data collected by Rick Linthurst (1979) at North Carolina State
University for the purpose of identifying the important soil
characteristics influencing aerial biomass production of the marsh grass
*Spartina alterniflora* in the Cape Fear Estuary of North Carolina.
Three types of Spartina vegetation areas (devegetated “dead” areas,
“short” Spartina areas, and “tall” Spartina areas) were sampled in each
of three locations (Oak Island, Smith Island, and Snows Marsh)

Samples of the soil substrate from 5 random sites within each
location–vegetation type (giving 45 total samples) were analyzed for 14
soil physico-chemical characteristics each month for several months.

## Format

A data frame with 45 observations on the following 17 variables.

- `loc`:

  location, a factor with levels `OI` `SI` `SM`

- `type`:

  area type, a factor with levels `DVEG` `SHRT` `TALL`

- `biomass`:

  aerial biomass in \\gm^{-2}\\, a numeric vector

- `H2S`:

  hydrogen sulfide ppm, a numeric vector

- `sal`:

  percent salinity, a numeric vector

- `Eh7`:

  ester-hydrolase, a numeric vector

- `pH`:

  acidity as measured in water, a numeric vector

- `buf`:

  a numeric vector

- `P`:

  phosphorus ppm, a numeric vector

- `K`:

  potassium ppm, a numeric vector

- `Ca`:

  calcium ppm, a numeric vector

- `Mg`:

  magnesium ppm, a numeric vector

- `Na`:

  sodium ppm, a numeric vector

- `Mn`:

  manganese ppm, a numeric vector

- `Zn`:

  zinc ppm, a numeric vector

- `Cu`:

  copper ppm, a numeric vector

- `NH4`:

  ammonium ion ppm, a numeric vector

## Source

Rawlings, J. O., Pantula, S. G., & Dickey, D. A. (2001). *Applied
Regression Analysis: A Research Tool*, 2nd Ed., Springer New York. Table
5.1.

## References

R. A. Linthurst. Aeration, nitrogen, pH and salinity as factors
affecting *Spartina Alterniflora* growth and dieback. PhD thesis, North
Carolina State University, 1979.

## Examples

``` r
data(biomass)
str(biomass)
#> 'data.frame':    45 obs. of  17 variables:
#>  $ loc    : Factor w/ 3 levels "OI","SI","SM": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ type   : Factor w/ 3 levels "DVEG","SHRT",..: 1 1 1 1 1 2 2 2 2 2 ...
#>  $ biomass: int  676 516 1052 868 1008 436 544 680 640 492 ...
#>  $ H2S    : int  -610 -570 -610 -560 -610 -620 -590 -610 -580 -610 ...
#>  $ sal    : int  33 35 32 30 33 33 36 30 38 30 ...
#>  $ Eh7    : int  -290 -268 -282 -232 -318 -308 -264 -340 -252 -288 ...
#>  $ pH     : num  5 4.75 4.2 4.4 5.55 5.05 4.25 4.45 4.75 4.6 ...
#>  $ buf    : num  2.34 2.66 4.18 3.6 1.9 3.22 4.5 3.5 2.62 3.04 ...
#>  $ P      : num  20.2 15.6 18.7 22.8 37.8 ...
#>  $ K      : num  1442 1299 1154 1045 522 ...
#>  $ Ca     : num  2150 1845 1750 1674 3360 ...
#>  $ Mg     : num  5169 4358 4041 3966 4609 ...
#>  $ Na     : num  35185 28170 26455 25073 31664 ...
#>  $ Mn     : num  14.29 7.73 17.81 49.15 30.52 ...
#>  $ Zn     : num  16.5 14 15.3 17.3 22.3 ...
#>  $ Cu     : num  5.02 4.19 4.79 4.09 4.6 ...
#>  $ NH4    : num  59.5 51.4 68.8 82.3 70.9 ...
biomass.mod <- lm (biomass ~ H2S + sal + Eh7 + pH + buf + P + K + Ca + Mg + Na +
                           Mn + Zn + Cu + NH4,
                 data=biomass)
car::vif(biomass.mod)
#>       H2S       sal       Eh7        pH       buf         P         K        Ca 
#>  3.027456  3.387615  1.977447 62.080846 34.431748  1.895804  7.367110 16.662146 
#>        Mg        Na        Mn        Zn        Cu       NH4 
#> 23.764229 10.351043  6.185628 11.626479  4.829203  8.376506 

(cd <- colldiag(biomass.mod, add.intercept=FALSE, center=TRUE))
#> Condition
#> Index      -- Variance Decomposition Proportions --
#>            H2S   sal   Eh7   pH    buf   P     K     Ca    Mg    Na    Mn   
#> 1    1.000 0.002 0.001 0.002 0.001 0.001 0.008 0.000 0.002 0.000 0.000 0.003
#> 2    1.154 0.000 0.000 0.007 0.000 0.000 0.002 0.009 0.001 0.003 0.006 0.001
#> 3    1.750 0.011 0.067 0.066 0.001 0.001 0.008 0.000 0.002 0.000 0.000 0.000
#> 4    1.921 0.118 0.016 0.034 0.000 0.001 0.016 0.000 0.000 0.000 0.000 0.028
#> 5    2.668 0.000 0.110 0.020 0.000 0.001 0.426 0.001 0.004 0.001 0.008 0.000
#> 6    3.136 0.116 0.000 0.360 0.001 0.000 0.000 0.000 0.022 0.000 0.001 0.029
#> 7    3.574 0.077 0.113 0.116 0.000 0.001 0.155 0.002 0.002 0.000 0.008 0.007
#> 8    3.596 0.005 0.008 0.130 0.000 0.002 0.220 0.005 0.005 0.003 0.051 0.120
#> 9    5.447 0.056 0.055 0.156 0.000 0.002 0.019 0.256 0.013 0.000 0.005 0.007
#> 10   5.868 0.202 0.107 0.025 0.002 0.002 0.001 0.292 0.002 0.004 0.130 0.148
#> 11   7.529 0.189 0.027 0.003 0.000 0.040 0.007 0.074 0.181 0.007 0.052 0.136
#> 12  10.427 0.002 0.159 0.034 0.039 0.133 0.049 0.003 0.159 0.147 0.282 0.022
#> 13  12.843 0.001 0.089 0.019 0.000 0.120 0.076 0.283 0.013 0.671 0.247 0.162
#> 14  22.775 0.222 0.248 0.028 0.955 0.697 0.012 0.076 0.596 0.164 0.210 0.338
#>    Zn    Cu    NH4  
#> 1  0.003 0.000 0.004
#> 2  0.000 0.009 0.000
#> 3  0.002 0.018 0.000
#> 4  0.001 0.002 0.001
#> 5  0.000 0.001 0.000
#> 6  0.000 0.003 0.035
#> 7  0.001 0.170 0.048
#> 8  0.010 0.042 0.007
#> 9  0.100 0.177 0.127
#> 10 0.000 0.024 0.129
#> 11 0.320 0.089 0.023
#> 12 0.094 0.426 0.240
#> 13 0.453 0.000 0.213
#> 14 0.015 0.041 0.173
# simplified display
print(cd, fuzz=.3)
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
