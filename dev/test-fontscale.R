library(VisCollin)
library(tinytable)

# Test the new font.scale parameter
data(cars, package = "VisCollin")

cars.mod <- lm(mpg ~ cylinder + engine + horse + weight + accel + year,
               data = cars)
cd <- colldiag(cars.mod, center=TRUE)

# Test 1: Default (font.scale = 1, no scaling)
cat("Test 1: Default (font.scale = 1)\n")
cat("All variance proportions should be displayed at 1em\n\n")
tt(cd)

# Test 2: With scaling c(1, 1.5)
cat("\nTest 2: font.scale = c(1, 1.5)\n")
cat("Variance proportions should scale from 1em (0) to 1.5em (1.0)\n\n")
tt(cd, font.scale = c(1, 1.5))

# Test 3: Different scaling range c(0.8, 1.2)
cat("\nTest 3: font.scale = c(0.8, 1.2)\n")
cat("Variance proportions should scale from 0.8em (0) to 1.2em (1.0)\n\n")
tt(cd, font.scale = c(0.8, 1.2))

# Test 4: Constant size at 1.2em
cat("\nTest 4: font.scale = 1.2\n")
cat("All variance proportions should be displayed at 1.2em\n\n")
tt(cd, font.scale = 1.2)

# Test 5: With percent = TRUE
cat("\nTest 5: font.scale = c(1, 1.5) with percent = TRUE\n")
cat("Should work the same with percentages (0-100)\n\n")
tt(cd, percent = TRUE, font.scale = c(1, 1.5))

# Test 6: With descending and fuzz
cat("\nTest 6: font.scale = c(1, 1.5) with descending and fuzz\n")
cat("NA values (from fuzz) should use minimum font size (1em)\n\n")
tt(cd, descending = TRUE, fuzz = 0.3, font.scale = c(1, 1.5))

cat("\n=== All tests complete ===\n")
