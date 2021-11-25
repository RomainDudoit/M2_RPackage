#' get_x_y function
#'
#' @param formula a formula
#' @param data a matrix
#'
#' @return x,y (2 matrix) and y_name, x_names (2 lists)
#' @export
#' @import formula.tools
#'
#' @examples
#'get_x_y(classe ~ ., data)
get_x_y <- function(formula, data) {
  data_frame <- model.frame(formula, data)
  vars = formula.tools::get.vars(formula, data)
  y_name = vars[1]
  x_names = vars[-1]
  y <- as.matrix(data_frame[, y_name])
  x <- data_frame[, x_names]
  x <- as.matrix(data.frame(rep(1, length(y)), x))
  return(list(target = y, features = x, y_name = y_name, x_names = x_names))
}
