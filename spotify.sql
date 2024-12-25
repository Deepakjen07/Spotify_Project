DROP TABLE IF EXISTS spotify;
CREATE TABLE employee(
employee_id VARCHAR(50) PRIMARY KEY,
last_name CHAR(50),
first_name CHAR(50),
title VARCHAR(50),
reports_to VARCHAR(30),
levels VARCHAR(10),
birthdate TIMESTAMP,
hire_date TIMESTAMP,
address VARCHAR(120),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(30),
postal_code VARCHAR(30),
phone VARCHAR(30),
fax VARCHAR(30),
email VARCHAR(30));

CREATE TABLE customer(
customer_id VARCHAR(30) PRIMARY KEY,
first_name CHAR(30),
last_name CHAR(30),
company VARCHAR(30),
address VARCHAR(30),
city VARCHAR(30),
state VARCHAR(30),
country VARCHAR(30),
postal_code INT8,
phone INT,
fax INT,
email VARCHAR(30),
support_rep_id VARCHAR(30));

CREATE TABLE invoice(
invoice_id VARCHAR(30) PRIMARY KEY,
customer_id VARCHAR(30),
invoice_date TIMESTAMP,
billing_address VARCHAR(120),
billing_city VARCHAR(30),
billing_state VARCHAR(30),
billing_country VARCHAR(30),
billing_postal VARCHAR(30),
total FLOAT8);

CREATE TABLE invoice_line(
invoice_line_id VARCHAR(50) PRIMARY KEY,
invoice_id VARCHAR(30),
track_id VARCHAR(30),
unit_price VARCHAR(30),
quantity VARCHAR(30));

CREATE TABLE track(
track_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(30),
album_id VARCHAR(30),
media_type_id VARCHAR(30),
genre_id VARCHAR(30),
composer VARCHAR(30),
milliseconds TIMESTAMP,
bytes INT8,
unit_price INT16);

CREATE TABLE playlist(
playlist_id VARCHAR(50) PRIMARY KEY,
name  VARCHAR(30));

CREATE TABLE playlist_track(
playlist_id VARCHAR(50) PRIMARY KEY,
track_id VARCHAR(50) PRIMARY KEY);

CREATE TABLE artist(
artist_id VARCHAR(50) PRIMARY KEY,
name  VARCHAR(30)); 

CREATE TABLE album(
album_id VARCHAR(50) PRIMARY KEY,
title  VARCHAR(30),
artist_id  VARCHAR(30));

CREATE TABLE media_type(
media_type_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(30));

CREATE TABLE genre(
genre_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(30));
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA
SELECT COUNT(*) FROM spotify;
SELECT COUNT(DISTINCT artist)FROM spotify;
SELECT COUNT(DISTINCT album) FROM spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT MAX(duration_min) FROM spotify;
SELECT MIN(duration_min) FROM spotify;
SELECT * FROM spotify WHERE duration_min = 0;
DELETE FROM spotify WHERE duration_min = 0;
SELECT * FROM spotify WHERE duration_min = 0;
SELECT DISTINCT channel FROM spotify;
SELECT DISTINCT most_played_on FROM SPOTIFY;

/*
-- -------------------------------------------------------
-- DATA ANALYSIS EASY CATEGORY
-- -------------------------------------------------------
*/

-- Q.1. Retrieve the names of all tracks that have more than 1 billiion streams.

SELECT * 
FROM spotify 
WHERE stream >1000000000;

-- Q.2. List all albums along with their respective artists.

SELECT DISTINCT album, artist
FROM spotify 
ORDER BY 1;

SELECT DISTINCT album 
FROM spotify 
ORDER BY 1;

-- Q.3. Get the total number of comments for tracks where licensed = TRUE.

SELECT DISTINCT licensed
FROM spotify;

SELECT SUM(comments) as total_comments 
FROM spotify 
WHERE licensed = 'true';

-- Q.4. Find all tracks that belong to the album type single

SELECT * 
FROM spotify 
WHERE album_type = 'single';

-- Q.5. Count the total number of tracks by eack artist.

SELECT artist, COUNT(*) AS Total_no_songs 
FROM spotify 
GROUP BY artist 
ORDER BY 2 DESC ; -- 2 is for total_no_songs and 1 is for artist

-- Q.6. Who is the senior most employee based on job title?

SELECT * 
FROM employee
ORDER BY levels DESC 
limit 1;

-- Q.7. Which countries have the most Invoices?

SELECT COUNT(invoice_id) as c, billing_country
FROM invoice 
Group by billing_country 
ORDER BY c DESC;

-- Q.8. What are top 3 values of total invoice?

SELECT total 
FROM invoice 
ORDER BY total DESC 
LIMIT 3;

/*Q.9. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals*/

SELECT SUM(total) as invoice_total, billing_city 
FROM invoice 
GROUP BY billing_city 
ORDER BY invoice_total DESC;

/*Q.10. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money*/

SELECT customer.customer_id, customer.first_name, customer.last_name, 
SUM(invoice.total) as total 
FROM customer 
JOIN invoice ON customer.customer_id = invoice.customer_id 
GROUP BY customer.customer_id 
RDER BY total DESC 
LIMIT 1;

/*

-- -------------------------------------------------------
-- DATA ANALYSIS MEDIUM CATEGORY
-- -------------------------------------------------------
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- Q.11. Calculate the average danceability of tracks in each album.

SELECT album, avg(danceability) as avg_danceability 
FROM spotify 
GROUP BY 1 
ORDER BY 2 DESC;

-- Q.12. Find the top 5 tracks with the highest energy values.

SELECT track, AVG(energy) 
FROM spotify 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5;

-- Q.13. List all tracks along with their views and likes where official_video = TRUE.

SELECT track, SUM(views) as total_views, SUM(likes) as total_likes
FROM spotify 
WHERE official_video = 'true' 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5;

-- Q.14. For each album, calculate the total views of all associated tracks.

SELECT album, SUM(views) as Total_views 
FROM spotify 
GROUP BY 1 
ORDER BY 2 DESC;

-- Q.15. Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT * 
FROM(SELECT track,COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) as streamed_on_youtube,
                  COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) as streamed_on_spotify
FROM spotify GROUP BY 1) as D1
WHERE streamed_on_spotify > streamed_on_youtube
AND streamed_on_youtube>0 ;

-- Q.16. Write a query to find tracks where the liveness score is above the average.

SELECT track, artist, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);


-- Q.17. Find tracks where the energy-to-liveness ratio is greater than 1.2

SELECT 
	track, energy_liveness
	 AS energy_to_liveness_ratio
FROM Spotify 
	WHERE energy_liveness > 1.2 ;

/*Q.18. Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A*/

 /*Method 1 */

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


/* Method 2 */

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS genrename
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email; 

/*Q.19. Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands*/

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/*Q.20. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first*/

SELECT name,miliseconds
FROM track
WHERE miliseconds > (
	SELECT AVG(miliseconds) AS avg_track_length
	FROM track )
ORDER BY miliseconds DESC;



/*
-- -------------------------------------------------------
-- DATA ANALYSIS ADVANCED CATEGORY
-- -------------------------------------------------------
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
Find tracks where the energy-to-liveness ratio is greater than 1.2.
Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/

-- Q.21. Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist AS (
SELECT artist, track, SUM(views) as total_view, DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) 
as rank FROM spotify GROUP BY 1,2 ORDER BY 1,3 DESC)SELECT * FROM ranking_artist WHERE rank <= 3;


-- Q.22. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH cte AS (SELECT album, MAX(energy) as highest_energy,
MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1)
SELECT album,
highest_energy - lowest_energy as energy_diff
FROM cte
ORDER BY 2 DESC;


-- Q.23. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT 
	track,
	SUM(likes) OVER (ORDER BY views) AS cumulative_sum
FROM Spotify
	ORDER BY SUM(likes) OVER (ORDER BY views) DESC ;

/*Q.24. Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent*/

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */


WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1 
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;

/*Q.25. We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres*/


/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

/* Method 1: Using CTE */

WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1


/* Method 2: : Using Recursive */

WITH RECURSIVE
	sales_per_country AS(
		SELECT COUNT(*) AS purchases_per_genre, customer.country, genre.name, genre.genre_id
		FROM invoice_line
		JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
		JOIN customer ON customer.customer_id = invoice.customer_id
		JOIN track ON track.track_id = invoice_line.track_id
		JOIN genre ON genre.genre_id = track.genre_id
		GROUP BY 2,3,4
		ORDER BY 2
	),
	max_genre_per_country AS (SELECT MAX(purchases_per_genre) AS max_genre_number, country
		FROM sales_per_country
		GROUP BY 2
		ORDER BY 2)

SELECT sales_per_country.* 
FROM sales_per_country
JOIN max_genre_per_country ON sales_per_country.country = max_genre_per_country.country
WHERE sales_per_country.purchases_per_genre = max_genre_per_country.max_genre_number;

/*Q.26. Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount*/



/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

/* Method 1: using CTE */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1


/* Method 2: Using Recursive */

WITH RECURSIVE 
	customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),

	country_max_spending AS(
		SELECT billing_country,MAX(total_spending) AS max_spending
		FROM customter_with_country
		GROUP BY billing_country)

SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customter_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;


















