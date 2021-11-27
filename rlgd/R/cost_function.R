#' Cost function
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' cost_function(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
cost_function <- function(x, y, theta) {
  m <- nrow(y)
  g <- probability(x, theta)
  j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))
  return(j)
}