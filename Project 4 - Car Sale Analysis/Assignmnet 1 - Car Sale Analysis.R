  # Question 1.1
vehicles= read.csv("light_vehicles.csv")
head(vehicles)
#                               Question 1.1 (Test if the mean number of cylinder is different between Mazda and Isuzu vehicles)
#T.test computically
#h0: There is no difference between number of cylinders of Mazda and Isuzu
#hA: There is a difference between number of cylinders of Mazda and Isuzu
#data pulled
vehicles.Isuzu=subset(vehicles, Make=="Isuzu", Number.of.cylinders, drop=TRUE)
mean(vehicles.Isuzu) #mean of vehicle Isuzu
vehicles.Mazda= subset(vehicles, Make=="Mazda", Number.of.cylinders, drop=TRUE)
mean(vehicles.Mazda) #mean of vehicle Mazda
label=c("Isuzu", "Mazda")
boxplot(vehicles.Isuzu, vehicles.Mazda, names=label)
?boxplot
vehicles.t.test=t.test(vehicles.Isuzu,vehicles.Mazda, var.equal=TRUE, alternative="two.sided")
vehicles.t.test$p.value
#p value is less than 5%
#since p-value is small, reject h0. 
#hA:There is a difference in mean N.cylinder of Isuzu and Mazda

#Since the sample size is small, We can create sample to test assure the quantile interval:
#from statistics
sim= replicate(1000, {
  Isuzu.resamp= sample(vehicles.Isuzu, replace=TRUE)
  Mazda.resamp= sample(vehicles.Mazda, replace=TRUE)
  t.test(Isuzu.resamp, Mazda.resamp, var.equal=TRUE)$statistic
})
hist(sim, breaks=20, main= "Mean differences in number of Cylinders between Isuzu and Mazda")
quantile(sim, c(0.05, 0.95)) 
quantile (sim, 0.50) #highest frequency of mean differences 
abline(v=quantile(sim, c(0.05, 0.95)), col=6)
##In fact, from the graph alone, we can see the mean differences in number of cylinders between Isuzu and
#Mazda is already centralised at approximate -3.58, this means almost total records certainly shows
#Mazda has almost 4 more numbers of cylinders than Isuzu
#We are 95% confident that the mean difference in number of Cylinders between Isuzu and Mazda is between -5.5 to -2






# Question 1.2
#               Question 1.2
#Test if the mean number of seats is different for each colour. If so, determine which colour has a statistically different mean
#t.test compares differences in mean between two groups
#since populations is large we dont need sample simulation
F.test=oneway.test(vehicles$Number.of.seats~vehicles$Colour, data=vehicles)
F.test #since p. value is large and is F-statistics is small, shows there is not much of  a difference in groups means
fit=aov(vehicles$Number.of.seats~vehicles$Colour, data=vehicles)
fit
summary(fit)
Tukey.test=TukeyHSD(fit)
par(mar=c(5.1,10,4.1,2.1), cex=0.8)
plot(TukeyHSD(fit), las=1)
#there are statistically different in mean levels between White-Black (from TUkeyHSD test, we can see a white
#has one more seat than Black vehicles and there is a prob of approx 85% that would happen)
#and Red-Black (from TukeyHSD test, we can see red has one more seat than Black vehicles and there is a prob of 59% that would happen)











# Question 1.3
#               Question 1.3
#Use Bootstraping to compute a 88% confidence interval for the difference between GVM and TareWeights for Volkswagen vehicles?
#Compute a 88% cI for the difference between GVM and Tare weights for Volkswagen vehicle by using approximation.
#Can we conclude that GVM weights are different than Tare weights for Volkswagen vehicles (Dont do a hypothesis test)?
#Test the hypothesis that GVM weights are greater than Tare weights for Volkswagen vehicles

#since there is not much record on VOlkswagen's properties, we need to simulate boot to approximate data:
#this is evidence on lack of Volkswagen data:
count.Volkswagen.GVM.weight= length(subset(vehicles, Make=="Volkswagen", GVM.weight, drop=TRUE))
count.Volkswagen.GVM.weight
count.Volkswagen.Tare.weight= length(subset(vehicles, Make=="Volkswagen", Tare.weight, drop=TRUE))
count.Volkswagen.Tare.weight


Volkswagen.GVM= subset(vehicles, Make=="Volkswagen", GVM.weight, drop=TRUE)
Volkswagen.GVM
Volkswagen.Tare= subset(vehicles, Make=="Volkswagen", Tare.weight, drop=TRUE)
Volkswagen.Tare
d0= mean(Volkswagen.GVM-Volkswagen.Tare)
d0
boot= replicate(10000, {
  Volkswagen.GVM.sampled= sample(Volkswagen.GVM, replace=TRUE)
  Volkswagen.Tare.sampled= sample(Volkswagen.Tare, replace=TRUE)
  mean(Volkswagen.GVM.sampled-Volkswagen.Tare.sampled)
})
hist(boot, breaks=20)
quantile(boot, c(0.06, 0.94))
abline(v=quantile(boot, c(0.06, 0.94)), col=6)
#or using wilcox.test #dont do hypothesis test
CI_88_approx=wilcox.test(Volkswagen.GVM,Volkswagen.Tare, conf.int= TRUE, conf.level=0.88)
CI_88_approx
CI_88_approx$conf.int #shows the approximate conf level of 88%CI 
#Yes, we can 88% conclude that GVM weights are different than Tare weights of Volkswagen vehicles since 88% of data
#lied between approximate 347 and 1480 (observed from wilcox test and from graph data) and a very small percentage lying on 0
#which means the difference is zero between GVM and Tare weight for Volkswagen


##Use Wilcoxon-Mann Whitney test to find if GVMweight are greater than TareWeights for Volkswagen
#h0: GVM.weight is not greater to Tare.Weights
#hA; GVM.weight is greater than Tare.weights
wilcox.test(Volkswagen.GVM, Volkswagen.Tare, alternative="greater")
boxplot(Volkswagen.GVM,Volkswagen.Tare) #Observation from boxplot
#since p-value is small, therefore reject the null hypothesis
#hA: GVM.weight is greater than Tare.weights







# Question 1.4
#             Question 1.4
vehicles
vehicles$Make[vehicles$Make=="Land"]

a=length(subset(vehicles, Make=="Landrover", Colour, drop=TRUE))
b=length(subset(vehicles,Make=="Mercedes", Colour, drop=TRUE))
Colour.vehicles.table=table(vehicles$Make[vehicles$Colour=="Silver"])
Colour.vehicles.table
Silver.Landrover=Colour.vehicles.table[7]
Silver.Landrover
Silver.Mercedes=Colour.vehicles.table[9]
Silver.Mercedes
diff.proportion=(Silver.Landrover/a) - (Silver.Mercedes/b)
diff.proportion
#Therefore, the difference in proportion between Silver Landrover and Mercedes would be 3 out of 60 recorded Silver vehicles or `r diff.proportion`


chisq.test(vehicles$Make[vehicles$Make=="Landrover"], vehicles$Colour[vehicles$Make=="Landrover"])





# Question 1.5

#             Question 1.5
min(vehicles$Year)
max(vehicles$Year)
2021-1985

#plotting the mean in N.cylinders depended on registration year
mean.calculated=tapply(vehicles$Number.of.cylinders,vehicles$Year, mean)
mean.calculated#this calculate the mean of cylinders of vehicles which has the same registration year
year.registrated= c(1985:2021)
plot(y=mean.calculated, x=year.registrated) #mean number of cylinders against the registration year
abline(lm(mean.calculated~year.registrated))# there seems to have a down trend pattern but very weak correlation coefficient
fittest=lm(mean.calculated~year.registrated) #summarise linear model of the mean number of cylinder and the registration year
#if so, compute the equation to predict mean number of cylinders by using the 
#registration year and discuss the significance of this equation? what is your
#estimate of the population mean number of cylinders when the year is 1984?
#final equation would be:
fittest
m= fittest[[1]][2]
m #Coefficient
b=fittest[[1]][1]
b #intercept
x=1990
y=m*x+b #therefore y is the fittest number of cylinder in the chosen registration year
# y = -0.04991196*x +107.0101 is the new equation to find the number of cylinder 
#depending on registration year.

