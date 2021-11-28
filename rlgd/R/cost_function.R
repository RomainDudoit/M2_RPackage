#' Cost function of logistic regression
#'
#' @param x matrix of features of dimension m x n
#' @param y matrix of target variable of dimension m x 1
#' @param theta matrix of parameters of dimension n x 1
#'
#'
#' @return numeric equal to (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g))) where m is the number of observations and g the probabilty fonction of logistic regression
#' @export
#'
#' @seealso \code{\link{probability}}
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' cost_function(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
cost_function <- function(x, y, theta) {
  m <- nrow(y)
  g <- probability(x, theta)
  j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))
  return(j)
}
