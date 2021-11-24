#' Gradient Descent Function - Batch
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param n_iter a integer
#'
#' @return
#' @export
#'
#' @examples
#' batch_gradient_descent(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100)
batch_gradient_descent <- function(x, y, theta, learning_rate, n_iter) {
  cost_history <- c(cost_function(x, y, theta)) # nolint
  m <- nrow(y)
  for (i in 1:n_iter) {
    # Shuffle data
    random_index <- sample(x = m, size = m)
    # Update theta
    theta <- theta - learning_rate * gradient(x[random_index, ], as.matrix(y[random_index, ]), theta) # nolint
    cost_history <- c(cost_history, cost_function(x, y, theta)) # nolint
  }
  return(list(theta = theta, cost_history = cost_history))
}
