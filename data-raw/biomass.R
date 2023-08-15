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
  matrix(scan(here::here("data-raw", "biomass.dat"),
              what=""),
         ncol=17, byrow=TRUE)
biomass <- data.frame(mat[-1,], stringsAsFactors=TRUE)

biomass[] <- lapply(biomass, type.convert)
names(biomass) <- mat[1,]
colnames(biomass)[3] <- "biomass"

library(dplyr)
biomass <- biomass |>
  mutate(loc = factor(loc),
         type = factor(type))

str(biomass)

save(biomass, file=here::here("data", "biomass.RData"))

prompt(biomass, filename = here::here("man-old", "biomass.Rd"))

