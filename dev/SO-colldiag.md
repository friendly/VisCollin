# how to code a matrix with discrete colors

I have an application where I calculate a matrix of values in [0-1] and want to code these with background
colors `col` according to a set of discrete breaks

```
col = c("white", "pink", "red")   
breaks = c(0, 0.5, 0.9)

res <- matrix(runif(n = 25, min = .2), 5, 5)

bg <- matrix(NA, ncol = ncol(res), nrow = nrow(res))
bg[res > .5] <- "pink"
bg[res > .9] <- "red"

bg

bg <- matrix(NA, ncol = ncol(res), nrow = nrow(res))
for (i in 2:length(breaks)) {
  bg[res >= breaks[i]] <- col[i]
}
bg

fc <- colorRampPalette(c("white", "red"))
plot(rep(1, 10),col = fc(10), pch = 19, cex = 3)

fc(5)

plot(rep(1, 5),col = fc(5), pch = 19, cex = 3)

