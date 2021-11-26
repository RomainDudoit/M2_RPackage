#' get_x_y_function
#'
#' @param formula a formula
#' @param data a matrix
#'
#' @return list(y,x,y_name,x_name), y & x = matrix, y_name & x_names = c()
#' @importFrom caret dummyVars
#' @importFrom formula.tools get.vars
#' @importFrom stats predict
#' @export
#'
#' @examples
#' get_x_y(classe ~., data=breast_cancer)
get_x_y <- function(formula, data) {

  vars <- get.vars(formula, data)
  y_name = vars[1]
  x_names <- vars[-1]


  y <- as.matrix(data[, y_name])

  dmy <- dummyVars(formula, data)
  x <- predict(dmy, data)
  x <- cbind("(Intercept)" = 1, x)

  return(list(target = y, features = x, y_name = y_name, x_names = x_names))
}
