# Challenge 1
# 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) from film as min_duration;
select max(length) from film as max_duration;
# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select round(avg(length) / 60) as duration_hours from film;
select round(avg(length)) as duration_minutes from film;
# 2. You need to gain insights related to rental dates: 
# 2.1 Calculate the number of days that the company has been operating 
select datediff(
               (select max(str_to_date(rental_date, '%Y-%m-%d')) from rental),
               (select min(str_to_date(rental_date, '%Y-%m-%d')) from rental)
) as date_difference;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results. 
alter table rental 
add column month varchar(20), 
add column weekday varchar(20);

SET SQL_SAFE_UPDATES = 0;
update rental
set rental_month = date_format(rental_date, '%M'), rental_weekday = dayname(rental_date);
select * from rental limit 20;

# 3. You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. 
# Sort the results of the film title in ascending order. */

SET SQL_SAFE_UPDATES = 0;
update film
set rental_duration = "Not Available"
where rental_duration = null;
select title, rental_duration
from film
order by title asc;

# Challenge 2 
# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine: 
# 1.1 The total number of films that have been released. 
select count(*) from film;
# 1.2 The number of films for each rating.
select rating, count(*) from film group by rating;
# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
select rating, count(*) as count from film group by rating order by count desc;

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length),2) as mean from film group by rating order by mean desc;
# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies. 
select rating, round(avg(length),2) as mean from film group by rating having mean > 120 order by mean desc;
