by Quang Dong Nguyen  
provided by: Western Sydney University

# Topic: Construct statistical models in R using both Regression and Classification models to compare the price of house in the US  
## Regression (Part i)
1. Construct the matrix plot and correlation matrix (consider only relevant variables).Comment on the relationship among variable


### Question 2 - Simple Linear Regression
1. Fit a model to predict price in terms of sqft_living
2. Discuss the significance of the slope parameter estimate. Write down the relevant hypothesis
3. Discuss the accuracy of the parameter estimates (Standard errors / confidence internvals)
4. Discuss the model accuracy (R-square, residual standard error, etc).
5. Check for the model assumptions
6. Write down the model equation
7. Predict the price of a house with 10,000 sqft of the apartments interior living space (sqft_living)


### Question 3 - Multiple Linear Regression
1. Fit a model to predict price interms of all the other quantitative predictors (numerical predictors)
2. Remove the insignificant variables and fit a model including the rest of the variables
3. Add the Interaction term `bedroom*floors` to the model above (part iii)
4. Comment on the significance of the parameter estimates of the model above (part iii)
5. Check for the model assumptions (model in part iii)
6. Compare and comment on the accuracy of the models in part ii and part iii. Suggest the best model
7. Fit a polynomial regression model to predict price using sqft_living of order 2 and test the model significance


## Classification (Part ii)
Use the same dataset we perform:

### Question 1 - Logistic Regression
1. Construct Logistic Regression model for 'price_Cat' in terms of all the other variables (Use training dataset)
2. Comment on the significance of the parameter estimates
3. Improve the model based on the output in part 1. (Hint: Consider the sigificance of the parameter estimates)
4. Predict the outputs for the test dataset using the model in part iii and construct misclassification table.
5. Calculate the misclassification rate (Use test dataset).

### Question 2 - Decision Tree
1. Build a classification tree model for the training dataset
2. Use cross-validation and choose the best size for the tree in part i
3. Build  the tree with best size (pruning obtained in part ii
4. Predict the outputs for the test dataset using the model in part iii and construct misclassification table
5. Calculate the misclassification rate (use test dataset)


## Comparison (Part iii)

### Question 1: Compare the models in part i and part ii and suggest the best model (Give reasons)