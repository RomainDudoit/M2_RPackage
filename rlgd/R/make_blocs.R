#' Creation of blocs for parallelisation
#'
#' @param x matrix
#' @param y matrix
#' @param ncores integer
#'
#' @return blocs
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' make_blocs(x,y,ncores=3)
make_blocs <- function(x, y, ncores){
  m <- nrow(y)
  blocs_size <- trunc((m / ncores))
  blocs <- list()
  index <- append(round(seq(1, m, by = m/ncores)),m)
  for (j in 1:(length(index)-1)) {
    if (j==length(index)-1) {
      reglage_borne <- 0
    }else {
      reglage_borne <- 1
    }
    y_i <- as.matrix(y[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    x_i <- as.matrix(x[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    blocs[[j]] <- list(x_i, y_i)
  }
  return(blocs)
}
