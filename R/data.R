#' @name consumption
#' @docType data
#' @title Consumption Function Dataset
#' @description Example from pp 149-154 of Belsley (1991), Conditioning Diagnostics
#' @format A data frame with 28 observations on the following 5 variables.
#'   \describe{
#'      \item{year}{1947 to 1974}
#'      \item{cons}{total consumption, 1958 dollars}
#'      \item{rate}{the interest rate (Moody's Aaa)}
#'      \item{dpi}{disposable income, 1958 dollars}
#'      \item{d_dpi}{annual change in disposable income}
#'    }
#'
#' @references
#' Belsley, D.A. (1991).
#' \cite{Conditioning diagnostics, collinearity and weak data in regression}.
#' New York: John Wiley & Sons.
#' @keywords dataset
#' @examples
#' data(consumption)
#'
#' ct1 <- with(consumption, c(NA,cons[-length(cons)]))

#' # compare (5.3)
#' m1 <- lm(cons ~ ct1 + dpi + rate + d_dpi, data = consumption)
#' anova(m1)
#'
#' # compare exhibit 5.11
#' with(consumption, cor(cbind(ct1, dpi, rate, d_dpi), use="complete.obs"))

#' # compare exhibit 5.12
#' cd<-colldiag(m1)
#' cd
#' print(cd,fuzz=.3)
#'
#'
NULL


#' @name cars
#' @docType data
#' @title Cars Data
#' @description
#' Data from the 1983 ASA Data Exposition, held in conjunction with the Annual
#' Meetings in Toronto, August 15-18, 1983,
#' \url{https://community.amstat.org/jointscsg-section/dataexpo/dataexpobefore1993}
#' The data set was collected by Ernesto Ramos and David Donoho on characteristics of automobiles.
#' @format   A data frame with 406 observations on the following 10 variables:
#' \describe{
#'   \item{\code{make}}{make of car, a factor with levels \code{amc} \code{audi} \code{bmw} \code{buick} \code{cadillac} \code{chev} \code{chrysler} \code{citroen} \code{datsun} \code{dodge} \code{fiat} \code{ford} \code{hi} \code{honda} \code{mazda} \code{mercedes} \code{mercury} \code{nissan} \code{oldsmobile} \code{opel} \code{peugeot} \code{plymouth} \code{pontiac} \code{renault} \code{saab} \code{subaru} \code{toyota} \code{triumph} \code{volvo} \code{vw}}
#'   \item{\code{model}}{model of car, a character vector}
#'   \item{\code{mpg}}{miles per gallon, a numeric vector}
#'   \item{\code{cylinder}}{number of cylinders, a numeric vector}
#'   \item{\code{engine}}{engine displacement (cu. inches), a numeric vector}
#'   \item{\code{horse}}{horsepower, a numeric vector}
#'   \item{\code{weight}}{vehicle weight (lbs.), a numeric vector}
#'   \item{\code{accel}}{time to accelerate from O to 60 mph (sec.), a numeric vector}
#'   \item{\code{year}}{model year (modulo 100), a numeric vector ranging from 70 -- 82}
#'   \item{\code{origin}}{region of origin, a factor with levels \code{Amer} \code{Eur} \code{Japan}}
#' }
#' @source
#' The data was provided for the ASA Data Exposition
#' in a "shar" file, \url{http://lib.stat.cmu.edu/datasets/cars.data}.
#' It is a version of that used by Donoho and Ramos (1982) to illustrate PRIM-H.
#' @references
#' Donoho, David and Ramos, Ernesto (1982), ``PRIMDATA: Data Sets for Use With PRIM-H'' (Draft).
#' @keywords dataset
#' @examples
#' data(cars)
#' cars.mod <- lm (mpg ~ cylinder + engine + horse + weight + accel + year,
#'                 data=cars)
#' car::vif(cars.mod)
#'
#' (cd <- colldiag(cars.mod, center=TRUE))
#'
#' # simplified display
#' print(cd, fuzz=.3)
NULL

#' @name biomass
#' @docType data
#' @title Biomass Production in the Cape Fear Estuary
#' @description
#' Data collected by Rick Linthurst (1979) at North Carolina State University for the
#' purpose of identifying the important soil characteristics influencing aerial
#' biomass production of the marsh grass \emph{Spartina alterniflora} in the
#' Cape Fear Estuary of North Carolina. Three types of Spartina vegetation areas
#' (devegetated “dead” areas, “short” Spartina areas, and “tall” Spartina areas)
#' were sampled in each of three locations (Oak Island, Smith Island, and Snows
#' Marsh)
#'
#' Samples of the soil substrate from 5 random sites within
#' each location–vegetation type (giving 45 total samples) were analyzed for
#' 14 soil physico-chemical characteristics each month for several months.
#'
#' @format   A data frame with 45 observations on the following 17 variables.
#' \describe{
#'  \item{\code{loc}}{location, a factor with levels \code{OI} \code{SI} \code{SM}}
#'   \item{\code{type}}{area type, a factor with levels \code{DVEG} \code{SHRT} \code{TALL}}
#'   \item{\code{biomass}}{aerial biomass in \eqn{gm^{-2}}, a numeric vector}
#'   \item{\code{H2S}}{hydrogen sulfide ppm, a numeric vector}
#'   \item{\code{sal}}{percent salinity, a numeric vector}
#'   \item{\code{Eh7}}{ester-hydrolase, a numeric vector}
#'   \item{\code{pH}}{acidity as measured in water, a numeric vector}
#'   \item{\code{buf}}{a numeric vector}
#'   \item{\code{P}}{phosphorus ppm, a numeric vector}
#'   \item{\code{K}}{potassium ppm, a numeric vector}
#'   \item{\code{Ca}}{calcium ppm, a numeric vector}
#'   \item{\code{Mg}}{magnesium ppm, a numeric vector}
#'   \item{\code{Na}}{sodium ppm, a numeric vector}
#'   \item{\code{Mn}}{manganese ppm, a numeric vector}
#'   \item{\code{Zn}}{zinc ppm, a numeric vector}
#'   \item{\code{Cu}}{copper ppm, a numeric vector}
#'   \item{\code{NH4}}{ammonium ion ppm, a numeric vector}
#' }
#' @source
#' Rawlings, J. O., Pantula, S. G., & Dickey, D. A. (2001).
#' \emph{Applied Regression Analysis: A Research Tool}, 2nd Ed., Springer New York.
#' Table 5.1.
#' @references
#' R. A. Linthurst. Aeration, nitrogen, pH and salinity as factors affecting \emph{Spartina Alterniflora} growth and dieback.
#' PhD thesis, North Carolina State University, 1979.
#' @keywords dataset
#' @examples
#' data(biomass)
#' str(biomass)
#' biomass.mod <- lm (biomass ~ H2S + sal + Eh7 + pH + buf + P + K + Ca + Mg + Na +
#'                            Mn + Zn + Cu + NH4,
#'                  data=biomass)
#' car::vif(biomass.mod)
#'
#' (cd <- colldiag(biomass.mod, add.intercept=FALSE, center=TRUE))
#' # simplified display
#' print(cd, fuzz=.3)


NULL





