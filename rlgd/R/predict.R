#' Predict function
#'
#' @param Reg.log variable containing the result of the fit function
#' @param newdata matrix
#' @param type string ('class' or 'posterior')
#'
#' @return predicted classes or probabilites to belong to classes
#' @export
#'
#' @examples
#' set.seed(10)
#' library(caret)
#' train_index <- createDataPartition(breast_cancer$classe, p = 0.7, list = FALSE)
#' train_set <- breast_cancer[train_index, ]
#' test_set <- breast_cancer[-train_index, ]
#' res <- rlgd.fit(classe ~ ., train_set, mode = "batch", batch_size = 32, learning_rate = 0.01,
#' max_iter = 100, tol = 1e-4)
#' rlgd.predict(res, test_set[, res$x_names], type = "class")
rlgd.predict <- function(Reg.log, newdata, type) {

  # New data control

  data[sapply(data, is.character)] <- lapply(data[sapply(data, is.character)],as.factor)

  if (identical(Reg.log$x_names, colnames(newdata))) {

    x <- model.matrix(~., data = newdata, xlev = Reg.log$xlevs)

    if (is.null(Reg.log$preprocessParams) == FALSE){
      x <- predict(Reg.log$preprocessParams,x)
    }

    # Probability of belonging
    probs = probability(x, Reg.log$theta)

    if (type == "class") {
      return(unlist(ifelse(probs > 0.5, 1, 0)))
    }else if (type == "posterior") {
      return(probs)
    }
  }else{
    return("Erreur")
  }
}
