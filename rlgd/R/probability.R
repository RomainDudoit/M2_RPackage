#' Probability function for logistic regression
#'
#' Function used to compute the probability that observations are in a specified category of a binary variable.
#' @param x matrix of dim (m,n+1) where n is the number of features
#' @param theta matrix of dim (n+1,1) of parameters
#'
#' @return 1 / (1 + exp(-x%*%theta))
#' @export
#'
#' @seealso \code{\link{sigmoid}} \code{\link{x_dot_theta}}
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' probability(x,theta)
probability <- function(x, theta) {
  return(sigmoid(x_dot_theta(x, theta)))
}
