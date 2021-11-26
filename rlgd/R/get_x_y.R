#' get_x_y_function
#'
#' @param formula a formula
#' @param data a matrix
#' @param standardize TRUE or FALSE
#'
#' @return list(y,x,y_name,x_name), y & x = matrix, y_name & x_names = c()
#' @importFrom caret dummyVars preProcess
#' @importFrom formula.tools get.vars
#' @importFrom stats predict
#' @export
#'
#' @examples
#' get_x_y(classe ~., data=breast_cancer, standardize=TRUE)
get_x_y <- function(formula, data, standardize) {

  vars <- get.vars(formula, data)
  y_name = vars[1]
  x_names <- vars[-1]


  y <- as.matrix(data[, y_name])

  dmy <- dummyVars(formula, data, drop2nd = TRUE)
  x <- predict(dmy, data)
  binVars <- which(sapply(X, function(x){all(x %in% 0:1)}))

  if (standardize == TRUE){
    preprocessParams <- preProcess(x, method=c("center","scale"))
    x <- predict(preprocessParams, x)
  }else{
    if(standardize!=FALSE){
      stop("Invalid standardize parameter, should only be TRUE or FALSE")
    }
  }

  x <- cbind("(Intercept)" = 1, x)

  `%notin%` <- Negate(`%in%`)

  if (all(y %notin% 0:1)){
    y <- as.factor(y)
    if (nlevels(x) > 2){
      stop("fit function can only perform on binary target")
    }else{
      tmp <- levels(y)
      levels(y) <- c(0, 1)
      cat(tmp,"as been recoded respectively to 0, 1","\n")
      y <- as.matrix(as.numeric(levels(y))[y])
    }

  }


  return(list(target = y, features = x, y_name = y_name, x_names = x_names))
}
