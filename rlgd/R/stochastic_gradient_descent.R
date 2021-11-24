#' Gradient Descent Function - Stochastic
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
#' stochastic_gradient_descent(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100)
stochastic_gradient_descent <- function(x, y, theta, learning_rate, n_iter) {
  cost_history <- c(cost_function(x, y, theta)) # nolint
  m <- nrow(y)
  random_index <- sample(x = m, size = m)
  for (i in 1:n_iter) {
    # Shuffle data
    random_index <- sample(x = m, size = m)
    for (j in 1:m) {
      # Update theta
      y_i <- as.matrix(y[random_index[j], ])
      x_i <- t(as.matrix(x[random_index[j], ]))
      theta <- theta - learning_rate * gradient(x_i, y_i, theta) # nolint
      cost_history <- c(cost_history, cost_function(x, y, theta)) # nolint
    }
  }
  return(list(theta = theta, cost_history = cost_history))
}
