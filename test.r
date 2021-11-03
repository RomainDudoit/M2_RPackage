# Régression logistique et descente de gradient


# Fonction sigmoïde (comprise entre 0 et 1)
sigmoid <- function(x) {
    return(1 / (1 + exp(-x)))
}

# Produit Matriciel entre X et theta
x_dot_theta <- function(x, theta) {
    return(x %*% theta)
}

probability <- function(x, theta) {
    return(sigmoid(x_dot_theta(x, theta)))
}


# Fonction de coût
cost_function <- function(X, y, theta) {
    m <- nrow(y) # nombre d'observations
    g <- probability(X, theta)
    j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))
    return(j)
}

# Calcul du gradient
gradient <- function(x, y, theta) {
    m <- nrow(y)
    return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y))
}


# Optimisation de theta
optimisation <- function(X, y, theta, learning_rate) {
    gradient <- gradient(X, y, theta)
    theta <- theta - learning_rate * gradient
    return(theta)
}


fit <- function() {

}

logistic_regression <- function(X, y, learning_rate = 0.1, n_iter = 100) {



}