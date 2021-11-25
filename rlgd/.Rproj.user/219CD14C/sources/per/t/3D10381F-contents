#' Parallelisation function
#'
#' @param x a matrix
#' @param y a matrix
#' @param ncores a numeric
#' @param fonction a function
#' @param theta a matrix
#'
#' @return the result return by the function used in the parallelisation
#' @export
#' @import parallel
#'
#' @examples
#' parallelisation(x,y,ncores = 3,gradient_parallele, as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))
parallelisation <- function(x, y, ncores, fonction, theta){
  #Création des blocs
  m <- nrow(y)
  blocs_size <- trunc((m / ncores))
  blocs <- list()
  index <- append(round(seq(1, m, by = m/ncores)),m)
  for (j in 1:(length(index)-1)) {
    if (j==length(index)-1) reglage_borne <- 0 else reglage_borne <- 1
    y_i <- as.matrix(y[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    x_i <- as.matrix(x[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    blocs[[j]] <- list(x_i, y_i)
  }

  #Parallel
  clust <- parallel::makeCluster(ncores)
  clusterExport(clust, c("x_dot_theta" ,"sigmoid" ,"probability" , "cost_function", "get_x_y"), # nolint
                envir=environment())

  res <- parallel::parSapply(clust, X = blocs, FUN = fonction, theta = theta) # nolint
  parallel::stopCluster(clust)
  return(t(t(rowSums(res))))
}
