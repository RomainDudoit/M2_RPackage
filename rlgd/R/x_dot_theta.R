#' Matrix multiplication function
#'
#' Function used to perform matrix multiplication of X.theta
#' @param x matrix of features of dimension m x n
#' @param theta matrix of parameters of dimension n x 1
#'
#' @return matrix of dimension n x 1 i.e the model of logistic regression
#' @export
#'
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' x_dot_theta(x,theta)
x_dot_theta <- function(x, theta) {
  return(x %*% theta)
}
