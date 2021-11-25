#' Gradient Descent Function - Stochastic
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param max_iter a integer
#' @param tol a numeric
#'
#' @return a list containing 2 matrices : matrix of theta and matrix of cost history
#' @export
#'
#' @examples
#' stochastic_gradient_descent(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)),0.01,100,1e-4)
stochastic_gradient_descent <- function(x, y, theta, learning_rate, max_iter, tol) {

  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE
  theta_list <- c()

  while ((iter < max_iter) && (converge == FALSE)) {
    iter <- iter + 1
    random_index <- sample(x = m, size = m)

    for (j in 1:m) {
      # Update theta
      y_i <- as.matrix(y[random_index[j], ])
      x_i <- t(as.matrix(x[random_index[j], ]))
      theta <- theta - learning_rate * gradient(x_i, y_i, theta)
    }
    cost_history <- c(cost_history, cost_function(x_i, y_i, theta))

    theta_list <- append(theta_list, theta)

    if (sum(abs(theta_list[length(theta_list)] - theta_list[length(theta_list)-1])) < tol) {
      converge <- TRUE
    }
  }
  return(list(theta = theta, cost_history = cost_history))
}
