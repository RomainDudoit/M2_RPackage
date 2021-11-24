#' Gradient Descent Function - Mini-Batch
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param n_iter a integer
#' @param batch_size a integer
#'
#' @return
#' @export
#'
#' @examples
#' mini_batch_gradient_descent(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100,32)
mini_batch_gradient_descent <- function(x, y, theta, learning_rate, n_iter, batch_size) {
  cost_history <- c(cost_function(x, y, theta))
  m <- nrow(y)

  for (i in 1:n_iter) {
    # Shuffle data
    random_index <- sample(x = m, size = m)
    x <- as.matrix(x[random_index, ])
    y <- as.matrix(y[random_index, ])
    x_i <- c()
    y_i <- c()

    index <- seq(1, m, batch_size - 1)

    for (j in 1:trunc(m / batch_size)) {
      y_i <- as.matrix(y[index[[j]]:index[[j + 1]], ])
      x_i <- as.matrix(x[index[[j]]:index[[j + 1]], ])
      theta <- theta - learning_rate * gradient(x_i, y_i, theta)
      cost_history <- c(cost_history, cost_function(x, y, theta))
    }
  }
  return(list(theta = theta, cost_history = cost_history))
}
