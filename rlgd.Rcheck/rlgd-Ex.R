pkgname <- "rlgd"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "rlgd-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('rlgd')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("batch_gradient_descent")
### * batch_gradient_descent

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: batch_gradient_descent
### Title: Gradient Descent Function - Batch
### Aliases: batch_gradient_descent

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
batch_gradient_descent(x,y,theta,learning_rate=0.01,max_iter=100,tol=1e-4,ncores=3)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("batch_gradient_descent", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("breast_cancer")
### * breast_cancer

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: breast_cancer
### Title: Data of breast cancer
### Aliases: breast_cancer
### Keywords: datasets

### ** Examples

data(breast_cancer)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("breast_cancer", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("cost_function")
### * cost_function

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: cost_function
### Title: Cost function
### Aliases: cost_function

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
cost_function(x,y,as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1)))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("cost_function", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("get_x_y")
### * get_x_y

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_x_y
### Title: get_x_y_function
### Aliases: get_x_y

### ** Examples

get_x_y(classe ~., data=breast_cancer)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_x_y", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("gradient")
### * gradient

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: gradient
### Title: Gradient function
### Aliases: gradient

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
gradient(x,y,theta)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("gradient", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("make_blocs")
### * make_blocs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: make_blocs
### Title: Creation of blocs for parallelisation
### Aliases: make_blocs

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
make_blocs(x,y,ncores=3)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("make_blocs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("mini_batch_gradient_descent")
### * mini_batch_gradient_descent

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: mini_batch_gradient_descent
### Title: Gradient Descent Function - Mini-Batch
### Aliases: mini_batch_gradient_descent

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
mini_batch_gradient_descent(x,y,theta,learning_rate = 0.01, max_iter = 100,batch_size = 32, tol = 1e-4)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("mini_batch_gradient_descent", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("probability")
### * probability

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: probability
### Title: Probability function
### Aliases: probability

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
probability(x,theta)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("probability", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("sigmoid")
### * sigmoid

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: sigmoid
### Title: sigmoid function
### Aliases: sigmoid

### ** Examples

sigmoid(2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("sigmoid", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("stochastic_gradient_descent")
### * stochastic_gradient_descent

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: stochastic_gradient_descent
### Title: Title
### Aliases: stochastic_gradient_descent

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
stochastic_gradient_descent(x,y,theta,learning_rate=0.01,max_iter=100,tol=1e-4,ncores=3)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("stochastic_gradient_descent", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("x_dot_theta")
### * x_dot_theta

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: x_dot_theta
### Title: x_dot_theta function
### Aliases: x_dot_theta

### ** Examples

x <- as.matrix(breast_cancer[1:10,1:4])
y <- breast_cancer[1:10,"classe"]
y <- as.matrix(ifelse(y$classe =="malignant",1,0))
theta <- as.matrix(rnorm(n = dim(x)[2], mean = 0, sd = 1))
x_dot_theta(x,theta)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("x_dot_theta", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
