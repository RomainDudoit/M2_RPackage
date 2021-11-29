#' Overload of print function for x of class Reg.Log
#'
#' @param x of S3 class Reg.Log
#' @param ... other parameters
#' @return to do
#' @export
#'
#' @examples
#' res <- rlgd.fit(classe ~ .,breast_cancer,"batch",batch_size = 32,
#' learning_rate = 0.5, max_iter = 100, tol = 1e-4, ncores = 1, standardize = FALSE)
#' print(res)
print.Reg.Log <- function(x, ...) {
  cat("Formula:", as.character(x$formula), "\n")
  cat("Target:", x$y_name, "\n")
  cat("Features:", x$x_names, "\n")
  cat("Gradient descente mode:", x$mode, "\n")
  cat("Learning rate:", x$learning_rate, "\n")
  cat("Max_iter:", x$max_iter, "\n")
  cat("Batch size:", x$batch_size, "\n")
  cat("Coefficients:", "\n")
  print(x$theta)
}
