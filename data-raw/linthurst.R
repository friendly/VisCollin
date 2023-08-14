#' ---
#' title: Linthurst biomass data
#' ---

# Data from: Rawlings et-al. Applied Regression Analysis, 2nd Ed., Table 5.1

# The data considered are part of a larger study conducted by Dr. Rick
# Linthurst (1979) at North Carolina State University as his Ph.D. thesis
# research. The purpose of his research was to identify the important soil
# characteristics influencing aerial biomass production of the marsh grass
# Spartina alterniflora in the Cape Fear Estuary of North Carolina.
# One phase of Linthurst’s research consisted of sampling three types of

# Aerial biomass (BIO) and five physicochemical properties of the sub-
#   strate (salinity (SAL), pH, K, Na, and Zn) in the Cape Fear Estuary of North
# Carolina. (Data used with permission of Dr. R. A. Linthurst.)

# read the data, slightly awkward in R because there are 2 lines/case
mat <-
  matrix(scan(here::here("data-raw", "linthurst.dat"),
              what=""),
         ncol=17, byrow=TRUE)
linthurst <- data.frame(mat[-1,], stringsAsFactors=TRUE)

linthurst[] <- lapply(linthurst, type.convert)
names(linthurst) <- mat[1,]
colnames(linthurst)[3] <- "biomass"

library(dplyr)
linthurst <- linthurst |>
  mutate(loc = factor(loc),
         type = factor(type))

str(linthurst)

save(linthurst, file=here::here("data", "linthurst.RData"))

prompt(linthurst, filename = here::here("man-old", "linthurst.Rd"))

