#' Gradient Descent Function - Mini-Batch
#'
#' @param x a matrix
#' @param y a matrix
#' @param theta a matrix
#' @param learning_rate a float
#' @param batch_size a integer
#' @param max_iter a integer
#' @param tol a numeric
#'
#' @return a list containing 2 matrices : matrix of theta and matrix of cost history
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:20,1:4])
#' y <- breast_cancer[1:20,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' mini_batch_gradient_descent(x,y,theta,learning_rate = 0.01, max_iter = 100,
#' batch_size = 16, tol = 1e-4)
mini_batch_gradient_descent <- function(x, y, theta, learning_rate, max_iter,
                                        batch_size, tol) {

  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE
  theta_list <- c()

  while ((iter < max_iter) && (converge == FALSE)) {
    # Shuffle data
    iter <- iter + 1
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
    }
    cost_history <- c(cost_history, cost_function(x_i, y_i, theta))

    theta_list <- append(theta_list, theta)

    if (sum(abs(theta_list[length(theta_list)] - theta_list[length(theta_list)-1])) < tol) {
      converge <- TRUE
    }

  }
  return(list(theta = theta, cost_history = cost_history))
}