library(VisCollin)
library(tinytable)

# Test the new font size feature
data(cars, package = "VisCollin")

cars.mod <- lm(mpg ~ cylinder + engine + horse + weight + accel + year,
               data = cars)
cd <- colldiag(cars.mod, center=TRUE)

# Test 1: Basic call with default settings
cat("Test 1: Basic call\n")
tt(cd)

# Test 2: With percent = TRUE
cat("\nTest 2: With percent\n")
tt(cd, percent = TRUE)

# Test 3: With descending order and fuzz
cat("\nTest 3: Descending with fuzz\n")
tt(cd, descending = TRUE, fuzz = 0.3)

cat("\n=== Tests complete ===\n")
cat("Font sizes should range from 1em (for 0 proportions) to 1.5em (for 1.0 or 100%)\n")
cat("Larger variance proportions should appear in larger font sizes\n")
