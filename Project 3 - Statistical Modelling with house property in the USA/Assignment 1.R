kc <- read.csv("kc_house.csv")
View(kc)
head(kc)
str(kc)

#Question 1: 

pairs(price~ bedrooms + bathrooms + sqft_living  + sqft_lot + floors + sqft_living15 +sqft_lot15, data=kc, panel=panel.smooth) 
#pch means scatter shapes


cor(kc[c(2,3,4,5,6,7,9,10)]) #correlation matrix on relevant variables



#Question 2: Simple linear regression
#i/
head(kc)
nrow(kc) #population size is large enough to predict a model
plot(price~sqft_living, data=kc) #there seems to be a linear trend between the
#response variable (price) and the explanatory variable (sqft_living)
model1 <- lm(price~sqft_living, data=kc)


#ii/ 
# H0: There is evidence of linear relationship between the two variables
# HA: There is evidence of a linear relationship between the two variables
cor.test(kc$sqft_living, kc$price, method= "pearson", conf.level=0.95)
#Discussion on the significance of the slope parameter estimate:


#iii/ 
summary(model1)
anova(model1)
#the model is not really appropriate, sum square is large

#confidence intervals:
?confint
confint(model1, level=0.95)
#confidence interval shows variability in its coefficient,ranging from 
#... to ...


#iv/
#check the model accuracy (R-squared, residual standard error, etc)


#v/ Check model assumptions
#plot fitted model
par(mfrow=c(2,2))
plot(model1)
#no constant variance in the first plot, data is fan-out


#Vi/ write down the model equation: E(x) = ...
model1

#vii/
predict(model1, newdata= data.frame(sqft_living = 10)) #sqft_living = 10 because
#measured in thousand



# Question 3
#I/
pairs(kc, panel=panel.smooth)
str(kc)
model3 <- lm(price~ id + bathrooms + sqft_living + sqft_lot + floors + sqft_living15 + sqft_lot15, data= kc)
summary(model3)

#ii/
#remove those with large p-value
model4 <- lm(price~ sqft_living + floors + sqft_living15, data= kc)
summary(model4)


#iii/
model5 <- lm(price~ sqft_living + floors + sqft_living15 + I(bedrooms*floors), data=kc)
summary(model5)

#IV/ comment on the model above

#v/
par(mfrow=c(4,2))
plot(model4)
plot(model5)

#vi/
#seems like model4 is more appropriate than model 5 interaction

# vii/
model6 <- lm(price~ sqft_living + I(sqft_living*sqft_living), data=kc)
summary(model6)





#---------------------------
#QUESTION 2- CLASSIFCATION 
kc <- read.csv("kc_house.csv")
kc_cncat <- kc
attach(kc)
str(kc)
str(kc_cncat)

kc_cncat$price_cat[kc_cncat$price > median(kc_cncat$price)] <- "High"
kc_cncat$price_cat[kc_cncat$price <= median(kc_cncat$price)] <- "Low"
kc_cncat <- subset(kc_cncat, select= -price)
str(kc_cncat$price_cat)

?

#Logistic regression
#i/ use training set
nrow(kc_cncat)
set.seed(100)
training_1 <- sample(1:nrow(kc_cncat), 256) #75% of observations
dim(kc_cncat)

model7<- glm(as.factor(price_cat) ~ . , 
             data=kc_cncat, subset=training_1, 
             family= binomial) #training set
par(mfrow=c(2,2))
plot(model7)
summary(model7)

#ii/ comment on that model7


#iii/ improvement 
model7<- glm(as.factor(price_cat)~ bathrooms + sqft_living + waterfront + sqft_living15 + sqft_lot15 , 
             data=kc_cncat, subset= training_1 ,
             family = binomial)
summary(model7)


#iv/
View(kc_cncat)
pred_prob <- predict(model7, newdata= data.frame(kc_cncat[-training_1]), type = "link")
pred_prob
pred_class <- rep(NA, nrow(kc_cncat[-training_1,]))
pred_class[pred_prob >= 0.5] <- "High"
pred_class[pred_prob < 0.5] <- "Low"
MisClass <- table( "Predicted" = pred_class , "Actual" = kc_cncat$price_cat[-training_1])
MisClass



#v/
#Misclassification Rate Calculation:
Misclass_rate1 <- (MisClass[1,2]+ MisClass[2,1])/ sum(MisClass)
Misclass_rate1



#Question 2: Decision tree:
#i/ 
par(mfrow= c(1,1))
library(tree)
head(kc_cncat)
tree_model1 <- tree(price_cat~. ,data= kc_cncat, subset= training_1) #tree model using training dataset
plot(tree_model1)
text(tree_model1, pretty = 0)

#ii/
cv_tree_model1 <- cv.tree(tree_model1 , FUN = prune.misclass)
names(cv_tree_model1)
cv_tree_model1

plot(cv_tree_model1$size , cv_tree_model1$dev , type = "b")
#therefore, the best model is the cv_tree_model with the size of 60 as it has the greatest
#explanation for the variance in the dev


#iii/ 
prune_tree_model1 <- prune.misclass(tree_model1, best = 5)
plot(prune_tree_model1)
text(prune_tree_model1, pretty = 0)

#iv/ 
?predict
pred_tree_model1 <- predict(prune_tree_model1, newdata= data.frame(kc_cncat[-training_1,]), type = "class")
table("predicted_test" = pred_tree_model1, "actual" = kc_cncat$price_cat[-training_1])          


#v/
tab2 <- table("predicted_test" = pred_tree_model1, "actual" = kc_cncat$price_cat[-training_1])   
Misclass_rate2 <- (tab2[1,2] + tab2[2,1])/sum(tab2)
Misclass_rate2
#lower misclassification rate


