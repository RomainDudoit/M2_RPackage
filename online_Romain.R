library(readxl)
library(ggplot2)

# sigmoid function
sigmoid <- function(x) {
  return(1 / (1 + exp(-x)))
}

# Produit Matriciel entre X et theta

#x_dot_theta <- function(x, theta) {
#  return(x %*% theta)
#}

x_dot_theta <- function(x, theta) {
  return(x * t(theta))
}

t(x[1,]) %*% initial_theta

probability <- function(x, theta) {
  return(sigmoid(x_dot_theta(x, theta)))
}

# cost function
cost_function <- function(x, y, theta, mode) {
  if(!is.null(nrow(y))) m <- nrow(y) else m <- 1
  g <- probability(x, theta)
  j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))
  return(j)
}

m <- nrow(y)
g <- probability(x, theta)
j <- (1 / m) * sum((-y * log(g)) - ((1 - y) * log(1 - g)))



# Gradient
gradient <- function(x, y, theta,mode,n_iter) {
    if(!is.null(nrow(y))) m <- nrow(y) else m <- 1
    return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y))
}

sum((-y * log(probability(x[1,], initial_theta))))
dim(as.matrice(x[1,]))
log(probability(x[1,], t(initial_theta)))
log(probability(x, initial_theta))
x
sigmoid(x_dot_theta(x[1,], initial_theta))

x[1,] %*% initial_theta
probability(x, initial_theta)
x_dot_theta(t(x[1,]),(x[1,] %*% initial_theta)-y[1,])
x_dot_theta(t(x),(x %*% initial_theta)-y)

# Gradient descent
gradient_descent <- function(x, y, theta, learning_rate, n_iter, mode) {
  cost_history <- c()
  for (epoch in n_iter){
    for (i in 1:length(y)) {
      if (mode == "batch"){
        theta <- theta - learning_rate * gradient(x, y, theta, mode, i)
        cost_history <- c(cost_history, cost_function(x, y, theta, mode))
      }
      else if (mode == "sto") {
        stochasticList <- sample(1:length(y), length(y), replace=FALSE)
        y_sample <- y[stochasticList[i],]
        x_sample <- x[stochasticList[i],]
        theta <- theta - t(learning_rate * gradient(x_sample, y_sample, theta, mode, i))
        cost_history <- c(cost_history, cost_function(x_sample, y_sample, theta, mode))
      
    }}}
  return(list(parameters = matrix(theta), cost_history = cost_history))
}

initial_theta - t(t)
t <- 0.1 * gradient(x_sample, y_sample, initial_theta, mode="sto", 1)

stochasticList <- sample(1:length(y), length(y), replace=FALSE)
initial_theta*x[stochasticList[1],]
y_sample <- y[stochasticList[1],]
x_sample <- x[stochasticList[1],]
initial_theta <- initial_theta - as.numeric(0.1 * gradient(x_sample, y_sample, initial_theta, mode="sto", 1))

predict <- function(x, theta, thresold = 0.5) {
  predictions = unlist(sigmoid(x %*% theta) > thresold, 1, 0)
  return(predictions)
}
b<-c(0,0,0)
c <- c(b,0)
c
# test avec data_breast_cancer
library(readxl)
data <- read_excel("/Users/pierre/Documents/M2/Cours_M2/R/data.xlsx")
y <- data[, ncol(data)]
y <- ifelse(y == "malignant", 1, 0)

x <- data[, 1:(ncol(data) - 1)]

# Ajout de la colonne de 1 pour faire le produit scalaire
x <- as.matrix(data.frame(rep(1, length(y)), x))

# Initialisation des paramètres theta
initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
# Entrainement
res <- gradient_descent(x, y, initial_theta, learning_rate = 0.1, n_iter = 10000,mode = "sto")
res$cost_history
y_pred <- predict(x, res$parameters)

predictions = unlist(ifelse(probability(x, initial_theta) > 0.5, 1, 0))

print(res$parameters)
print(res$cost_history)
plot(seq(1, length(res$cost_history)), res$cost_history, type = "l")

accuracy <- mean(y_pred == y)
accuracy
x[2,] %*% initial_theta
model<-glm(y~x, family=binomial(link="logit"))

