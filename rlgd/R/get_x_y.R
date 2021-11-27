#' get_x_y_function
#'
#' @param formula a formula
#' @param data a matrix
#' @param standardize TRUE or FALSE
#'
#' @return list(y,x,y_name,x_name), y & x = matrix, y_name & x_names = c()
#' @importFrom caret dummyVars preProcess
#' @importFrom formula.tools get.vars
#' @importFrom stats predict model.matrix na.omit
#' @export
#'
#' @examples
#' get_x_y(classe ~.,breast_cancer, standardize=TRUE)
get_x_y <- function(formula, data, standardize) {

  vars <- get.vars(formula, data)
  y_name = vars[1]
  x_names <- vars[-1]

  # Transform factors to levels and drop one
  x <- model.matrix(formula, data)

  # Standardization is only perform on numeric data and no binary

  if (standardize == TRUE){
    is_binary <-apply(x,2,function(x){all(na.omit(x) %in% 0:1)})
    no_binary <- x[,names(is_binary[is_binary==FALSE])]
    preprocessParams <- preProcess(no_binary, method=c("center","scale"))
    x <- predict(preprocessParams, x)

  }else{
    if(standardize!= FALSE){
      stop("Invalid standardize parameter, should only be TRUE or FALSE")
    }
  }

  y <- as.matrix(data[, y_name])

  `%notin%` <- Negate(`%in%`)

  if (all(y %notin% 0:1)){
    y <- as.factor(y)
    if (nlevels(x) > 2){
      stop("fit function can only perform on binary target")
    }else{
      tmp <- levels(y)
      levels(y) <- c(0, 1)
      cat(tmp,"as been recoded respectively to 0, 1","\n")
      print("hello")
      y <- as.matrix(as.numeric(levels(y))[y])
    }

  }


  return(list(target = y, features = x, y_name = y_name, x_names = x_names))
}
