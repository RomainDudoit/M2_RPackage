#' Probability function
#'
#' @param x a matrix
#' @param theta a matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' probability(x,theta)
probability <- function(x, theta) {
  return(sigmoid(x_dot_theta(x, theta)))
}
