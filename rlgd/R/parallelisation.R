#' Parallelisation function
#'
#' The aim of parallelization is to speed up the calculation time of an algorithm by making the most of the increased capacity of multicore processors.
#' @details The role of the parSapply function is to execute the selected function on each blocs at the same time (parallelisation).
#'
#' @param blocs list of several blocs (one for each used heart) containing parts of x and y
#' @param fonction function to parallelize, in our case the gradient_parallele function
#' @param theta matrix of parameters
#' @param clust cluster of nodes for parallel computation (one for each used heart)
#'
#' @return sum of gradients applied to each blocs
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' blocs <- make_blocs(x,y,ncores = 3)
parallelisation <- function(blocs, fonction, theta, clust){
  res <- parallel::parSapply(clust, X = blocs, FUN = fonction, theta = theta) #execute the selected function on each input blocs
  return(t(t(rowSums(res))))
}

