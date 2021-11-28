#' get_x_y function
#'
#' This function is part of the rlgd.fit() function of this package and is used to perform several preprocessing steps.
#'
#' @details It identify the \eqn{X} features and \eqn{y} target variable from the formula input.
#' After transforming the potential character variables into factor, a model matrix is created from the formula.
#' The model matrix is the matrix that contains in the first column the intercept and the features of
#' the formula in the others columns. One hot encoding is automatically performed on factors during the creation of the model matrix.
#' The function can also perform standardization on continuous or no binary (0,1) numeric variables with the preprocess function of the caret package.
#' This function also check if the target variable is only binary since the package cannot do multinomial logistic regression.
#'
#' @param formula formula e.g y ~ x + b
#' @param data dataframe including features and target variable
#' @param standardize logical, FALSE by default, set to TRUE to apply standardization.
#'
#' @return several variables in a list
#' \itemize{
#'   \item target: matrix of target variable from R formula
#'   \item features : matrix of features from R formula
#'   \item y_name : the name of the target variable
#'   \item x_names : the names of the features
#'   \item preprocess : NUll or contains output of preProcess function of the caret package. It will be used in rlgd.predict() function to apply or not
#'   standardization on new data.
#'   \item xlevs : list of levels for each factor in the data frame. It will be used in rlgd.predict() function to process the same one hot encoding
#'   on new data.
#' }
#' @importFrom caret dummyVars preProcess
#' @importFrom formula.tools get.vars
#' @importFrom stats predict model.matrix na.omit
#' @export
#'
#' @seealso
#' \itemize{
#'   \item \code{\link{rlgd.fit}}
#'   \item \code{\link[stats]{model.matrix}}
#'   \item \code{\link[caret]{preProcess}}
#' }
#'
#'
#' @examples
#' get_x_y(classe ~.,breast_cancer, standardize=TRUE)
get_x_y <- function(formula, data, standardize) {

  vars <- get.vars(formula, data)
  y_name = vars[1]
  x_names <- vars[-1]

  # Convert character variables to factor
  data[sapply(data, is.character)] <- lapply(data[sapply(data, is.character)],as.factor)

  # Transform factors to levels and drop one
  x <- model.matrix(formula, data)
  preprocessParams <- NULL

  # this is a list of levels for each factor in the original df
  xlevs <- lapply(data[,x_names][,sapply(data[,x_names], is.factor), drop = F], function(j){
    levels(j)
  })

  # Standardization is only perform on numeric data and no binary

  if (standardize == TRUE){
    # Find variables
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

  # if target is not binary (0,1,1,1,0....)
  if (all(y %notin% 0:1)){
    y <- as.factor(y)
    if ((nlevels(y) > 2) ||(nlevels(y) == 1)){
      stop("fit function can only perform on two classes")
    }else{
      tmp <- levels(y)
      levels(y) <- c(0, 1)
      cat(tmp,"as been recoded respectively to 0, 1","\n")
      y <- as.matrix(as.numeric(levels(y))[y])
    }
  }

  return(list(target = y, features = x, y_name = y_name, x_names = x_names, preprocess = preprocessParams, xlevs = xlevs))
}
