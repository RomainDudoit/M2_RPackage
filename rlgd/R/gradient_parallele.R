#' Gradient parallele
#'
#' This function is a simple copy of the gradient function but with the X parameters that replace x and y.
#'
#' @details It was done like that because the parSapply used in the parallelisation function require in the input the list of the blocs used to parallelize the function. Because of that, we had to merge x and y in one block.
#'
#' @param X  list of several blocks (one for each used heart) containing parts of x and y
#' @param theta matrix of parameters
#'
#' @return the calculated gradient
#' @export
gradient_parallele <- function(X, theta) {
  x <- X[[1]] # retrieve x in the first position of the bloc
  y <- X[[2]] # retrieve y in the second position of the bloc
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) #calcul the gradient
}
