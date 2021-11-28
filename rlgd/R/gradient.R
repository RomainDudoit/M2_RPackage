#' Gradient of the cost function of logistic regression
#'
#' @param x matrix of features of dimension m x n
#' @param y matrix of target of dimension m x 1
#' @param theta matrix of parameters of dimension n x 1
#'
#' @return matrix of dimension n x 1 of partial derivatives of each parameter
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' gradient(x,y,theta)
gradient <- function(x,y, theta) {
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y))
}
