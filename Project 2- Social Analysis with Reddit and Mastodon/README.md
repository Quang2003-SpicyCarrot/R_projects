by: Quang Dong Nguyen, and et.al  
provided by: Western Sydney University

# Project Tasks - Social Web Analysis

To get started, pick a topic that interests you, something you'd like to explore throughout
the entire project.
Make sure each group selects a unique topic, and once you've settled on one, go ahead
and add it to the Group Project Topics.  

If, as you begin working on the project, you find that there aren't many active users or
discussions related to your chosen topic, feel free to change it. Just remember to update
your choice on the topic list when you do

Note that:
- The relevant terminology may differ between Reddit and Mastodon APIs, spending
time reading about APIs and R packages and relevant functions, is expected.  
- Labs featured Reddit and Mastodon APIs are introductory, you are required to
investigate more on the relevant R functions and the data structure.  
- Some research/preparation into downloaded data organisation is required, as data
frames usually contain one or more columns of interest to select and filter on.  

## Question 1:
1. Using Reddit API, identify the relevant thread URL's for your chosen topic. Focus
on either weekly or monthly timeframe.  

2. Find the top three threads with the highest number of comments.  

3. Retrieve and display the main post from from each of these three threads. Generate
a word cloud for the comments and replies within each of these threads, resulting in
a word cloud for each thread.  

4. Comment on your word clouds. Explain the key discussions and topics being
addressed in each of the three thread.  


## Question 2:
- Combine all the threads you collected in question 1 and create a column to label
them with their thread number.

- For example, label the first thread comments as "1", label the second thread
comments as "2", label the third thread comments as "3".

- Next, apply K-means clustering to cluster the combined threads.

- Visualise the results of your clustering in two-dimensional vector space. Ensure that
your visualisation includes both the clusters and the original labels of the
documents.

- Comment on your findings. Assess the performance of K-means clustering in terms
of correctly identifying clusters. Did it effectively identify the clusters?



## Question 3:
- Use all thread URLs on Reddit that you identified in question 1.

- Test if there exists a linear relationship between the number of comments in threads
and their corresponding dates. Note: You may need to convert dates to a date format.



## Question 4:
- Retrieve the content of the top thread you identified in question 1.

- Test whether the number of comments on a thread is equally likely on each day.



## Question 5:
- Using Mastodon, identify users who are related to your chosen topic.

- Identify the top five most active users, based on the highest number of statuses
they've posted.

- Download 50 followers and 50 friends (these are the users that your user follows) of
these 5 top users.

- Create a graph and visualize the relationships among these users.

Note 1: You can select any five users from the top 10 users for which you can
successfully obtain friend and follower data. Keep in mind that you might encounter
limitations in downloading friends, such as discoverability issues or some users
having no friends.

Note 2: If you can only download fewer than 50 followers or friends for certain users
that's acceptable


## Question 6:
Find the most central users in your graph using all centrality measures you learned in this
subject. Comment on your findings.
