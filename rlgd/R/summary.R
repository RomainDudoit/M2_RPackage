#' Overload of print function for object of class Reg.log
#'
#' @param object of S3 class Reg.log
#' @param ... other parameters
#' @return to do
#' @export
#'
#' @examples
#' res <- rlgd.fit(classe ~ .,breast_cancer,"batch",batch_size = 32,
#' learning_rate = 0.5, max_iter = 100, tol = 1e-4, ncores = 1, standardize = FALSE)
#' summary(res)
summary.Reg.Log <- function(object, ...) {
  cat("Formula:", as.character(object$formula), "\n")
  cat("Target:", object$y_name, "\n")
  cat("Features:", object$x_names, "\n")
  cat("Mode:", object$mode, "\n")
  cat("Learning rate:", object$learning_rate, "\n")
  cat("Max_iter:", object$max_iter, "\n")
  cat("Batch size:", object$batch_size, "\n")
  cat("Coefficient:", "\n")
  print(rownames(object$theta))
  print(object$theta)
  cat("Cost history:", object$cost_history)
}
