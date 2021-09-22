# Regression in R

This is a quick introduction to the concept of regression analysis. 

## Linear Regression 

Linear regression is a statistical method for obtaining a prediction of an outcome 
<img src="https://render.githubusercontent.com/render/math?math=Y_i"> 
from an observed variable.

### The Regression Equation


The prediction takes the form of a linear equation for the prediction of 
<img src="https://render.githubusercontent.com/render/math?math=Y_i"> 
as a linear combination of the variables
<img src="https://render.githubusercontent.com/render/math?math=X_i">
multiplied by the parameter
<img src="https://render.githubusercontent.com/render/math?math=\beta_1">, 
plus an intercept
<img src="https://render.githubusercontent.com/render/math?math=\beta_0">.

<img src="Images/Regression_Equation.png">


### The Minimization Problem

The parameters 
<img src="https://render.githubusercontent.com/render/math?math=\beta_1"> 
and
<img src="https://render.githubusercontent.com/render/math?math=\beta_0">
are estimated by minimizing the sum of squared residuals from the regression line defined by
<img src="https://render.githubusercontent.com/render/math?math=\beta_1"> 
and
<img src="https://render.githubusercontent.com/render/math?math=\beta_0">.
The residuals are the differerences from the observed values 
<img src="https://render.githubusercontent.com/render/math?math=Y_i"> 
from the values predicted by the regression line. 


<img src="Images/Regression_Minimization.png">


### Estimating a Linear Regression in R

Estimating a linear regression in R involves three main steps.
1. Reading in the data.
1. Specifying the regression equation.
1. Calculating the statistics for the regression model.

You can read in the data with the ```read.table``` or the ```read.csv``` function. 

```
my_data <- read.csv('path_to_my_data/name_of_data_set_file.csv')
```

Then specify a ```formula``` object. 
This is dfined by a set of notation to specify the names of the dependent variables and explanatory variables. 
A formula takes the form 
```
Y ~ X_1 + X_2 + X_3
```
which will estimate a regression using ```X_1```, ```X_2``` and ```X_3```
to predict ```Y```. 
You can also create the formula object from a string using the ```as.formula``` function:
```
my_lm_fmla <- as.formula("Y ~ X_1 + X_2 + X_3")
```


Then pass these two arguments to the ```lm``` function. 
```
my_lm_model <- lm(data = my_data, formula = Y ~ X_1 + X_2 + X_3)
```

If you created a formula object from a string, you can pass the formula through the ```formula``` argument with ```formula = my_lm_fmla```,
instead of typing in the regression equation directly.

The results of the regression are stored in the ```lm``` object ```my_lm_model```. 
You can print out the regression results by summarizing the ```lm``` model object ```my_lm_model``` that was created by the ```lm``` function.
This is done by using the generic ```summary``` function just as you would for a variable or any other object. 


```
summary(my_lm_model)
```



### The Fit of a Regression Model

The quality of fit of a regression model is determined by the degree to which the observations fit close to the regression line. 
It is represented by the statistic 
<img src="https://render.githubusercontent.com/render/math?math=r^2">, 
pronounced "R-squared."
This statistic ranges from 
<img src="https://render.githubusercontent.com/render/math?math=r^2 = 1">, 
for a model that fits the data perfectly,
to 
<img src="https://render.githubusercontent.com/render/math?math=r^2 = 0">, 
if the dependent variable 
<img src="https://render.githubusercontent.com/render/math?math=Y_i">
is unrelated to the explanatory variable
<img src="https://render.githubusercontent.com/render/math?math=X_i">.
This statistic is shown in the regression output under the headings
```Multiple R-squared``` and ```Adjusted R-squared```.
The ```Adjusted R-squared``` includes an adjustment, or penalty, to account for the number of variables in the model, because
the ```Multiple R-squared``` can only be improved by including more variables in the model. 

<img src="Images/Linear_regression.png">


## Logistic Regression

When the variable takes the form of a binary variable, i.e., it takes on only two values, say, 0 and 1, the linear regression model is not appropriate. 
The logistic regression model uses the logistic transformation to produce an estimate of the probability that 
<img src="https://render.githubusercontent.com/render/math?math=Y_i = 1">.

### The Logistic Equation

The logistic equation also implies that the data are a transformation of a linear equation in
<img src="https://render.githubusercontent.com/render/math?math=X_i">
by applying the *logit* transformation:

<img src="Images/Logistic_Regression_Equation.gif">

### Comparison with Linear Probability Model


The prediction from a linear regression is called the *linear probability model* when it is used to predict binary events. 
Compared to the linear probability model, the logisti regression produces estimates of the probabilities that are constrained to lie between zero and one, as they should. 
In contrast, the predictions from the linear probability model will be greater than one and lower than zero for some values of 
<img src="https://render.githubusercontent.com/render/math?math=X_i">.

<img src="Images/Logistic_vs_OLS_Regression.png">



### Estimating a Logistic Regression in R

Estimating a logistic regression in R involves the same three steps as
for a linear regression model.
1. Reading in the data.
1. Specifying the regression equation.
1. Calculating the statistics for the regression model.

As above, you can read in the data with the ```read.table``` or the ```read.csv``` function. 

```
my_data <- read.csv('path_to_my_data/name_of_data_set_file.csv')
```

Again, you then specify a ```formula``` object. 
This is dfined by a set of notation to specify the names of the dependent variables and explanatory variables. 
As above, the formula takes the form 
```
Y ~ X_1 + X_2 + X_3
```
which will estimate a logistic regression using ```X_1```, ```X_2``` and ```X_3```
to predict ```Y```. 


Then pass these two arguments to the ```glm``` function, where the 
```g``` denotes the *Generalized Linear Model*. 
```
my_logit_model <- glm(data = my_data, formula = Y ~ X_1 + X_2 + X_3, family = 'binomial')
```

The additional argument ```family = 'binomial'``` is used to specify the particular model within the ```glm``` famil of models. 
For a logistic regression, with binary outcomes, you select the ```binomial``` model as the ```family```.

The results of the regression are stored in the ```glm``` object ```my_logit_model```. 
As with a linear regression, you can print out the regression results by summarizing the ```lm``` model object ```my_lm_model``` that was created by the ```lm``` function.


```
summary(my_logit_model)
```


### The Fit of a Logistic Regression Model

Another method is used to measure the quality of fit of a logistic regression model. 
A statistic called the *Area under the ROC Curve* is appropriate for this. 
The *AUROC* is interpreted as the probability that any pair of predictions is correctly ordered, when one observation is drawn from 
<img src="https://render.githubusercontent.com/render/math?math=Y_i = 0">
and one is drawn from
<img src="https://render.githubusercontent.com/render/math?math=Y_i = 1">, 
where "correctly ordered" means that the prediction for the probability that
<img src="https://render.githubusercontent.com/render/math?math=Y_i = 1">
is higher than the prediction for the probability that
<img src="https://render.githubusercontent.com/render/math?math=Y_i = 0">.

Although it is quite commonly used in industry, 
this statistic is not automatically printed out with the ```glm``` model output. 
You can calculate it separately as follows. 

```
roc(response = my_data[, 'Y'], 
    predictor = my_data[, 'my_predictions'])
```

But first, in order to do this, you will need to create predictions from the model and store it in a variable, possibly in the same dataset. 
```
my_data[, 'my_predictions'] <- predict(my_logit_model, type = 'response')
```


Note that to perform this calculation by calling the ```roc``` function, you need to install and attach the ```pROC``` package:

```
install.packages("pROC')
library(pROC)
```

You only need to ```install.packages``` the first time you use this library, 
from then on, the function in this package can be used by calling the ```library``` function, just like the ```import``` function does for modules in Python. 
