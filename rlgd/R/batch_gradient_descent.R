#' Gradient Descent Function - Batch
#'
#' @param X a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param n_iter a integer
#'
#' @return list of matrix
#' @export
#'
#' @examples
#' batch_gradient_descent(blocs,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100)
batch_gradient_descent <- function(X, theta, learning_rate, n_iter) {

  x <- X[[1]]
  y <- X[[2]]

  cost_history <- c(cost_function(x, y, theta))
  m <- nrow(y)

  for (i in 1:n_iter) {
    # Shuffle data
    random_index <- sample(x = m, size = m)
    # Update theta
    theta <- theta - learning_rate * gradient(x[random_index, ], as.matrix(y[random_index, ]), theta)
    cost_history <- c(cost_history, cost_function(x, y, theta))
  }
  return(list(theta = theta, cost_history = cost_history))
}