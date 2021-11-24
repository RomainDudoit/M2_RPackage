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
