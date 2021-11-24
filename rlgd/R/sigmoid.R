#' Sigmoid function
#'
#' @param x a matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' sigmoid(x)
sigmoid <- function(x) {
  return(1 / (1 + exp(-x)))
}
