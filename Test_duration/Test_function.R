add_row <- function(list_iteration, data){
  #list_iteration : liste contenant les différents tests avec chaque test = le nombre de fois que l'on ajoute le dataset initial
  #data : notre jeu de donnée breast_cancer

  cp = c()
  cn = c()
  nb_line = c()

  for (i in list_iteration){
    print(i)
    data_prod_row = data #initialisation des données
    for(row in 1:i){ #on ajoute les lignes du jeu de donnée initial i fois
      data_prod_row = rbind(data_prod_row,data)
    }

    # On récupère x et y + initialisation theta
    x_y <- get_x_y(classe ~., data_prod_row, FALSE)
    y <- x_y$target
    x <- x_y$features
    initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

    # Test sur la durée de l'algorithme
    start <- Sys.time ()
    result <- batch_gradient_descent(x, y, theta=initial_theta, learning_rate=0.01, max_iter=100, tol = 1e-4, ncores = 6)
    # On récupère la temps d'exécution du batch parallélisé
    cp <- c(cp, as.numeric(Sys.time () - start))

    start <- Sys.time ()
    result <- batch_gradient_descent(x, y, theta=initial_theta, learning_rate=0.01, max_iter=100, tol = 1e-4, ncores = 1)
    # On récupère la temps d'exécution du batch normal
    cn <- c(cn, as.numeric(Sys.time () - start))

    # On récupère le nombre de ligne
    nb_line <- c(nb_line, nrow(x))
  }
  perf = data.frame(unlist(nb_line), unlist(cp), unlist(cn))
  names(perf) = c("nb_line","parallel",'normal')
  return(perf)
}


add_col <- function(row=700, list_iteration, data){
  #row : nombre de fois que l'on ajoute les lignes du dataset original (par défault = 700)
  #list_iteration : nombre de colonne que l'on ajoute à notre dataset
  #data : notre jeu de donnée breast_cancer

  cp = c()
  cn = c()
  nb_col = c()

  #Ajout des lignes
  data_prod_prep = data
  for(row in 1:row){
    data_prod_prep = rbind(data_prod_prep,data)
  }

  for (col in list_iteration){
    print(col)
    data_prod = data_prod_prep
    if(col != 0) {
      for(c in 1:col){
        # Création de la colonne à ajouter
        new_col <- as.data.frame(sample(1:10,nrow(data_prod),replace = T))
        names(new_col) <- c(paste("new_col_",c, sep=''))
        # Ajout
        data_prod = cbind(data_prod,new_col)
      }}

    # On récupère x et y + initialisation theta
    x_y <- get_x_y(classe ~., data_prod, FALSE)
    y <- x_y$target
    x <- x_y$features
    initial_theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))

    # Test sur la durée de l'algorithme
    start <- Sys.time ()
    result <- batch_gradient_descent(x, y, theta=initial_theta, learning_rate=0.01, max_iter=100, tol = 1e-4, ncores = 6)
    # On récupère la temps d'exécution du batch parallélisé
    cp <- c(cp, as.numeric(Sys.time () - start))

    start <- Sys.time ()
    result <- batch_gradient_descent(x, y, theta=initial_theta, learning_rate=0.01, max_iter=100, tol = 1e-4, ncores = 1)
    # On récupère la temps d'exécution du batch normal
    cn <- c(cn, as.numeric(Sys.time () - start))

    # On récupère le nombre de ligne
    nb_col <- c(nb_col, ncol(x))
  }
  perf = data.frame(unlist(nb_col), unlist(cp), unlist(cn))
  names(perf) = c("nb_col","parallel",'normal')
  return(perf)
}
