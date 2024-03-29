% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.R
\name{rlgd.predict}
\alias{rlgd.predict}
\title{rlgd.Predict: Predict Method for rlgd.fit function}
\usage{
rlgd.predict(Reg.log, newdata, type)
}
\arguments{
\item{Reg.log}{object of the S3 class Reg.log provide by the rlgd.fit function.}

\item{newdata}{a data frame of new data to predict target variable. Should contains features only.}

\item{type}{indicate the type of prediction 'class' or 'posterior'}
}
\value{
predicted classes or class probabilities of the binary target variable defined in rlgd.fit function.
}
\description{
rlgd.Predict: Predict Method for rlgd.fit function
}
\details{
To work, the function need a data frame like the one used in the rlgd.fit function i.e same order and number of features
names. Also data types should be same. A control is only done on the order and number of features in the new data frame. The data is then
transformed in a matrix model like in rlgd.fit function with the same one hot encoding of the factors. Standardization is also performed
if if was done in rlgd.fit function by looking the attributes of the Reg.log object.
}
\examples{
set.seed(10)
library(caret)
train_index <- createDataPartition(breast_cancer$classe, p = 0.7, list = FALSE)
train_set <- breast_cancer[train_index, ]
test_set <- breast_cancer[-train_index, ]
res <- rlgd.fit(classe ~ ., train_set, mode = "batch", batch_size = 32, learning_rate = 0.01,
max_iter = 100, tol = 1e-4, standardize = FALSE)
rlgd.predict(res, test_set[, res$x_names], type = "class")

}
\seealso{
\itemize{
\item \code{\link{rlgd.fit}}
\item \code{\link{probability}}
}
}
