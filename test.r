library(readxl)
library(ggplot2)

# sigmoid function
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


# cost function
cost_function <- function(x, y, theta) {
    m <- nrow(y)
    g <- probability(x, theta)
    j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))
    return(j)
}

# Gradient
gradient <- function(x, y, theta) {
    m <- nrow(y)
    return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y))
}

# Gradient descent
gradient_descent <- function(x, y, theta, learning_rate, n_iter) {
    cost_history <- c(cost_function(x, y, theta))
    for (i in 1:n_iter) {
        theta <- theta - learning_rate * gradient(x, y, theta)
        cost_history <- c(cost_history, cost_function(x, y, theta))
    }
    return(list(theta = theta, cost_history = cost_history))
}


data <- read_excel("breast.xlsx")

# Régression logistique et descente de gradient

y <- data[, ncol(data)]
y <- ifelse(y == "malignant", 1, 0)


x <- data[, 1:(ncol(data) - 1)]

 # Ajout de la colonne de 1 pour faire le produit scalaire
x <- as.matrix(data.frame(rep(1, length(y)), x))

# Initialisation des paramètres theta
initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

res <- gradient_descent(x, y, initial_theta, learning_rate = 0.1, n_iter = 200)

print(res$theta)
print(res$cost_history)


plot(1:length(res$cost_history), res$cost_history)
