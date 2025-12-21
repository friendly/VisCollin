## Feature Request: Render styled HTML tables in pkgdown examples

### Description

When using `tinytable` in function examples that are rendered by `pkgdown::build_site()`, the tables appear as plain text/markdown tables rather than styled HTML tables with colors and backgrounds. This makes it difficult to showcase the visual styling capabilities of tinytable in package documentation.

### Current Behavior

In my package [VisCollin](https://github.com/friendly/VisCollin), I have a function `tt.colldiag()` that creates styled tables with background colors and variable font sizes:

https://github.com/friendly/VisCollin/blob/master/R/tt.colldiag.R

When I run `pkgdown::build_site()`, the examples execute but the output appears as plain text tables instead of rendered HTML with the styling preserved.

### What I've Tried

1. **Setting output option conditionally:**

   ```r
   if (knitr::is_html_output()) options(tinytable_print_output = "html")
   ```

   Result: No effect in pkgdown examples

2. **Explicitly calling print with output parameter:**

   ```r
   tt(cd) |> print(output = "html")
   ```

   Result: Error: `x` must be a data.frame`

3. **Checking tinytable's own pkgdown site:**
   Even the [tinytable documentation](https://vincentarelbundock.github.io/tinytable/man/style_tt.html) examples section appears to show only code, not rendered styled tables

### Expected Behavior

When pkgdown renders the examples, I would expect the tinytable output to appear as styled HTML tables with:
- Background colors
- Font size variations
- All other visual styling applied via `style_tt()`

This is similar to how htmlwidgets are handled in pkgdown examples.

### Potential Solutions

Based on research into pkgdown's rendering pipeline, potential solutions could include:

1. **Implement a `pkgdown_print.tinytable` method:**
   pkgdown provides a special `pkgdown_print()` generic that package authors can implement to control how objects render in pkgdown examples. See: https://pkgdown.r-lib.org/reference/pkgdown_print.html

   This method could return the HTML representation of the table for pkgdown to embed.

2. **Enhance `knit_print.tinytable` for pkgdown context:**
   Ensure the existing `knit_print.tinytable` method properly detects and handles the pkgdown rendering context.

3. **Documentation guidance:**
   If there's a working approach I've missed, documentation showing how to properly render styled tinytables in pkgdown examples would be helpful.

### Use Case

This is particularly important for packages that use tinytable to create publication-quality tables - users need to see the styled output in the documentation to understand what the functions produce.

### Environment

- tinytable version: (latest from CRAN)
- pkgdown version: (latest)
- R version: 4.1+

Thank you for this excellent package! The tables look beautiful in interactive use and in vignettes - it would be wonderful to showcase them properly in pkgdown examples as well.
