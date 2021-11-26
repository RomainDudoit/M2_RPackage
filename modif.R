batch_gradient_descent_paral <- function(x, y, theta, learning_rate, max_iter, tol, ncores) {
  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE
  
  clust <- parallel::makeCluster(ncores)
  clusterExport(clust, c("x_dot_theta" ,"sigmoid" ,"probability" , "cost_function", "get_x_y"),
                envir=environment())
  #Création des blocs
  m <- nrow(y)
  blocs_size <- trunc((m / ncores))
  blocs <- list()
  index <- append(round(seq(1, m, by = m/ncores)),m)
  for (j in 1:(length(index)-1)) {
    if (j==length(index)-1) reglage_borne <- 0 else reglage_borne <- 1
    y_i <- as.matrix(y[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    x_i <- as.matrix(x[index[[j]]:(index[[j + 1]] - reglage_borne), ])
    blocs[[j]] <- list(x_i, y_i)
  }
  
  while ((iter < max_iter) && (converge == FALSE)) {
    iter <- iter + 1
    random_index <- sample(x = m, size = m)
    new_theta <- theta - learning_rate * parallelisation(blocs ,gradient_parallele,theta = theta,clust)#pas de mélange des données !!
    cost_history <- c(cost_history, cost_function(x[random_index, ], as.matrix(y[random_index, ]), new_theta))
    
    if (sum(abs(new_theta - theta)) < tol) {
      converge <- TRUE
    }
    
    theta <- new_theta
  }
  parallel::stopCluster(clust)
  return(list(theta = theta, cost_history = cost_history))
}

batch_gradient_descent <- function(x, y, theta, learning_rate, max_iter, tol) {
  
  cost_history <- c()
  m <- nrow(y)
  iter <- 0
  converge <- FALSE

  while ((iter < max_iter) && (converge == FALSE)) {
    iter <- iter + 1
    random_index <- sample(x = m, size = m)
    new_theta <- theta - learning_rate * gradient(x[random_index, ], as.matrix(y[random_index, ]), theta)
    cost_history <- c(cost_history, cost_function(x[random_index, ], as.matrix(y[random_index, ]), new_theta))
    
    if (sum(abs(new_theta - theta)) < tol) {
      converge <- TRUE
    }
    
    theta <- new_theta
  }
  return(list(theta = theta, cost_history = cost_history))
}

parallelisation <- function(blocs, fonction, theta, clust){
  res <- parallel::parSapply(clust, X = blocs, FUN = fonction, theta = theta) # nolint
  return(t(t(rowSums(res))))
}

gradient_parallele <- function(X, theta) {
  x <- X[[1]]
  y <- X[[2]]
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) # nolint
}
##############################################################################################################
gradient <- function(x, y, theta) {
  m <- nrow(y)
  return((1 / m) * x_dot_theta(t(x), probability(x, theta) - y)) # nolint
}

# Gradient descent
fit <- function(formula, data, mode, batch_size, learning_rate = 0.5, max_iter = 100, tol = 1e-4, ncores = 1) { 
  x_y <- get_x_y(formula, data) 
  
  x <- x_y$features
  y <- x_y$target
  y_name <- x_y$y_name
  x_names <- x_y$x_names
  
  
  initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
  
  if (mode == "batch" || (mode == "mini-batch" && batch_size >= nrow(y))) {
    gradient_descent <- batch_gradient_descent(x, y, initial_theta, learning_rate, max_iter, tol, ncores) 
  } else if (mode == "online" || (mode == "mini-batch" && batch_size == 1)) { 
    gradient_descent <- stochastic_gradient_descent(x, y, initial_theta, learning_rate, max_iter, tol) 
  } else if (mode == "mini-batch") {
    gradient_descent <- mini_batch_gradient_descent(x, y, initial_theta, learning_rate, max_iter, batch_size, tol) 
  } else {
    return("erreur")
  }
  
  # Création de l'instance
  inst <- list(formula = formula, x = x, y = y, y_name = y_name, x_names = x_names, mode = mode, batch_size = batch_size, learning_rate = learning_rate, n_iter = max_iter, 
               initial_theta = initial_theta, theta = gradient_descent[[1]], cost_history = gradient_descent[[2]]
  ) 
  
  attr(inst, "class") <- "Reg.Log"
  return(inst)
}

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

get_x_y <- function(formula, data) {
  data_frame <- model.frame(formula, data)
  
  vars = get.vars(formula, data)
  
  y_name = vars[1]
  x_names = vars[-1]
  
  y <- as.matrix(data_frame[, y_name])
  x <- data_frame[, x_names]
  x <- as.matrix(data.frame(rep(1, length(y)), x))
  
  return(list(target = y, features = x, y_name = y_name, x_names = x_names))
}
