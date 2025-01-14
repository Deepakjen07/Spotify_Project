# Spotify Advanced SQL Project and Query Optimization
Project Category: Advanced
[Click Here to get Dataset]:- 1. (https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)

                               2.(https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbkYyOGw3cnJZRHhEdE9vMGoxbXZBNXU3d1dPd3xBQ3Jtc0ttZVVIVTEtTVFscEVWd1VMaWxmWWtXZHdRYURPc2F3dG42OERnekdzRTNtNUZYVlY2Z25ZWVZ4b0x2V1VldkxaWTRSNmI2eHRXQXJ0WTJHcWQ3LUYyTFhnT2xLZDMtM3BlQXB5NE9RMVlsY3NzYXhITQ&q=https%3A%2F%2Fshorturl.at%2FsEIUV&v=VFIuIjswMKM)


![Spotify Logo](https://github.com/najirh/najirh-Spotify-Data-Analysis-using-SQL/blob/main/spotify_logo.jpg)

## Overview
This project involves multiple tables and a primary table named Spotify, which contains columns different from those of other tables. It analyzes different Spotify datasets with various attributes about tracks, albums, and artists using SQL. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

```SQL
-- create table
DROP TABLE IF EXISTS Spotify;
CREATE TABLE Spotify (
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
ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT 
USING asset_no::INT;




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
```
## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly.There are multiple tables with different columns. The Tables such as:
- artist
- album
- track
- employee
- customer
- genre
- invoice
and a combined tables named as spotify where different columns of above tables are listed. 
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.

### 4. Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into **easy**, **medium**, and **advanced** levels to help progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.

### 5. Query Optimization
In advanced stages, the focus shifts to improving query performance. Some optimization strategies include:
- **Indexing**: Adding indexes on frequently queried columns.
- **Query Execution Plan**: Using `EXPLAIN ANALYZE` to review and refine query performance.
  
---

## 26 Practice Questions

### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where `licensed = TRUE`.
4. Find all tracks that belong to the album type `single`.
5. Count the total number of tracks by each artist.
6. Who is the senior most employee based on job title?
7. Which countries have the most Invoices?
8. What are top 3 values of total invoice?
9. Which city has the best customers? We would like to throw a promotional Music
   Festival in the city we made the most money. Write a query that returns one city that
   has the highest sum of invoice totals. Return both the city name & sum of all invoice
   totals
10. Who is the best customer? The customer who has spent the most money will be
   declared the best customer. Write a query that returns the person who has spent the
   most money

### Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where `official_video = TRUE`.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.
   Write query to return the email, first name, last name, & Genre of all Rock Music
   listeners. Return your list ordered alphabetically by email starting with A
6. Let's invite the artists who have written the most rock music in our dataset. Write a
   query that returns the Artist name and total track count of the top 10 rock bands
7. Return all the track names that have a song length longer than the average song length.
   Return the Name and Milliseconds for each track. Order by the song length with the
   longest songs listed first

### Advanced Level
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
```sql
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC
```
   
5. Find tracks where the energy-to-liveness ratio is greater than 1.2.
6. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
7. Find how much amount spent by each customer on artists? Write a query to return
   customer name, artist name and total spent
8. We want to find out the most popular music Genre for each country. We determine the
   most popular genre as the genre with the highest amount of purchases. Write a query
   that returns each country along with the top Genre. For countries where the maximum
   number of purchases is shared return all Genres
9. Write a query that determines the customer that has spent the most on music for each
   country. Write a query that returns the country along with the top customer and how
   much they spent. For countries where the top amount spent is shared, provide all
   customers who spent this amount


Here’s an updated section for your **Spotify Advanced SQL Project and Query Optimization** README, focusing on the query optimization task you performed. You can include the specific screenshots and graphs as described.

---

## Query Optimization Technique 

To improve query performance, we carried out the following optimization process:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - We began by analyzing the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `artist` column, and the performance metrics were as follows:
        - Execution time (E.T.): **7 ms**
        - Planning time (P.T.): **0.17 ms**

- **Index Creation on the `artist` Column**
    - To optimize the query performance, we created an index on the `artist` column. This ensures faster retrieval of rows where the artist is queried.
    - **SQL command** for creating the index:
      ```sql
      CREATE INDEX idx_artist ON spotify_tracks(artist);
      ```

- **Performance Analysis After Index Creation**
    - After creating the index, we ran the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **0.153 ms**
        - Planning time (P.T.): **0.152 ms**


This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.
---

## Technology Stack
- **Database**: PostgreSQL
- **SQL Queries**: DDL, DML, Aggregations, Joins, Subqueries, Window Functions,CTEs
- **Tools**: pgAdmin 4 (or any SQL editor), PostgreSQL (via Homebrew, Docker, or direct installation)

## How to Run the Project
1. Install PostgreSQL and pgAdmin (if not already installed).
2. Set up the database schema and tables using the provided normalization structure.
3. Insert the sample data into the respective tables.
4. Execute SQL queries to solve the listed problems.
5. Explore query optimization techniques for large datasets.

---

## Next Steps
- **Visualize the Data**: Use a data visualization tool like **Tableau** or **Power BI** to create dashboards based on the query results.
- **Expand Dataset**: Add more rows to the dataset for broader analysis and scalability testing.
- **Advanced Querying**: Dive deeper into query optimization and explore the performance of SQL queries on larger datasets.

---

## Contributing
If you would like to contribute to this project, feel free to fork the repository, submit pull requests, or raise issues.

---

