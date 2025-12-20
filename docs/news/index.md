# Changelog

## VisCollin 0.1.4

- Added `tt.colldiag() using tinytable to print`“colldiag”\` results as
  a tinytable using background shading
- Now Depends (R \>= 4.1.0) to use pipes

## VisCollin 0.1.3

- print.colldiag() gains a `descending` argument to print in descending
  order of the condition index
- print.colldiag() gains a `percent` argument to print variance
  proportions as percents
- fixed documentation glitch in tableplot.colldiag
- added example of tableplot.colldiag

## VisCollin 0.1.2

CRAN release: 2023-09-05

- Fix the viewports in
  [`cellgram()`](https://friendly.github.io/VisCollin/reference/cellgram.md)
  so tableplot does not produce many images, requiring knitr option
  `fig.keep="last"` \[Thx: Paul Murrell\]

## VisCollin 0.1.1

CRAN release: 2023-08-17

- Correct minor CRAN nits in DESCRIPTION
- Add baseball data and example in `examples/`
- Lifecycle: stable
- Extend README with
  [`corrplot::corrplot()`](https://rdrr.io/pkg/corrplot/man/corrplot.html)
  and Remedies

## VisCollin 0.1.0

- Implements the function
  [`colldiag()`](https://friendly.github.io/VisCollin/reference/colldiag.md)
  and
  [`tableplot()`](https://friendly.github.io/VisCollin/reference/tableplot.md)
  methods for collinearity diagnostics.
- Added cars, biomass data
- Added extended README.Rmd
- Initial CRAN submission.
