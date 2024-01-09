by: Quang Dong Nguyen  
provided by: Western Sydney University

# Project Tasks - Dawson Steward Analytics  

Your company, Dawson Steward Analytics, a consultancy firm specialised in AI analytics is tasked by a
retail chain in the northern hemisphere to analyse their sales data. The data are contained in three different
sets:  
sales: daily sales data over a seven day period, containing the following columns:  
– store id – the unique identifier of a store  
– product id – the unique identifier of a product  
– date – sales date (YYYY-MM-DD)  
– sales – sales quantity  
– revenue – daily total sales revenue  
– price – product sales price  
– promo type 1 – type of promotion applied on product  
– promo bin 1 – binned promotion rate for promotion type  
– promo discount 2 – discount rate for applied promotion  
– promo discount type 2 – type of discount applied  


Product hierarchy: data containing the hierarchy and sizes of products:  
– product id – the unique identifier of a product  
– product length – length of product  
– product depth – depth of product  
– produc width – width of product  
– hierarchy1 id – barcode hierarchy of product. The most general hierarchy. For example:
fords and beverages.  
– hierarchy2 id – This is the second level hierarchy. For example: beverages  
– hierarchy3 id – Third level hierarchy, e.g. Cola  
– hierarchy4 id – Forth level hierarchy, e.g. Pepsi cola without sugar  
– hierarchy5 id – Fifth level hierarchy, e.g. pepsi cola without sugar 300ML  
store cities: data containing the city, type and size information of the stores  
– store id – the unique identifier of a store  
– storetype id – type of store  
– store size  
– city id  


---
# Your tasks are:  
1. Write the code to compute the total revenue of each store at the end of each day. Is there a noted
difference between the days? Write also the code to calculate the total revenue over the seven day
period. Plot the latter on a graph.  
2. What’s the most popular product type (hierarchy 1) sold in all stores over a week? How much
revenue did the stores receive for that product during the week? How does that compare with the
second most popular product? Provide a table that shows the product type ranked from most to
least popular. For each product type provide: how many subtypes (hierarchy 2) are there, how
many products are in this product type, what’s the sales quantity, and the revenue generated.  
3. Compare the sales volumes between the two most common store types in the data set. How do they
compare in terms of total revenue? Is there a relationship between a store’s size and its revenue?  
4. Several different types of promotions were applied to the products during the period with various
level of promotion rates. For each promotion type, display the different levels of promotion used
during the period. Analyse the effectiveness of the promotion on the sales of the products.  

Write a PDF report containing your code and all required analysis and results. The report is being
marked using the marking criteria, so make sure that each piece of analysis covers all of the criteria.
