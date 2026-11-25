DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    subscription_plan VARCHAR(20)
);

DROP TABLE IF EXISTS watch_historys;
CREATE TABLE watch_historys (
    watch_id INT PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    movie_title VARCHAR(100),
    genre VARCHAR(30),
    watch_date DATE,
    watch_time INT,
    rating DECIMAL(2,1),
    device VARCHAR(20)
);

INSERT INTO users (user_id, user_name, gender, age, city, subscription_plan)
VALUES
(1, 'Amit Sharma', 'Male', 24, 'Delhi', 'Premium'),
(2, 'Priya Verma', 'Female', 28, 'Mumbai', 'Basic'),
(3, 'Rahul Singh', 'Male', 22, 'Kolkata', 'Standard'),
(4, 'Neha Gupta', 'Female', 30, 'Bangalore', 'Premium'),
(5, 'Rohit Patel', 'Male', 27, 'Ahmedabad', 'Basic'),
(6, 'Sneha Yadav', 'Female', 25, 'Lucknow', 'Standard'),
(7, 'Vikram Joshi', 'Male', 32, 'Pune', 'Premium'),
(8, 'Anjali Mehta', 'Female', 21, 'Jaipur', 'Basic'),
(9, 'Karan Malhotra', 'Male', 29, 'Chandigarh', 'Premium'),
(10, 'Pooja Mishra', 'Female', 26, 'Bhopal', 'Standard');

INSERT INTO watch_historys (watch_id, user_id, movie_title, genre, watch_date, watch_time, rating, device)
VALUES
(101, 1, 'Inception', 'Sci-Fi', '2026-01-05', 148, 4.9, 'Mobile'),
(102, 2, '3 Idiots', 'Comedy', '2026-01-07', 170, 4.8, 'Smart TV'),
(103, 3, 'Avengers: Endgame', 'Action', '2026-01-10', 181, 4.9, 'Laptop'),
(104, 4, 'The Conjuring', 'Horror', '2026-01-12', 112, 4.5, 'Mobile'),
(105, 5, 'Interstellar', 'Sci-Fi', '2026-01-15', 169, 5.0, 'Smart TV'),
(106, 6, 'KGF Chapter 2', 'Action', '2026-01-18', 168, 4.7, 'Laptop'),
(107, 7, 'Dangal', 'Drama', '2026-01-20', 161, 4.8, 'Tablet'),
(108, 8, 'Jumanji', 'Adventure', '2026-01-22', 119, 4.4, 'Mobile'),
(109, 9, 'Bahubali 2', 'Action', '2026-01-25', 167, 4.9, 'Smart TV'),
(110, 10, 'Zindagi Na Milegi Dobara', 'Drama', '2026-01-28', 155, 4.6, 'Laptop');

SELECT * FROM users;
SELECT * FROM watch_historys;

--Beginner Level:

--Q1. Show all users.
SELECT * FROM users;

--Q2. Show user name and subscription plan.
SELECT user_name, subscription_plan FROM users;

--Q3. Show users older than 25 years.
SELECT * FROM users
WHERE age > 25;

--Q4. Show all users from Mumbai.
SELECT * FROM users
WHERE city='Mumbai';

--Q5. Show users ordered by age (highest to lowest).
SELECT * FROM users
ORDER BY age DESC;

--Intermediate Level:

--Q6. Find the total number of users.
SELECT COUNT(*) AS total_users
FROM users;

--Q7. Find the average age of users.
SELECT ROUND(AVG(age)) AS avg_age
FROM users;

--Q8. Find the highest movie rating.
SELECT movie_title, MAX(rating) AS highest_movie_rating
FROM watch_historys
GROUP BY movie_title
ORDER BY highest_movie_rating DESC LIMIT 1;

--Q9. Find the lowest movie rating.
SELECT movie_title, MIN(rating) AS lowest_movie_rating
FROM watch_historys
GROUP BY movie_title
ORDER BY lowest_movie_rating ASC LIMIT 1;

--Q10. Calculate the total watch time of all users.
SELECT SUM(watch_time) AS total_watch_time
FROM watch_historys;

--GROUP BY:

--Q11. Find the number of users in each subscription plan.
SELECT subscription_plan, COUNT(*) AS number_of_users
FROM users
GROUP BY subscription_plan;

--Q12. Find the average rating for each genre.
SELECT genre, ROUND(AVG(rating)) AS average_rating
FROM watch_historys
GROUP BY genre;

--Q13. Find the total watch time for each genre.
SELECT genre, SUM(watch_time) AS total_watch_time
FROM watch_historys
GROUP BY genre;

--Q14. Display genres watched more than 1 times.
SELECT genre, COUNT(*) AS total_views
FROM watch_historys
GROUP BY genre
HAVING COUNT(*) > 1;

--JOIN:

--Q15. Show user name with movie title.
SELECT u.user_name, w.movie_title
FROM watch_historys w
JOIN users u ON w.user_id=u.user_id
GROUP BY u.user_name, w.movie_title;

--Q16. Show user name, city, movie title and rating.
SELECT u.user_name, u.city, w.movie_title, w.rating
FROM watch_historys w
JOIN users u ON w.user_id=u.user_id
GROUP BY u.user_name, u.city, w.movie_title, w.rating;
--Advanced Level:

--Q17. Show the Top 2 highest-rated movies.
SELECT movie_title, MAX(rating) AS highest_rated_movies
FROM watch_historys
GROUP BY movie_title
ORDER BY highest_rated_movies DESC LIMIT 2;

--Q18. Find the total watch time of each user.
SELECT u.user_id, u.user_name, SUM(w.watch_time) AS total_watch_time
FROM watch_historys w
JOIN users u ON w.user_id=u.user_id
GROUP BY u.user_id, u.user_name
ORDER BY user_id ASC;

--Q19. Rank users according to total watch time.
SELECT user_id, SUM(watch_time) AS total_watch_time,
RANK() OVER (ORDER BY SUM(watch_time) DESC) AS ranking
FROM watch_historys
GROUP BY user_id;

--Q20. Find the second highest-rated movie.
SELECT MAX(rating) AS second_highest_rating
FROM watch_historys
WHERE rating < 
(			SELECT MAX(rating)
			FROM watch_historys
);

--Bonus Question Formatting:

--Q21. Add a new column language to the watch_history table.
ALTER TABLE watch_historys
ADD COLUMN language VARCHAR(30);

--Q22. Change the size of the device column to 50 characters.
ALTER TABLE watch_historys
ALTER COLUMN device TYPE VARCHAR(50);

SELECT * FROM watch_historys;

--Q23. Update the subscription plan of Priya Verma to Premium.
UPDATE users
SET subscription_plan='Premium'
WHERE user_name='Priya Verma';

SELECT * FROM users ORDER BY user_id ASC;

--Q24. Increase the rating of all movies below 4.5 by 0.2.
UPDATE watch_historys
SET rating = rating + 0.2
WHERE rating < 4.5;

SELECT * FROM watch_historys;

--Q25. Delete all watch history records with a rating below 4.5.
DELETE FROM watch_historys
WHERE rating < 4.5;

SELECT * FROM watch_historys;