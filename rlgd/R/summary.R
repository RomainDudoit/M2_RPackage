#' Overload of summary function for object of class Reg.Log
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
  cat("Mode:", object$mode, "\n")
  cat("Coefficient:", "\n")
  print(rownames(object$theta))
  print(object$theta)
  cat("Cost history:", object$cost_history)
}
