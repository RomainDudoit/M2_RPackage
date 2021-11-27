#' parallelisation function
#'
#' @param blocs set of data
#' @param fonction function to parallelize
#' @param theta matrix
#' @param clust cluster of blocks
#'
#' @return sum of gradients of each blocs
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' blocs <- make_blocs(x,y,ncores = 3)
parallelisation <- function(blocs, fonction, theta, clust){
  res <- parallel::parSapply(clust, X = blocs, FUN = fonction, theta = theta) # nolint
  return(t(t(rowSums(res))))
}
