## Test environments
* local Windows 10, R version 4.2.3 (2023-03-15 ucrt)
* win-builder, R Under development (unstable) (2023-08-12 r84939 ucrt)

## R CMD check results

0 errors | 0 warnings | 1 note

win-builder gives the following:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Michael Friendly <friendly@yorku.ca>'

New submission

Possibly misspelled words in DESCRIPTION:
  Collinearity (2:20, 9:33)
  biplot (12:23)
  collinearity (10:48, 12:10, 12:85)
  multicollinearity (7:60)
  tableplot (11:18)

These spellcheck results are spurious -- all of the above are legitimate words and it would not look good for
them to be quoted in the DESCRIPTION.

## Version 0.1.0

* Implements the function `colldiag()` and `tableplot()` methods for collinearity diagnostics.
* Added cars, linthurst data
* Initial CRAN submission. 
