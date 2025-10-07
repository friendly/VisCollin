# Help for VisCollin: color backgrounds for cells in different columns
#

This is a request for a bit of help if you can, rather than an issue with tinytable.
My [`VisCollin`]() package has a print method for collinearity diagnostics that would make a great use case
for `tinytable`, if I could figure out how to shade the backgrounds of cells according to the 
condition indices and the variance proportions.

The print method has options to sort rows by condition indices, and fuzz values of the variance proportions
less than some value

```
data(cars, package = "VisCollin")
cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
                data = cars)
cd <- colldiag(cars.mod, center=TRUE)
print(cd, fuzz = 0.3, descending = TRUE)
```

Produces this output:

```
Condition
Index	  -- Variance Decomposition Proportions --
          cylinder engine horse weight accel year 
6  10.818 0.563    0.981   .     .      .     .   
5   8.342  .        .     0.654 0.715  0.469  .   
4   5.660 0.309     .     0.306  .      .     .   
3   2.515  .        .      .     .     0.423  .   
2   2.252  .        .      .     .      .    0.787
1   1.000  .        .      .     .      .     .  
```

I'd like to write a `tt.colldiag()` method that uses shaded backgrounds, similar to what I get in a graphic from `tableplot.colldiag()`




