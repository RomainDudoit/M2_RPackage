#' gradient parallele
#'
#' @param X matrix
#' @param theta matrix
#'
#' @return gradient
#' @export
#'
gradient_parallele <- function(X, theta) {
  x <- X[[1]]
  y <- X[[2]]
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y))
}
