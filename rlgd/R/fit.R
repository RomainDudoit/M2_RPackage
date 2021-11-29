#' Fit Binary Logistic Regression using gradient descent
#'
#' This function perform binary logistic regression using gradient descent optimization (batch, online or mini-batch). It can use
#' parallel computing only for batch mode.
#'
#' @details Control of the data and preprocessing is done with get_x_y_function. After random initialization of the parameters in theta,
#' and according to the chosen mode, one among three functions of gradient optimization is called : batch_gradient_descent for "batch" mode,
#' stochastic_gradient_descent for "online" mode or mini_batch_gradient_descent for "mini-batch" mode.It returns an instance on the class Reg.log with
#'
#'
#' @param formula object of class formula
#' @param data a data frame
#' @param mode the gradient descent method used to fit the model : "batch", "online" or "mini-batch"
#' @param batch_size a integer used to fix the batch size of mini-batch gradient descent.
#' @param learning_rate a float. Learning rate of the gradient descent.
#' @param max_iter an integer. Number of maximum number of iteration/epoch of the gradient descent
#' @param tol a numeric. Set to 1e-4 by default. Threshold to stop iteration.
#' @param ncores only used for batch mode. an integer corresponding to the number of cores used during parallelisation process
#' @param standardize logical. FALSE by default, set to TRUE to apply standardization.
#'
#' @return an instance of the class Reg.log with the following attributes :
#'
#' @importFrom stats rnorm
#' @export
#' @seealso
#' \itemize{
#'   \item \code{\link{get_x_y}}
#'   \item \code{\link{batch_gradient_descent}}
#'   \item \code{\link{stochastic_gradient_descent}}
#'   \item \code{\link{mini_batch_gradient_descent}}
#' }
#'
#' @examples
#' rlgd.fit(classe ~ .,breast_cancer,"batch",batch_size = 32,
#' learning_rate = 0.5, max_iter = 100, tol = 1e-4, ncores = 2, standardize = TRUE)
rlgd.fit <- function(formula, data, mode, batch_size=16, learning_rate = 0.1,
                     max_iter = 100, tol = 1e-4,ncores=1, standardize = FALSE) {

  x_y <- get_x_y(formula, data, standardize)
  x <- x_y$features
  y <- x_y$target
  y_name <- x_y$y_name
  x_names <- x_y$x_names


  initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))


  if (mode == "batch" || (mode == "mini-batch" && batch_size >= nrow(y))) {

    gradient_descent <- batch_gradient_descent(x, y, initial_theta, learning_rate, max_iter, tol, ncores)

  } else if (mode == "online" || (mode == "mini-batch" && batch_size == 1)) {

    gradient_descent <- stochastic_gradient_descent(x, y, initial_theta, learning_rate, max_iter, tol)

  } else if (mode == "mini-batch") {

    gradient_descent <- mini_batch_gradient_descent(x, y, initial_theta, learning_rate, max_iter, batch_size, tol)

  } else {

    stop("Invalid mode, please select 'batch', 'online' or 'mini-batch'")

  }

  # Creation of the instance
  inst <- list(formula = formula, x = x, y = y, y_name = y_name, x_names = x_names, preprocess = x_y$preprocess, xlevs = x_y$xlevs,
               mode = mode, batch_size = batch_size, learning_rate = learning_rate, max_iter = max_iter,
               initial_theta = initial_theta, theta = gradient_descent[[1]], cost_history = gradient_descent[[2]],
               standardize = standardize)

  attr(inst, "class") <- "Reg.Log"
  return(inst)
}
