#' Predict function
#'
#' @param Reg.log a variable containing the result of the fit function
#' @param newdata a matrix
#' @param type the name of the variable to predict
#'
#' @return a list of prediction or probability
#' @export
#'
#' @examples
#' predict(res_fit_batch, test_set[,res_fit_batch$x_names], type = "class")
predict <- function(Reg.log, newdata, type) {

  # New data control

  if (identical(Reg.log$x_names, colnames(newdata))) {
    x <- as.matrix(data.frame(rep(1, nrow(newdata)), newdata))
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
