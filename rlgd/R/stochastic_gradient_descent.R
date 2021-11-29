#' Title
#'
#' @param x matrix of features of dimension m x n
#' @param y matrix of target of dimension m x 1
#' @param theta matrix of parameters of dimension n x 1
#' @param learning_rate a numeric. Learning rate of the gradient descent. Set to 0.1 by default in rlgd.fit function.
#' @param max_iter an integer. Number of maximum number of iteration/epoch of the gradient descent. Set to 100 by default in rlgd.fit function.
#' @param tol a numeric. Threshold to stop iteration loop. Set to 1e-4 by default in rlgd.fit function.
#'
#' @return a list containing 2 matrix :
#' \itemize{
#'   \item theta : final parameters of binary logistic regression
#'   \item cost history : history of cost function
#' }
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' stochastic_gradient_descent(x,y,theta,learning_rate=0.01,max_iter=100,tol=1e-4)
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
