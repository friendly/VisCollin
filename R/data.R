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
#' str(cars)
#' #plot(cars) ...
#'
NULL







