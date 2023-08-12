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






