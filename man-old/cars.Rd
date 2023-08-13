\name{cars}
\alias{cars}
\docType{data}
\title{
Cars Dataset
}
\description{
Data from the 1983 ASA Data Exposition, held in conjunction with the Annual
Meetings in Toronto, August 15-18, 1983,
\url{https://community.amstat.org/jointscsg-section/dataexpo/dataexpobefore1993}
The data set was collected by Ernesto Ramos and David Donoho on characteristics of automobiles.
}
\usage{data("cars")}
\format{
  A data frame with 406 observations on the following 10 variables.
  \describe{
    \item{\code{make}}{make of car, a factor with levels \code{amc} \code{audi} \code{bmw} \code{buick} \code{cadillac} \code{chev} \code{chrysler} \code{citroen} \code{datsun} \code{dodge} \code{fiat} \code{ford} \code{hi} \code{honda} \code{mazda} \code{mercedes} \code{mercury} \code{nissan} \code{oldsmobile} \code{opel} \code{peugeot} \code{plymouth} \code{pontiac} \code{renault} \code{saab} \code{subaru} \code{toyota} \code{triumph} \code{volvo} \code{vw}}
    \item{\code{model}}{model of car, a character vector}
    \item{\code{mpg}}{miles per gallon, a numeric vector}
    \item{\code{cylinder}}{number of cylinders, a numeric vector}
    \item{\code{engine}}{engine displacement (cu. inches), a numeric vector}
    \item{\code{horse}}{horsepower, a numeric vector}
    \item{\code{weight}}{vehicle weight (lbs.), a numeric vector}
    \item{\code{accel}}{time to accelerate from O to 60 mph (sec.), a numeric vector}
    \item{\code{year}}{model year (modulo 100), a numeric vector ranging from 70 -- 82}
    \item{\code{origin}}{region of origin, a factor with levels \code{Amer} \code{Eur} \code{Japan}}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
The data was provided for the ASA Data Exposition
in a "shar" file, \url{http://lib.stat.cmu.edu/datasets/cars.data}.
It is a version of that used by Donoho and Ramos (1982) to illustrate PRIM-H.
}
\references{
Donoho, David and Ramos, Ernesto (1982), ``PRIMDATA: Data Sets for Use With PRIM-H'' (Draft).
}
\examples{
data(cars)
maybe str(cars)
#plot(cars) ...
}
\keyword{datasets}
