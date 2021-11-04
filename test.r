library(readxl)

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
optimisation <- function(x, y, theta, learning_rate) {
    gradient <- gradient(x, y, theta)
    theta <- theta - learning_rate * gradient
    return(theta)
}

# batch descent gradient, modifier selon le mode stochastique ou mini batch
logistic_regression <- function(x, y, learning_rate = 0.1, n_iter = 100) {
    # Initialisation des paramètres
    theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

    # Optimisation des paramètres pour un certain nombre d'itérations
    for (i in range(n_iter)) {
        theta <- optimisation(x, y, theta, learning_rate)
        print(theta)
    }
    return(theta)
}

data <- read_excel("M2_RPackage/breast.xlsx")

# Régression logistique et descente de gradient

y <- data[, ncol(data)]
y <- ifelse(y == "malignant", 1, 0)


x <- data[, 1:(ncol(data) - 1)]

theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))


x <- as.matrix(data.frame(rep(1, length(y)), x))
n <- dim(x)

best_theta <- logistic_regression(x, y, learning_rate = 0.1, n_iter = 500)
