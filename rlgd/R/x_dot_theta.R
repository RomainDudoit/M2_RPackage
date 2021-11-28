#' Matrix multiplication function
#'
#' Function used to perform matrix multiplication of X.theta
#' @param x matrix of dim (m,n+1) where n is the number of features
#' @param theta matrix of dim (n+1,1) of parameters
#'
#' @return matrix of dim (n+1,1) i.e the model of logistic regression
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
