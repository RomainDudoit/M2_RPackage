#' get_x_y function
#'
#' @param formula a formula
#' @param data a matrix
#'
#' @return x,y, 2 matrix
#' @export
#'
#' @examples
#'
#'get_x_y(classe ~ ., data)
get_x_y <- function(formula, data) {
  data_frame <- model.frame(formula, data)
  y <- as.matrix(data_frame[, 1])
  x <- data_frame[, -1]
  x <- as.matrix(data.frame(rep(1, length(y)), x))
  return(list(target = y, features = x))
}
