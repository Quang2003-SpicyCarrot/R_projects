library(RedditExtractoR)
library(kableExtra)
library(tm)
library(wordcloud)
library(ggplot2)

setwd("~/WSU RStudio/Year 2/Semester 2 - Social Web Analytics/Assignment1")
# Question 1 --------------------------------------------------------------
#Part 1:
#tesla_thread_url <- find_thread_urls(keywords = 'tesla', sort_by = 'comments', period = 'month')
#saveRDS(tesla_thread_url, 'tesla_threads.RDS')
tesla_threads <- readRDS('tesla_threads.RDS')
tesla_threads2 <- readRDS('tesla_gaming.RDS')



#Part 2:
highest_comments <- order(tesla_threads$comments, decreasing = TRUE)[1:3]
thread_highest_comments <- tesla_threads[highest_comments,]

View(tesla_threads)

#Part 3:
#thread_contents1 <- get_thread_content(thread_highest_comments$url[1]) #type = list
#thread_contents2 <- get_thread_content(thread_highest_comments$url[2])
#thread_contents3 <- get_thread_content(thread_highest_comments$url[3])
#saveRDS(thread_contents1, 'thread_contents1.RDS')
#saveRDS(thread_contents2, 'thread_contents2.RDS')
#saveRDS(thread_contents3, 'thread_contents3.RDS')

thread_contents1 <- readRDS('thread_contents1.RDS')
thread_contents2 <- readRDS('thread_contents2.RDS')
thread_contents3 <- readRDS('thread_contents3.RDS')


#[[
#create a term-document matrix for thread #1 
thread_contents1$threads$url

corpus <- Corpus(VectorSource(thread_contents1$comments$comment)) #convert it to the standard ASCII, it will drop document
corpus <- tm_map(corpus, function(x) iconv(x, to = 'ASCII'))

#tdm
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))


empties <- which(colSums(as.matrix(tdm)) == 0)
tdm <- tdm[,-empties] #remove empty columns
tdm
M <- as.matrix(tdm)
freqs <- rowSums(M)


#Create a word cloud for thread #1
names(freqs)
wordcloud(names(freqs), freqs, random.order = FALSE)
View(freqs[order(freqs, decreasing = TRUE)]) #check the most frequent words


set.seed(1)
#Create a TF-IDF Word Cloud for thread #1
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))
tdmw <- weightTfIdf(tdm)
T <- as.matrix(tdmw)
View(T)
freqsw <- rowSums(T)
names(freqsw)

##Remove words that have 'NA'.
freqsw <- freqsw[!is.na(freqsw)]
wordcloud(names(freqsw), freqsw, random.order = FALSE) #word cloud
freqsw[which(names(freqsw) == 'tesla')]
View(freqsw[order(freqsw, decreasing = TRUE)]) #check the most frequent words
#]]


#[[
#create a term-document matrix for thread #2 
thread_contents2$threads$url

corpus <- Corpus(VectorSource(thread_contents2$comments$comment))
corpus <- tm_map(corpus, function(x) iconv(x, to = 'ASCII')) #convert it to the standard ASCII, it will drop document

set.seed(1)
#tdm
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))


empties <- which(colSums(as.matrix(tdm)) == 0)
tdm <- tdm[,-empties] #remove empty columns
M <- as.matrix(tdm)
freqs <- rowSums(M)


#Create a word cloud for thread #2
wordcloud(names(freqs), freqs, random.order = FALSE, max.words = 200)
View(freqs[order(freqs, decreasing = TRUE)]) #check the most frequent words


set.seed(1)
#Create a weighted TF-IDF Word Cloud for thread #2
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))
tdmw <- weightTfIdf(tdm)
T <- as.matrix(tdmw)
View(T)
freqsw <- rowSums(T)
names(freqsw)

##Remove words that have 'NA'.
freqsw <- freqsw[!is.na(freqsw)]
wordcloud(names(freqsw), freqsw, random.order = FALSE) #word cloud
freqsw[which(names(freqsw) == 'tesla')]
View(freqsw[order(freqsw, decreasing = TRUE)]) #check the most frequent words
#]]

#[[
#create a term-document matrix for thread #3 
thread_contents3$threads$url

corpus <- Corpus(VectorSource(thread_contents3$comments$comment))
corpus <- tm_map(corpus, function(x) iconv(x, to = 'ASCII')) #convert it to the standard ASCII, it will drop document

set.seed(1)
#tdm
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))


empties <- which(colSums(as.matrix(tdm)) == 0)
tdm <- tdm[,-empties] #remove empty columns
M <- as.matrix(tdm)
freqs <- rowSums(M)


#Create a word cloud for thread #3
wordcloud(names(freqs), freqs, random.order = FALSE, max.words = 200)
View(freqs[order(freqs, decreasing = TRUE)]) #check the most frequent words


set.seed(1)
#Create a TF-IDF Word Cloud for thread #3
tdm <- TermDocumentMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         removeNumbers = TRUE,
                                         tolower = TRUE,
                                         stemming = TRUE))
tdmw <- weightTfIdf(tdm)
T <- as.matrix(tdmw)
View(T)
freqsw <- rowSums(T)
names(freqsw)

##Remove words that have 'NA'.
freqsw <- freqsw[!is.na(freqsw)]
wordcloud(names(freqsw), freqsw, random.order = FALSE) #word cloud
View(freqsw[order(freqsw, decreasing = TRUE)]) #check the most frequent words
#]]




# Question 2  -------------------------------------------------------------
full_thread_content <- rbind(thread_contents1$comments, thread_contents2$comments, thread_contents3$comments) #as they are dataframe,
View(full_thread_content)
#we can row bind them
full_thread_content$thread_number[full_thread_content$url == thread_contents1$threads$url] <- 1
full_thread_content$thread_number[full_thread_content$url == thread_contents2$threads$url] <- 2
full_thread_content$thread_number[full_thread_content$url == thread_contents3$threads$url] <- 3
full_thread_content$thread_number <- as.numeric(full_thread_content$thread_number)

str(full_thread_content)
sapply(full_thread_content, class)

mat.full_thread_content <- data.matrix(full_thread_content[,c(-1,-11)])
#column as we already have the column 'thread_number' that represents the thread number
str(mat.full_thread_content)

View(mat.full_thread_content)

#normalisation

##then create the distance matrix
D <- dist(mat.full_thread_content, method = 'euclidean')


#perform MDS using 100 dims
mds.full_thread_content <- cmdscale(D, k = 2)

SSW <- rep(0, 15)
for (a in 1:15) {
  K <- kmeans(mds.full_thread_content, a, nstart = 20)
  SSW[a] <- K$tot.withinss
}
#plot results
plot(1:15, SSW, type = 'b')

#perform K means
set.seed(1)
K <- kmeans(x = mds.full_thread_content, 2 , nstart = 10) # we want k-means to be three but in this case its 2
K$totss
K$betweenss


#visualise the clusters
mds2.full_thread_content <- cmdscale(D)

plot(mds2.full_thread_content, col = K$cluster, pch = full_thread_content$thread_number)
View(mds2.full_thread_content)
#confusion matrix
cm <- table(full_thread_content$thread_number, K$cluster)
cm #cluster 1 is pretty good, cluster 2 is okay, cluster 3 is good too
#hence using k-means clustering is effective at identifying threads






# Question 3 --------------------------------------------------------------
full_thread_content <- tesla_threads
full_thread_content$date_utc <- as.Date(full_thread_content$date_utc)
sapply(full_thread_content, class)
View(full_thread_content)
boxplot(comments ~ date_utc, data = full_thread_content)

#did you add sqrt, log to account for the innormal distributed
cor(as.numeric(full_thread_content$date_utc), full_thread_content$comments) #very small negative cor value 

lin_reg <- lm(comments ~ date_utc, data = full_thread_content)
summary(lin_reg)
plot(comments ~ date_utc, data = full_thread_content)
par(mfrow = c(2,2))
plot(lin_reg)
#p.val is large, 
#do not reject the null hypothesis, there is not enough evidence to support the correlation between date and number of comment





# Question 4 --------------------------------------------------------------
View(thread_contents1)
View(thread_contents1$comments)
thread1_comments <- thread_contents1$comments
thread1_comments$date <- as.Date(thread1_comments$date)
thread1_mat <- table(thread1_comments$date)
thread1_mat
thread1_mat[1] - thread1_mat[2]

#chisq test one way table
ex <- chisq.test(thread1_mat, p = c(1/2, 1/2), B = 2000)
ex$observed
ex$expected
ex


x# QUESTION 5: Using Mastodon ----------------------------------------------
library(rtoot)
vignette('rtoot') #show a specific package instruction

auth_setup('mastodon.social', 'user')
#a <- get_timeline_hashtag(hashtag = 'tesla', instance = 'mastodon.social', local = TRUE)
#saveRDS(a, 'Mastodon_timeline.RDS')
a <- readRDS('Mastodon_timeline.RDS')
View(a)


#five most active users based on the highest number of statuses they have posted
tesla_active_users <- do.call(rbind, a$account)
tesla_active_users <- tesla_active_users[(order(tesla_active_users$statuses_count, decreasing = TRUE)[1:5]),]
View(tesla_active_users)


#Download 50 followers and 50 friends of these top 5 users ++
#create a list of friends
#n <- length(tesla_active_users$id)
#user_friends <- list(NA)
#for (i in 1:n) {
#  friends <- get_account_following(tesla_active_users$id[i], limit = 50)
#  user_friends[[i]] <- friends$username
#}
#saveRDS(user_friends, 'user_friends.RDS')
user_friends <- readRDS('user_friends.RDS')

user_friends_graph <- list(NA)
for (i in 1:length(user_friends)) {
  name_rep <- rep(tesla_active_users$username[i], length(user_friends[[i]]))
  user_friends_graph[[i]] <- cbind(name_rep, user_friends[[i]])
}

user_friends_graph <- do.call(rbind, user_friends_graph)
user_friends_graph
dim(user_friends_graph)



#create a list of followers
n <- length(tesla_active_users$id)
n
#users_followers <- list(NA)
#for (i in 1:n) {
#  followers <- get_account_followers(tesla_active_users$id[i], limit = 50)
#  users_followers[[i]] <- followers$username
#}
#saveRDS(users_followers, 'users_followers.RDS')


users_followers <- readRDS('users_followers.RDS')

user_followers_graph <- list(NA)
for (i in 1:length(users_followers)) {
  name_rep <- rep(tesla_active_users$username[i], length(users_followers[[i]]))
  user_followers_graph[[i]] <- cbind(name_rep, users_followers[[i]])
}

user_followers_graph <- do.call(rbind, user_followers_graph)
user_followers_graph <- user_followers_graph[,c(2,1)]
dim(user_followers_graph)
View(user_followers_graph)



#combine friends and followers into a big relationship
friend_followers <- rbind(user_friends_graph, user_followers_graph)



#plot these relationships
library(igraph)
g1 <- graph_from_edgelist(friend_followers, directed = TRUE)
plot(g1, layout = layout.fruchterman.reingold, vertex.size = 3, edge.arrow.size = 0.4, vertex.color = 'red')
View(friend_followers)






# Question 6: Centrality --------------------------------------------------
sort(1/closeness(g1), decreasing = TRUE)[1:10]
sort(degree(g1), decreasing = TRUE)[1:10]
sort(betweenness(g1), decreasing = TRUE)[1:10]
centralIDs <- order(betweenness(g1), decreasing = TRUE)[1:5]
V(g1)[centralIDs]
#kristen_d


#-----
x <- matrix(c(2,3,5,
              3,4,3,
              4,6,9), byrow = TRUE, nrow = 3)
x
dist(x, method = 'euclidean')^2/2
cmdscale(dist(x), 2)



topic <- matrix(c(27, 473,
                17, 483), byrow = TRUE, nrow = 2)

topic1 <- chisq.test(topic, p = c(), B = 2000)
topic1$statistic









#--------------testing
library(tm)
library(SnowballC)
View(full_thread_content)
red.corpus <- Corpus(VectorSource(full_thread_content$comment))
red.corpus <- tm_map(red.corpus, function(x) iconv(x, to = 'UTF-8', sub = 'byte'))
corpus = tm_map(red.corpus, function(x) iconv(x, to='ASCII', sub=' ')) # remove special characters
corpus = tm_map(corpus, removeNumbers) # remove numbers
corpus = tm_map(corpus, removePunctuation) # remove punctuation
corpus = tm_map(corpus, stripWhitespace) # remove whitespace
corpus = tm_map(corpus, tolower) # convert all to lowercase
corpus = tm_map(corpus, removeWords, stopwords()) # remove stopwords
corpus = tm_map(corpus, stemDocument) # convert all words to their stems
inspect(corpus[1:5])


red.tdm <- TermDocumentMatrix(corpus)
red.tdm <- weightTfIdf(red.tdm)
red.tdm <- t(as.matrix(red.tdm))
red.tdm <- cbind(red.tdm,full_thread_content$thread_number)
red.tdm_nothread <- red.tdm[,-ncol(red.tdm)]

#remove empty 
empties <- which(rowSums(abs(red.tdm_nothread)) == 0)
red.mat <- red.tdm[-empties,]
red.tdm_nothread <- red.tdm_nothread[-empties,]


#normalise
norm.red.mat <- diag(1/sqrt(rowSums(red.tdm_nothread^2))) %*% red.tdm_nothread

D <- dist(norm.red.mat, method = 'euclidean')^2/2
red.mds <- cmdscale(D)
red.kmeans <- kmeans(red.mds, 3, nstart = 2)

plot(red.mds, col = red.kmeans$cluster, pch = red.tdm[,4071])
table(red.tdm[,4071],red.kmeans$cluster)
