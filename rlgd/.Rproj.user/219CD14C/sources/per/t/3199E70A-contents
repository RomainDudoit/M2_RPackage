#' Gradient Descent Function - Batch
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param max_iter a integer
#' @param tol a numeric
#' @param ncores a integer
#'
#' @return a list containing 2 matrices : matrix of theta and matrix of cost history
#' @export
#'
#' @examples
#' batch_gradient_descent(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100,1e-4,ncores=3)
batch_gradient_descent <- function(x, y, theta, learning_rate, max_iter, tol,ncores) {

  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE

  while ((iter < max_iter) && (converge == FALSE)) {
    iter <- iter + 1
    random_index <- sample(x = m, size = m)
    new_theta <- theta - learning_rate * parallelisation(x[random_index, ],as.matrix(y[random_index, ]), ncores, gradient_parallele, theta = theta)
    cost_history <- c(cost_history, cost_function(x[random_index, ], as.matrix(y[random_index, ]), new_theta))


    if (sum(abs(new_theta - theta)) < tol) {
      converge <- TRUE
    }

    theta <- new_theta
  }
  return(list(theta = theta, cost_history = cost_history))
}
