#' rlgd.Predict: Predict Method for rlgd.fit function
#'
#' @param Reg.log object of the S3 class Reg.log provide by the rlgd.fit function.
#' @param newdata a data frame of new data to predict target variable. Should contains features only.
#' @param type indicate the type of prediction 'class' or 'posterior'
#'
#' @return predicted classes or class probabilities of the binary target variable defined in rlgd.fit function.
#' @export
#'
#' @details To work, the function need a data frame like the one used in the rlgd.fit function i.e same order and number of features
#' names. Also data types should be same. A control is only done on the order and number of features in the new data frame. The data is then
#' transformed in a matrix model like in rlgd.fit function with the same one hot encoding of the factors. Standardization is also performed
#' if if was done in rlgd.fit function by looking the attributes of the Reg.log object.
#'
#' @seealso
#' \itemize{
#'   \item \code{\link{rlgd.fit}}
#'   \item \code{\link{probability}}
#' }
#'
#' @examples
#' set.seed(10)
#' library(caret)
#' train_index <- createDataPartition(breast_cancer$classe, p = 0.7, list = FALSE)
#' train_set <- breast_cancer[train_index, ]
#' test_set <- breast_cancer[-train_index, ]
#' res <- rlgd.fit(classe ~ ., train_set, mode = "batch", batch_size = 32, learning_rate = 0.01,
#' max_iter = 100, tol = 1e-4, standardize = FALSE)
#' rlgd.predict(res, test_set[, res$x_names], type = "class")
#'
rlgd.predict <- function(Reg.log, newdata, type) {

  # New data control

  if (identical(Reg.log$x_names, colnames(newdata))) {

    # tranform characters variables in factor
    newdata[sapply(newdata, is.character)] <- lapply(newdata[sapply(newdata, is.character)],as.factor)

    # model.matrix with same one hot encoding by looking xlevs attribute.
    x <- model.matrix(~., data = newdata, Reg.log$xlevs)

    # Look at if standardization was performed
    if (length(Reg.log$preprocess) != 0){
      x <- predict(Reg.log$preprocess,x)
    }

    # class probabilities
    probs = probability(x, Reg.log$theta)

    if (type == "class") {
      # predicted classes
      return(unlist(ifelse(probs > 0.5, 1, 0)))
    }else if (type == "posterior") {
      return(probs)
    }
  }else{
    stop("newdata shape is different from data used in fit function")
  }
}
