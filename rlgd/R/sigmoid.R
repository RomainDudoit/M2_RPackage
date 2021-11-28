#' Sigmoid function
#'
#' This function is used to perform logistic regression.
#'
#' @param x a number
#'
#' @return 1 / (1 + exp(-x))
#' @export
#'
#' @examples
#' sigmoid(2)
sigmoid <- function(x) {
  return(1 / (1 + exp(-x)))
}
