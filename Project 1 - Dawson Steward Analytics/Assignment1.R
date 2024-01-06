setwd("C:/Users/Dell/Documents/WSU RStudio/Semester 1 - Analytics Programming/Assignment 1 (40%)")
a <- read.csv("sales_ug.csv")
b <- read.csv("product_hierarchy.csv")
d <- read.csv("store_cities.csv")

View(a)
View(b)
View(d)
library(tidyverse)
library(kableExtra)
library(plotly)

# Section 1: -------------------------------------------------------------
#total revenue of each store at the end of each day
revenue_each_day <- aggregate(revenue ~ store_id + date, data = a, sum)
head(revenue_each_day, 10)


#notice any differences between the days?
tap <- tapply(revenue_each_day$revenue, revenue_each_day$store_id, diff)


#####
tap <- aggregate(revenue ~ store_id, data = revenue_each_day, diff)
plot(unlist(tap$revenue), col = as.factor(tap$store_id))
max(unlist(tap$revenue))
min(unlist(tap$revenue))


plot(unlist(tap$revenue[1]), type = "l")
max(unlist(tap$revenue[1]))
min(unlist(tap$revenue[1]))
################

#total revenue over the seven day period
revenue_seven <- aggregate(revenue ~ store_id, data = a, sum)
revenue_seven
head(revenue_seven)
revenue_seven$store_id[50]

#####
revenue_seven_adv <- revenue_seven %>%
  left_join(d)
ggplot(data = revenue_seven_adv, 
       aes(x = 1:nrow(revenue_seven_adv),
           y = revenue,
          col = as.factor(revenue_seven_adv$storetype_id))) +
  geom_point()

################

#####
#plotting the total revenue over the seven day period
ggplot(revenue_seven, aes(store_id, revenue)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90))

#max revenue gained store
revenue_seven[which(revenue_seven$revenue == max(revenue_seven$revenue)),]

#min revneue gained store:
revenue_seven[which(revenue_seven$revenue == min(revenue_seven$revenue)),]

################
# Section 2: --------------------------------------------------------------
View(b)
#1) most popular product type sold over a week?
head(b)
sort(table(b$hierarchy1_id), decreasing = TRUE) #product named H03 are most popularly sold
ggplot(data = b, aes(hierarchy1_id, )) +
  geom_histogram(stat = "count")

head(a)
head(b)
merged_data_b_r_a<- b %>%
  select("hierarchy1_id", "product_id") %>%
  right_join(a)
table(merged_data_b_r_a$date, merged_data_b_r_a$hierarchy1_id)

#2) how much revenue did the stores receive for that product during the week
#join data from dataset:
merged_ab_tab1 <- b %>% 
  select("product_id", "hierarchy1_id", "hierarchy2_id") %>%
  right_join(a, by = c("product_id" = "product_id"))
View(merged_ab_tab1)



#revenue made
stores_rev_made1 <- merged_ab_tab[which(merged_ab_tab$hierarchy1_id == "H03"),]
aggregate(revenue ~ store_id + date, data = stores_rev_made1, sum) %>%
  head()




#3) How does that compare with the second most popular product?
#second most popular product sold is H00
stores_rev_made2 <- merged_ab_tab[which(merged_ab_tab$hierarchy1_id == "H00"),]
aggregate(revenue ~ store_id + date, data = stores_rev_made2, sum) %>%
  head()

stores_rev_made1 <- aggregate(revenue ~ store_id + date, data = stores_rev_made1, sum)
stores_rev_made2 <- aggregate(revenue ~ store_id + date, data = stores_rev_made2, sum)

nrow(stores_rev_made1) #however some records
nrow(stores_rev_made2)
stores_rev_made1 %>%
  full_join(stores_rev_made2, by = c("store_id", "date")) %>%
  View()

ggplot(stores_rev_made1, aes(x = date, y = revenue)) +
  geom_point() +
  geom_line(group = stores_rev_made1$store_id)

#4) How many subtypes (hierarchy 2) are there for each product type provided.
matx_1 <- table(b$hierarchy1_id, b$hierarchy2_id)
matx_1
#* There are 5 for H00: H0000, H0001, H0002, H0003, H0004
#* There are 4 for H01: H0105, H0106, H0107, H0108
#* There are 2 for H02: H0209, H0311
#* There are 7 for H03: H0311, H0312, H0313, H0314, H0315, H0316, H0317



#5) How many products are in this product type
#according to matx_1


#6) Sales quantity for each product type provided (hierarchy1_id, hierarchy2_id)
#hierarchy1_id:
aggregate(sales ~ hierarchy1_id, data = merged_ab_tab, sum)

#hierarchy2_id:
aggregate(sales~ hierarchy1_id + hierarchy2_id, data = merged_ab_tab, sum)


#7) Revenue generated for each product type provide:
#hierarchy1_id
aggregate(revenue ~ hierarchy1_id, data = merged_ab_tab, sum)

pop <- aggregate(sales ~ hierarchy1_id + hierarchy2_id, data = merged_ab_tab, sum)
pop[order(pop$hierarchy1_id, pop$sales, decreasing = TRUE),]

#hierarchy2_id:
aggregate(revenue ~ hierarchy1_id + hierarchy2_id, data = merged_ab_tab, sum)




# Section 3: -------------------------------------------------------------
#View the dataset d:
View(d)

#1) Compare sales volumes between the two most common store types in the data set
head(d)
#Two most common store types are:
sort(table(d$storetype_id), decreasing = TRUE) #most common store types is ST04


#right join dataset d and a according to the corresponding id:
merged_da_tab <- d %>% 
  select("store_id", "storetype_id", "store_size") %>%
  right_join(a)
merged_da_tab


#sales volume of ST04
aggregate(sales ~ storetype_id, data = merged_da_tab, sum)[4,]

#sales volume of ST03
aggregate(sales ~ storetype_id, data = merged_da_tab, sum)[3,]


#2) How do they compare in term of total revenue?
#ST04
aggregate(revenue ~ storetype_id, data = merged_da_tab, sum)[4,]

#ST03
aggregate(revenue ~ storetype_id, data = merged_da_tab, sum)[3,]


#3) Is there a relationship between a store's size and its revenue?

#hypothesis testing?
#h1: p = 0 
#ha: p != 0
#population data is large, no need to replicate more samples
rev_rel <- aggregate(revenue ~ store_id + store_size, data = merged_da_tab, sum)
cor.test(rev_rel$store_size,rev_rel$revenue,
         alternative = "two.sided",
         method = "pearson")
plot(revenue ~ store_size, data = rev_rel)
summary(lm(revenue~store_size, data = rev_rel))
abline(lm(revenue~store_size, data = rev_rel))
par(mfrow = c(2,2))
plot(lm(revenue~store_size, data = rev_rel))

?cor.test

ggplot(data = rev_rel, aes(x = store_size,
                           y = revenue)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
?geom_smooth()

merged_da_tab_r <- aggregate(revenue ~ store_size, data = merged_da_tab, sum)
merged_da_tab_r
cor(merged_da_tab_r$store_size, merged_da_tab_r$revenue)
ggplot(data = merged_da_tab_r, aes(store_size, revenue)) +
  geom_point() + 
  geom_line() +
  geom_smooth()
?geom_smooth()

summary(glm(revenue ~ store_size, data = merged_da_tab_r))

# Section 4: --------------------------------------------------------------
head(a)
t(table(a$promo_type_1, a$promo_bin_1)) #prom and prom_rate tab
table(a$date, a$promo_type_1) #date and prom tab
table(a$promo_type_1, a$promo_bin_1,a$date)


aggregate(sales ~ promo_type_1, data = a, sum)
ggplot(data = a, aes(x = promo_type_1, y = sales, color = date, group)) +
  geom_jitter() 

x1 <- aggregate(cbind(a$sales, a$revenue),
                by = list(a$promo_type_1, a$date), #aggregated by these variables
                sum) #returns sales and revenue
colnames(x1) <- c("promo_type_1", "date", "sales", "revenue")
x1[order(x1$sales, decreasing = TRUE),]


table(a$promo_type_1, a$date)
table(a$product_id, a$promo_bin_1)



pl1 <- ggplot(data = x1,
              aes(x = date,
                  y = sales,
                  color = promo_type_1)) +
       geom_point() +
       geom_line(group = x1$promo_type_1) +
       coord_trans()

pl1
pl1 +
  coord_cartesian(ylim = c(0,600))
