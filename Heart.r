#Test
res <- gradient_descent(bloc_x[1], bloc_y[1], initial_theta, learning_rate = 0.1, n_iter = 200)
mean(predict(x, res$parameters) == y)

bloc_x[1] %*% initial_theta
unlist(bloc_x[1])
s<-bloc_x[2]
class(s[1])=="lis"

a <- blocs[[1]]
a[[2]]
a <- runif(10)
class(a)
k<-2
ricco_bloc <- split(a,1+(1:10)%%k)
class(ricco_bloc[[1]])

  if (class(s)=="list"){
    s <- s[[1]]
  }
class(s)

#Séparer le jeu en nb coeurs
k <- 3

blocs_size <- trunc((m/k))
blocs <- list()
for (j in 1:trunc(m / blocs_size)) {
  print(j)
  y_i <- as.matrix(y[index[[j]]:index[[j + 1]], ])
  x_i <- as.matrix(x[index[[j]]:index[[j + 1]], ])
  blocs[[j]] <- list(x_i,y_i)}

#Parallelisation
getwd()
print(parallel::detectCores())
clust <- parallel::makeCluster(k,outfile="test.txt")
clusterExport(clust, c("gradient","x_dot_theta","sigmoid","probability","cost_function"), 
              envir=environment())

res <- parallel::parSapply(clust, X = blocs, FUN = gradient_descent, theta = initial_theta, 
                           learning_rate = 0.1, n_iter = 200)
res
parallel::stopCluster(clust)
  
x_dot_theta <- function(x, theta) {
  return(x %*% theta)
}
x_dot_theta(bloc_x[1],initial_theta)
probability(bloc_x[1], initial_theta) - bloc_y[1]

#Exemple
test <- function(x){
  z <- test2(x)
  return(x+z)
}
test2 <- function(x){
  return(x*2)
}

k <- 5
l = c(1,2,3,4,5,6,7,8,9,10)
inter <-split(l,1+1:length(l)%%k)
print(parallel::detectCores())
clust <- parallel::makeCluster(k)
clusterExport(clust, c("test2"), 
              envir=environment())
res <- parallel::parSapply(clust,inter,FUN = test)
res

test(x)
?parSapply()
