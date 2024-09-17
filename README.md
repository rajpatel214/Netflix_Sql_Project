# Netflix Movie and TV show Data Analysis Using Sql 

![logo](https://github.com/rajpatel214/Netflix_Sql_Project/blob/main/Netflix.jpg)

## Overviw 
This project focuses on an in-depth analysis of Netflix's movie and TV show data using SQL. The aim is to derive meaningful insights and address key business questions based on the dataset. This README outlines the project's objectives, business challenges, proposed solutions, key findings, and final conclusions.

## Objective 
The objective of this project is to analyze Netflix's movies and TV shows data using SQL to extract insights and address key business problems. The project explores patterns, trends, and various factors impacting Netflix content, such as release years, content types, countries of production, directors, and genres.

## Problem And Solution

### 1) Content Type Distribution
select distinct `type` from netflix_titles;
### 2) Web Series with 2 Seasons
select title, duration from netflix_titles where duration = '2 Seasons';
### 3) Movies Released in 2024
select `type`,release_year,title from netflix_titles where `type` = 'movie' and release_year = 2024;
### 4) Longest Movie Duration
select max(duration), `type`, title from netflix_titles where `type` = 'movie' and max(duration) > 99;
### 5) Movies Released in India
select title from netflix_titles where country = 'india' and `type` = 'movie';
### 6) TV Shows from India
select title from netflix_titles where country = 'india' and `type` = 'TV Show';
### 7) Movies Directed by Indian Directors
select title, director from netflix_titles where country = 'india' and `type` = 'Movie';
### 8) Movies by Rohit Shetty
select * from netflix_titles where director like '%Rohit Shetty%';
### 9) Count of Movies and TV Shows
select `type`, count(*) from netflix_titles group by `type`;
### 10) Most Common Ratings
select `type`, rating from (select `type`, rating, count(*), rank() over(partition by `type` order by count(*) desc) as ranking from netflix_titles group by `type`, rating) as t1 where ranking = 1;
### 11) Top 5 Countries with Most Content
select country, count(show_id) as total_content from netflix_titles group by country, `type` order by total_content desc limit 5;
### 12) Movies Released in 2020
select * from netflix_titles where `type` = 'movie' and release_year = 2020;
### 13) Identify Longest Movies
select * from netflix_titles where `type` = 'movie' and duration = (select max(duration) from netflix_titles);
### 14) TV Shows with More Than 5 Seasons
select `type`, duration, title from netflix_titles where duration > '5 seasons' and `type` = 'TV Show';
### 15) Count of Content Items by Genre
SELECT count(listed_in) as total_content, SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', 1), ',', -1) AS category1 FROM netflix_titles group by listed_in order by count(listed_in) desc;
### 16) Top 5 Years with Highest Content Released by India
select release_year, count(`type`), country from netflix_titles group by release_year, country having country = 'india' order by count(`type`) desc limit 5;
### 17) All Documentaries
select * from netflix_titles where listed_in like '%documentaries%';
### 18) Salman Khan Movies in the Last 10 Years
select * from netflix_titles where `cast` like '%salman khan%' and release_year > extract(year from current_date) - 10;
### 19)Categorizing Content by Keywords 'Kill' or 'Violence'
with New_table as ( select *, case when description like '%kill%' or description like '%violence%' then 'bad_flim' else 'good_flim' end category from netflix_titles ) select category, count(*) as table_content from New_table group by 1;

## Finding and Conclusion 
We explored Netflix's content to identify popular movies, distinct content types, and the most common ratings.
Analyzed content from India, including movies, TV shows, and directors like Rohit Shetty.
Found the longest movies and TV shows with more than 5 seasons.
Categorized content by genres and popular release years from different countries, including India.
Identified movies and shows with specific themes like 'violence' or featuring actors like Salman Khan.

This project provides a comprehensive SQL analysis of Netflix's global content library. It highlights various aspects such as content type, release years, country-specific releases, director contributions, and popular genres. By using SQL queries, we can easily extract meaningful insights and explore patterns within the data, assisting in decision-making for content creation and viewer analysis.











