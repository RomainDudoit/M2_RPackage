#' Cost_plot function
#'
#' Display a graphic of the cost for each iteration of the selected method of gradient.
#'
#' @param Reg.Log object of the S3 class Reg.log provide by the rlgd.fit function
#'
#' @return a graphic of the cost for each iteration of the selected method of gradient
#' @export
#'
#' @examples
#' library(caret)
#' train_index <- createDataPartition(breast_cancer$classe, p = 0.7, list = FALSE)
#' train_set <- breast_cancer[train_index, ]
#' res <- rlgd.fit(classe ~ ., train_set, mode = "batch", learning_rate = 0.01,
#' max_iter = 200, tol = 1e-4, ncores=1)
#' cost_plot(res)
cost_plot <- function(Reg.Log){
  return(plot(seq(1, length(Reg.Log$cost_history)), Reg.Log$cost_history, type = "l",
              xlab="Number of iterations", ylab="Cost history"))  #plot the cost for each iteration
}


