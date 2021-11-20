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

#Mini_batch
prepare_batches <- function(x,y,batch_size){
  x_batch <- split(x, rep(1:ceiling(nrow(x)/batch_size), each=batch_size, length.out=nrow(x)))
  y_batch <- split(y, rep(1:ceiling(nrow(y)/batch_size), each=batch_size, length.out=nrow(y)))
  each_batch <- lengths(y_batch)
  
  if (each_batch[length(each_batch)] < batch_size){
    x_batch <- x_batch[-length(x_batch)]
    y_batch <- y_batch[-length(each_batch)]
  }
  return(list(x_batch = x_batch, y_batch = y_batch))
}

split(x, rep(1:ceiling(nrow(x)/batch_size), each=batch_size, length.out=nrow(x)))

batches <- prepare_batches(x,y,10)
batches$y_batch

# Gradient descent mini batch
gradient_descent <- function(x, y, theta, learning_rate, n_iter,batch_size=10 ) {
  #Need to randomly shuffle the data
  x_mat <- as.matrix(data.frame(rep(1, length(y)), x))
  cost_history <- c()
  for (epoch in 1:n_iter) {
    print(paste("epoch",epoch))
    batches <- prepare_batches(x,y,batch_size)
    for (i in 1:length(batches$x_batch)){
      x_grp <- as.data.frame(batches$x_batch[i])
      names(x_grp) <- names(x)
      
      y_grp <- as.data.frame(batches$y_batch[i])
      names(y_grp) <- "classe"
      
      x_grp <- as.matrix(data.frame(rep(1, length(y_grp)), x_grp))
      y_grp <- as.matrix(y_grp)
      
      theta <- theta - learning_rate * gradient(x_grp, y_grp, theta)
    }
    cost_history <- c(cost_history, cost_function(x_mat, y, theta))
  }
  return(list(parameters = matrix(theta), cost_history = cost_history))
}



predict <- function(x, theta, thresold = 0.5) {
  predictions = unlist(ifelse(probability(x, theta) > thresold, 1, 0))
  return(predictions)
}

# test avec data_breast_cancer
data <- read_excel("/Users/pierre/Documents/M2/Cours_M2/R/Projet/data.xlsx")
y <- data[, ncol(data)]
y <- ifelse(y == "malignant", 1, 0)
class(y)

x <- data[, 1:(ncol(data) - 1)]

# Ajout de la colonne de 1 pour faire le produit scalaire

# Initialisation des paramètres theta
initial_theta <- as.matrix(rnorm(n = dim(x)[2]+1, mean = 0, sd = 1))

# Entrainement
res <- gradient_descent(x, y, initial_theta, learning_rate = 0.1, n_iter = 500)
x <- as.matrix(data.frame(rep(1, length(y)), x))
y_pred <- predict(x, res$parameters)

print(res$parameters)
print(res$cost_history)
plot(seq(1, length(res$cost_history)), res$cost_history, type = "l")

accuracy <- mean(y_pred == y)
accuracy
