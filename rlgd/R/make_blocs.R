#' Creation of blocs for parallelisation
#'
#' The goal here is to create an input for the parSapply in the parallelisation function. It requires several blocs to used the parallelisaton on. In our case, each blocs is composed of a part of x and y, the total give the complete x and y
#' @param x matrix of features variable
#' @param y matrix of target variable
#' @param ncores integer that indicate how much hearts to use pr the parallelisation
#'
#' @return blocs, a list of several blocs (one for each used heart) containing parts of x and y
#' @export
#'
#' @examples
#' x <- as.matrix(breast_cancer[1:10,1:4])
#' y <- breast_cancer[1:10,"classe"]
#' y <- as.matrix(ifelse(y$classe =="malignant",1,0))
#' make_blocs(x,y,ncores=3)
make_blocs <- function(x, y, ncores){
  m <- nrow(y)
  blocs_size <- trunc((m / ncores)) #round of the size of each blocs
  blocs <- list()
  index <- append(round(seq(1, m, by = m/ncores)),m) #contains the indexes of the limits of each block according to bloc_size
  for (j in 1:(length(index)-1)) { # run through elements of index
    if (j==length(index)-1) { # add the variable reglage_borne to include or not the index
      reglage_borne <- 0
    }else {
      reglage_borne <- 1
    }
    y_i <- as.matrix(y[index[[j]]:(index[[j + 1]] - reglage_borne), ]) # retrieve block i in y with index
    x_i <- as.matrix(x[index[[j]]:(index[[j + 1]] - reglage_borne), ]) # retrieve block i in x with index
    blocs[[j]] <- list(x_i, y_i) #Add block x_i/ y_i to a list
  }
  return(blocs)
}
