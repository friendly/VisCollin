## Feature Request: Ability to specify font family for table cells

### Description

I'm using `tinytable` to create styled tables for collinearity diagnostics in my R package [VisCollin](https://github.com/friendly/VisCollin), and I'd like to be able to specify the font family for the table content. Specifically, I'd prefer to use a sans-serif font for tables rather than the default serif font, as sans-serif fonts are generally more readable in tabular displays.

### Current Implementation

My current implementation uses `style_tt()` to customize colors, font sizes, and alignment:

https://github.com/friendly/VisCollin/blob/master/R/tt.colldiag.R

The function successfully applies:
- Background colors based on variance proportions and condition indices
- Variable font sizes (using the `fontsize` parameter in `style_tt()`)
- Custom alignment

However, I cannot find a way to specify font family.

### What I've Tried

I've searched the documentation and found:
- `style_tt()` has parameters for `fontsize`, `bold`, `italic`, `monospace`, etc., but no `fontfamily` parameter
- There are mentions of `bootstrap_css` and `bootstrap_css_rule` for HTML output, but I couldn't find clear examples of how to use these for font family
- The `html_css` parameter (mentioned in the source code) might work, but it's not documented

### Desired Functionality

It would be helpful to have one of the following:

1. **A `fontfamily` parameter in `style_tt()`** (similar to `fontsize`):

```r
style_tt(i = 1:n, j = 2:m, fontfamily = "sans-serif")
```

2. **Clear documentation/examples** for using `bootstrap_css` or `html_css` to set font family for HTML output

3. **Format-specific options** (similar to how you have format-specific themes):

```r
theme_html(x, fontfamily = "Arial, sans-serif")
```

### Use Case

For my use case, I'd like to apply a sans-serif font to all cells in the table (both headers and body) to improve readability. Ideally, this would work across output formats (HTML, LaTeX, etc.), but even HTML-specific support would be valuable.

### Example

Here's a simplified example of what I'm trying to achieve:

```r
library(tinytable)
dat <- data.frame(x = 1:3, y = 4:6)
tt(dat) |>
  style_tt(fontfamily = "Arial, sans-serif")  # desired functionality
```

Thank you for the excellent package! Any guidance on how to achieve this with the current functionality, or consideration of adding this feature, would be greatly appreciated.
