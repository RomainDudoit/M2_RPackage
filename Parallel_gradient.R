parallelisation <- function(x, y, ncores, fonction, theta){
  #Création des blocs
  m <- nrow(y)
  blocs_size <- trunc((m / ncores))
  blocs <- list()
  index <- seq(1, m, blocs_size - 1)
  for (j in 1:trunc(m / blocs_size)) {
    y_i <- as.matrix(y[index[[j]]:index[[j + 1]], ])
    x_i <- as.matrix(x[index[[j]]:index[[j + 1]], ])
    blocs[[j]] <- list(x_i, y_i)
  }

  #Parallel
  clust <- parallel::makeCluster(ncores)
  clusterExport(clust, c("gradient" ,"x_dot_theta" ,"sigmoid" ,"probability" , "cost_function", "get_x_y"), # nolint
                envir=environment())
  
  res <- parallel::parSapply(clust, X = blocs, FUN = fonction, theta = theta) # nolint
  parallel::stopCluster(clust)
  return(t(t(rowSums(res))))
}

gradient <- function(X, theta) {
  x <- X[[1]]
  y <- X[[2]]
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) # nolint
}

library(parallel)
data <- read_excel("/Users/pierre/Documents/M2/Cours_M2/R/Projet/data.xlsx")
data$classe <- as.factor(data$classe)
levels(data$classe) <- c(0, 1)
data$classe <- as.numeric(levels(data$classe))[data$classe]
get_x_y <- function(formula, data) {
  data_frame <- model.frame(formula, data)
  y <- as.matrix(data_frame[, 1])
  x <- data_frame[, -1]
  x <- as.matrix(data.frame(rep(1, length(y)), x))
  return(list(target = y, features = x))
}
x_y <- get_x_y(classe ~ ., data)
x <- x_y$features
y <- x_y$target
initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

m <- nrow(y)
blocs_size <- trunc((m / 3))
blocs <- list()
index <- seq(1, m, blocs_size - 1)
for (j in 1:trunc(m / blocs_size)) {
  y_i <- as.matrix(y[index[[j]]:index[[j + 1]], ])
  x_i <- as.matrix(x[index[[j]]:index[[j + 1]], ])
  blocs[[j]] <- list(x_i, y_i)
}

blocs[[1]][[1]]

gradient(blocs[[1]], initial_theta)

x_dot_theta <- function(x, theta) {
  return(x %*% theta)
}

x_dot_theta(t(x), probability(x, initial_theta) - y)
x%*%initial_theta
probability(x, initial_theta)
res <- parallelisation(x,y,3,gradient,theta = initial_theta)
res
