library(Formula)

# Create formulas
f1 <- y ~ x1 + x2
F1 <- Formula(f1)
class(F1)

all.F1()

install.packages('formula.tools')
library(formula.tools)


form <- y ~ 

get.vars(form)
lhs.vars(form)
rhs.vars(form)
op(form)
x[1]

glm <- function(formula, family = gaussian, data, weights,
                subset, na.action, start = NULL,
                etastart, mustart, offset,
                control = list(...),
                model = TRUE, method = "glm.fit",
                x = FALSE, y = TRUE,
                contrasts = NULL, ...)
{
  ## extract x, y, etc from the model formula and frame
  if(missing(data)) data <- environment(formula)
  mf <- match.call(expand.dots = FALSE)
  print(mf)
  m <- match(c("formula", "data", "subset", "weights", "na.action",
               "etastart", "mustart", "offset"), names(mf), 0L)
  print(m)
  mf <- mf[c(1L, m)]
  print(mf)
  mf$drop.unused.levels <- TRUE
  return(mf)
}

a <- glm(gear ~ .,data = inputData)
class(a)
a$formula
a$formula[1]
a$formula[2]
class(a$formula[3])
get.vars(a$formula)
lhs.vars(a$formula)
rhs.vars(eval(a$formula))

if("gear" in lhs.vars(a$formula))


