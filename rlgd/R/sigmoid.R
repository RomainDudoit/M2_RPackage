#' Sigmoid function
#'
#' This function is used to perform logistic regression.
#'
#' @param x a numeric or a matrix.
#'
#' @return 1 / (1 + exp(-x)), value or values between 0, 1
#' @export
#'
#' @examples
#' sigmoid(2)
sigmoid <- function(x) {
  return(1 / (1 + exp(-x)))
}
