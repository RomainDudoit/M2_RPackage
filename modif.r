
##############################################################################################################

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

##############################################################################################################

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

##############################################################################################################

stochastic_gradient_descent <- function(x, y, theta, learning_rate, max_iter, tol) {

    cost_history <- c()
    m <- nrow(y)
    iter <- 0
    converge <- FALSE
    theta_list <- c()
    
    while ((iter < max_iter) && (converge == FALSE)) {
        iter <- iter + 1
        random_index <- sample(x = m, size = m)

        for (j in 1:m) {
            # Update theta
            y_i <- as.matrix(y[random_index[j], ])
            x_i <- t(as.matrix(x[random_index[j], ]))
            theta <- theta - learning_rate * gradient(x_i, y_i, theta)
        }
        cost_history <- c(cost_history, cost_function(x_i, y_i, theta))
        
        theta_list <- append(theta_list, theta)

        if (sum(abs(theta_list[length(theta_list)] - theta_list[length(theta_list)-1])) < tol) {
            converge <- TRUE
        }
    }
    return(list(theta = theta, cost_history = cost_history))
}

##############################################################################################################

mini_batch_gradient_descent <- function(x, y, theta, learning_rate, max_iter, batch_size, tol) {

    cost_history <- c()
    m <- nrow(y)
    iter <- 0
    converge <- FALSE
    theta_list <- c()

    while ((iter < max_iter) && (converge == FALSE)) {
        # Shuffle data
        iter <- iter + 1
        random_index <- sample(x = m, size = m)
        x <- as.matrix(x[random_index, ])
        y <- as.matrix(y[random_index, ])
        x_i <- c()
        y_i <- c()

        index <- seq(1, m, batch_size - 1)

        for (j in 1:trunc(m / batch_size)) {
            y_i <- as.matrix(y[index[[j]]:index[[j + 1]], ])
            x_i <- as.matrix(x[index[[j]]:index[[j + 1]], ])
            theta <- theta - learning_rate * gradient(x_i, y_i, theta)
        }
        cost_history <- c(cost_history, cost_function(x_i, y_i, theta))

        theta_list <- append(theta_list, theta)

        if (sum(abs(theta_list[length(theta_list)] - theta_list[length(theta_list)-1])) < tol) {
            converge <- TRUE
        }

    }
    return(list(theta = theta, cost_history = cost_history))
}


##############################################################################################################

# Gradient descent
fit <- function(formula, data, mode, batch_size, learning_rate = 0.5, max_iter = 100, tol = 1e-4) { 
    x_y <- get_x_y(formula, data) 

    x <- x_y$features
    y <- x_y$target
    y_name <- x_y$y_name
    x_names <- x_y$x_names


    initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

    if (mode == "batch" || (mode == "mini-batch" && batch_size >= nrow(y))) {
        gradient_descent <- batch_gradient_descent(x, y, initial_theta, learning_rate, max_iter, tol) 
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



##############################################################################################################

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
