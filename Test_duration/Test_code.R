library(readxl)
library(parallel)
library(ggplot2)
library(formula.tools)
library("caret")

data <- rlgd::breast_cancer
data$classe <- as.factor(data$classe)
levels(data$classe) <- c(0, 1)
data$classe <- as.numeric(levels(data$classe))[data$classe]
table(data$classe)

row_result = add_row(c(25, 100, 200, 350, 500, 650, 800),data) #paramètre de l'exemple du cours : c(25, 100, 200, 350, 500, 650, 800)
ggplot(row_result) +
  geom_line(aes(x = nb_line, y = parallel, colour = "parallel")) +
  geom_point(aes(x = nb_line, y = parallel, colour = "parallel")) +
  geom_line(aes(x = nb_line, y = normal, colour = "normal")) +
  geom_point(aes(x = nb_line, y = normal, colour = "normal")) +
  scale_x_continuous("Number of row") +
  scale_y_continuous("Time")

col_result = add_col(700, c(0,3,6,9,12,15), data) #paramètres de l'exemple du cours : 700 et c(0,3,6,9,12,15)
ggplot(col_result) +
  geom_line(aes(x = nb_col, y = parallel, colour = "parallel")) +
  geom_point(aes(x = nb_col, y = parallel, colour = "parallel")) +
  geom_line(aes(x = nb_col, y = normal, colour = "normal")) +
  geom_point(aes(x = nb_col, y = normal, colour = "normal")) +
  scale_x_continuous("Nomber of column") +
  scale_y_continuous("Time")
