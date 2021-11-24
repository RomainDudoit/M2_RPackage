#' Gradient function
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' gradient(blocs[[1]],as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
gradient <- function(X, theta) {
  x <- X[[1]]
  y <- X[[2]]
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) # nolint
}
