#' Batch Gradient Descent Algorithm
#'
#' Perform Batch mode of Gradient Descent
#' @param x matrix of features of dimension m x n
#' @param y matrix of target of dimension m x 1
#' @param theta matrix of parameters of dimension n x 1
#' @param learning_rate a numeric. Learning rate of the gradient descent. Set to 0.1 by default in rlgd.fit function.
#' @param max_iter an integer. Number of maximum number of iteration/epoch of the gradient descent. Set to 100 by default in rlgd.fit function.
#' @param tol a numeric. Threshold to stop iteration loop. Set to 1e-4 by default in rlgd.fit function.
#' @param ncores an integer. corresponding to the number of cores used during parallelisation process. Set to 1 by default in rlgd.fit function.
#'
#' @return a list containing 2 matrix :
#' \itemize{
#'   \item theta : final parameters of binary logistic regression
#'   \item cost history : history of cost function
#' }
#' @importFrom parallel clusterExport makeCluster stopCluster
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
#' ncores <- 2
#' batch_gradient_descent(x, y, theta, learning_rate = 0.01, max_iter = 100, tol = 1e-4, ncores)
batch_gradient_descent <- function(x, y, theta, learning_rate, max_iter, tol, ncores) {

  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE

  if (ncores !=1){

    blocs <- make_blocs(x,y,ncores)
    clust <- makeCluster(ncores)
    clusterExport(clust, c("x_dot_theta" ,"sigmoid" ,"probability" , "cost_function", "get_x_y"),
                  envir=environment())

    while ((iter < max_iter) && (converge == FALSE)) {
      iter <- iter + 1
      random_index <- sample(x = m, size = m)
      #pas de mélange des données !!
      new_theta <- theta - learning_rate * parallelisation(blocs ,gradient_parallele,theta = theta,clust)
      cost_history <- c(cost_history, cost_function(x[random_index, ], as.matrix(y[random_index, ]), new_theta))

      if (sum(abs(new_theta - theta)) < tol) {
        converge <- TRUE
      }
      theta <- new_theta
    }
    stopCluster(clust)

  }else{
    while ((iter < max_iter) && (converge == FALSE)) {
      iter <- iter + 1
      random_index <- sample(x = m, size = m)
      new_theta <- theta - learning_rate * gradient(x[random_index, ], as.matrix(y[random_index, ]), theta)
      cost_history <- c(cost_history, cost_function(x[random_index, ], as.matrix(y[random_index, ]), new_theta))


      if (sum(abs(new_theta - theta)) < tol) {
        converge <- TRUE
      }

      theta <- new_theta
    }
  }

  return(list(theta = theta, cost_history = cost_history))
}
