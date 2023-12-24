setwd("Semester 2 - Introduction to Data Science")
kc <- read.csv("kc_house2.csv")
kc_second <- kc
View(kc_second)
head(kc_second)
str(kc_second)
Y#The overall visualization of data correlated to one another
plot(kc_second)
library(corrplot)
corrplot(kc_second)

#Question 1 - Data Visualisation
#Segmentation
kc_second$price_cat <-ifelse(kc_second$price_cat == "high", 1 , 0)
par(mfrow = c(3,2))
plot(price_cat ~ bathrooms + sqft_living + sqft_lot + sqft_living15 + sqft_lot15,
     data = kc_second)

#fitting model testing:
par(mfrow= c(2,2))
plot(glm(price_cat ~. , family = binomial, data = kc_second))
#-


#histogram of number of bedrooms correlated to price_Cat
par(mfrow= c(2,1))
hist(kc_second$bedrooms[kc_second$price_cat == 1],
     main = "Correlating number of bedroom when price_cat is high",
     xlab = "Number of bedrooms")
hist(kc_second$bedrooms[kc_second$price_cat == 0],
     main = "Correlating number of bedrooms when price_cat is low",
     xlab = "number of bedrooms")

#histogram of floors correlated to price_cat
par(mfrow= c(2,1))
hist(kc_second$floors[kc_second$price_cat == 1],
     main = "Number of floors when price_cat is high",
     xlab = "Number of floors")
hist(kc_second$floors[kc_second$price_cat == 0], 
     main = "Numbers of floors when price_cat is low",
     xlab = "NUmber of floors")

#histogram of waterfronts correlated to price_Cat 
#should i try the PCA with clustering?
par(mfrow= c(2,1))
hist(kc_second$waterfront[kc_second$price_cat == 1],
     main = "Number of waterfronts when price_cat is high",
     xlab = "Number of waterfronts")
hist(kc_second$waterfront[kc_second$price_cat == 0],
     main = "Number of floors when price_cat is low",
     xlab = "Number of waterfronts")



#--------------------------------
#Question 2 - Principal Component Analysis
#a/
sapply(kc_second[,c(-1,-10)], mean)
#Calculating variance
sapply(kc_second[,c(-1,-10)], var)
#we see sqft_lot and sqft_lot15 is distinctive to other variables as theirs
# mean are higher and variance is much more bigger than other variables
# -> therefore, scaling is needed to generalise and enclose data.


#b/
PCA_scaled <- prcomp(kc_second[,2:10], scale. = TRUE)

#component loadings of each variables
PCA_scaled$rotation

screeplot(PCA_scaled, xlab = "Principle Components", 
          main = "Screeplot of scaled kc_second data")



#c/ 
summary_PCA <- summary(PCA_scaled)
summary_PCA

screeplot(PCA_scaled, xlab = "Principle Components", 
          main = "Screeplot of scaled kc_second data")
#* The first PC1 explained 38% of the variance in the original data
#* The second PC2 explained 17% of the variation in the data set
#* The third PC3 explained 12% of the variation in the data set
#* These are the main components in explaining most of the dispersion in the 
#* data set 
  

#d/
PCA_scaled$rotation

#*Formula in terms of the original variables in the given dataset
#* PC1 = - 0.3609277 x bedrooms   - 0.4597545 x bathrooms 
#*       - 0.4822084 x sqft_living 
#*       + 0.1122122 x sqft_lot   - 0.2661610 x floors 
#*       + 0.0139074 x waterfront - 0.4083281 x sqft_living15 
#*       + 0.1329041 x sqft_lot15 - 0.3972531 x price_cat

#* PC2 = - 0.14452606 x bedrooms   - 0.10765695 x bathrooms 
#*       - 0.10561844 x sqft_living 
#*       + 0.69106266 x sqft_lot   - 0.04579729 x floors 
#*       + 0.02199295 x waterfront - 0.04163799 x sqft_living15 
#*       - 0.68803886 x sqft_lot15  - 0.3972531 x price_cat



#e/
par(mfrow = c(1,1))
PCA_scaled$rotation <- -PCA_scaled$rotation
PCA_scaled$x <- -PCA_scaled$x
biplot(PCA_scaled, scale = 0, col = c(1,2) + 8, lwd = 2)






#------------------------------
str(kc_second)
#Question 3 - Clustering
#a/
kc_third <- kc_second[,c(-1)]
kc_third

set.seed(1)
kc_third_km <- kmeans(kc_third, centers = 2)
pr_kc_third <- prcomp(kc_third, scale = TRUE)

#b/
par(mfrow=c(1,1))
plot(-pr_kc_third$x[,1:2], 
     col = ifelse(kc_third_km$cluster == 1, "green", "red"),
     lwd = 2, 
     main = "K-Means Clustering with K = 2")
  legend(x = "topright", box.col = "black",
       bg = "lightblue", title = "Annotations",
       legend = c("PC1", "PC2"),
       fill = c("green", "red"))


#c/
hh <- hclust(dist(kc_third), method = "complete")
hh
cutree(hh, k = 2)

#d/
hh2 <- hclust(dist(kc_third), method = "average")
hh2
cutree(hh2, k = 2)

#e/
hh3 <- hclust(dist(kc_third), method = "single")
hh3
cutree(hh3, k = 2)


#f/
par(mfrow = c(2,2))
plot(-pr_kc_third$x[,1:2], 
     col = ifelse(kc_third_km$cluster == 1, "green", "red"),
     lwd = 2, 
     main = "K-Means Clustering with K = 2")
plot(-pr_kc_third$x[,1:2], col = ifelse(cutree(hh, k=2) == 1, "red", "green"), lwd = 2)
plot(-pr_kc_third$x[,1:2], col = ifelse(cutree(hh2, k=2) == 1, "red", "green"), lwd = 2)
plot(-pr_kc_third$x[,1:2], col = ifelse(cutree(hh3, k=2) == 1, "red", "green"), lwd = 2)


cutree(hh, k = 2)
cutree(hh2, k = 2)
cutree(hh3, k = 2)

table(actual = kc_third$price_cat,cluster= a)

#----------------------------
#Question 4 -Support Vector Machines
str(kc_second)

#a/ 
set.seed(1)
kc_second$price_cat <- ifelse(kc_second$price_cat == 1, "high", "low")
s <- sample(1:nrow(kc_thrid), 255) #340 * 75% = 255
train_set <- kc_second[s,] #75% of data
train_set
test_set <- kc_second[-s,] #the other 25% of data 
test_set



#b/
#CV with linear basis kernel
library(e1071)
svm1 <- svm(as.factor(price_cat) ~ 
            bedrooms + bathrooms + sqft_living + sqft_lot + floors
            + waterfront + sqft_living15 + sqft_lot15,
            data= train_set,
            kernel = "linear", 
            cost = 1,
            scale = TRUE)
summary(svm1)



set.seed(1)
tune1 <- tune(svm, as.factor(price_cat) ~
                   bedrooms + bathrooms + sqft_living + sqft_lot + floors
                   + waterfront + sqft_living15 + sqft_lot15,
                   data = train_set,
                   kernel = "linear",
                   ranges = list(cost = c(0.001,0.01,0.1,1,10,100,100)),
                   scale = TRUE)

summary(tune1)


bestmod1 <- tune1$best.model
summary(bestmod1)


#Misclassification rate of test set for model 1
test_pred1 <- predict(tune1$best.model, newdata= test_set)
misclass_table1 <- table(test_pred1, test_set[,"price_cat"])
mis_rate1 <- (misclass_table1[1,2] + misclass_table1[2,1])/sum(misclass_table1)
mis_rate1






#c/
#CV with polynomial basis kernel
svm2 <- svm(as.factor(price_cat) ~ 
              bedrooms + bathrooms + sqft_living + sqft_lot + floors
            + waterfront + sqft_living15 + sqft_lot15,
            data= train_set,
            kernel = "polynomial", 
            cost = 1,
            scale = TRUE)
summary(svm2)


set.seed(1)
tune2 <- tune(svm, as.factor(price_cat) ~
                bedrooms + bathrooms + sqft_living + sqft_lot + floors
              + waterfront + sqft_living15 + sqft_lot15,
              data = train_set,
              kernel = "polynomial",
              ranges = list(cost = c(0.001,0.01,0.1,1,10,100,100)),
              scale = TRUE)

summary(tune2)


bestmod2 <- tune2$best.model
summary(bestmod2)


#Misclassification rate of test set for model 2
test_pred2 <- predict(tune2$best.model, newdata= test_set)
misclass_table2 <- table(test_pred2, test_set[,"price_cat"])
mis_rate2 <- (misclass_table2[1,2] + misclass_table2[2,1])/sum(misclass_table2)
mis_rate2



#d/
#CV with radial basis kernel
svm3 <- svm(as.factor(price_cat) ~ 
              bedrooms + bathrooms + sqft_living + sqft_lot + floors
            + waterfront + sqft_living15 + sqft_lot15,
            data= train_set,
            kernel = "radial", 
            cost = 1,
            scale = TRUE)
summary(svm3)


set.seed(1)
tune3 <- tune(svm, as.factor(price_cat) ~
                bedrooms + bathrooms + sqft_living + sqft_lot + floors
              + waterfront + sqft_living15 + sqft_lot15,
              data = train_set,
              kernel = "radial",
              ranges = list(cost = c(0.001,0.01,0.1,1,10,100,100)),
              scale = TRUE)

summary(tune3)


bestmod3 <- tune3$best.model
summary(bestmod3)

#Misclassification rate of test set for model 3
test_pred3 <- predict(tune3$best.model, newdata= test_set)
misclass_table3 <- table(test_pred3, test_set[,"price_cat"])
mis_rate3 <- (misclass_table3[1,2] + misclass_table3[2,1])/sum(misclass_table3)
mis_rate3



misclass_table1
misclass_table2
misclass_table3

mis_rate1
mis_rate2
mis_rate3

