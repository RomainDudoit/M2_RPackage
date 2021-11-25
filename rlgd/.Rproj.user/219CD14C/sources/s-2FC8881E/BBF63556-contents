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
#' gradient(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
gradient <- function(x,y, theta) {
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) # nolint
}
