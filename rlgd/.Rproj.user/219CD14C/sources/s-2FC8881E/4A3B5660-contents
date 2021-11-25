#' Probability function
#'
#' @param x a matrix
#' @param theta a matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' probability(x,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
probability <- function(x, theta) {
  return(sigmoid(x_dot_theta(x, theta)))
}
