#' Probability function of logistic regression
#'
#' Function used to compute the probability that observations are in a specified category of a binary variable.
#' @param x matrix of dimension m x n
#' @param theta matrix of dimension n x 1 of parameters
#'
#' @return matrix of dimension m x 1 equal to (1 / (1 + exp(-x%*%theta)))
#' @export
#'
#' @seealso
#' \itemize{
#'   \item \code{\link{sigmoid}}
#'   \item \code{\link{x_dot_theta}}
#' }
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' probability(x,theta)
probability <- function(x, theta) {
  return(sigmoid(x_dot_theta(x, theta)))
}
