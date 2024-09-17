

use netflix;

select * from netflix_titles nt  ;

#top 5 movies base on 
select `type`,rating,title from netflix_titles nt where `type`= 'movie' limit 5 ;

# type of content 

select distinct `type` from netflix_titles nt ;

#Get information Thos Websires which has 2 seasons 

select title ,duration from netflix_titles nt where duration='2 Seasons'  ;

#Get Information movie release year=2024;

select `type`,release_year,title from netflix_titles nt where `type` = "movie" and release_year =2021;

# long movie duration 

select max(duration),`type`,title from netflix_titles nt group by `type`,title having `type`='movie' and max(duration) >99 ;

#How many movie release in india 

select title from netflix_titles nt where  country = 'india' and `type` = 'Movie';

#how many tv show from india 

select title from netflix_titles nt where country ='india' and `type` = 'TV Show';

#How many movies direct by indian directors

select title,director from netflix_titles nt where  country = 'india' and `type` = 'Movie';

#Rohit Shetty movies 
 
select * from netflix_titles nt where director like '%Rohit Shetty%';

# count number of movies and Tv 

select `type` ,count(*) from netflix_titles nt group by `type` ;

# find most comman rating for movies and Tv 

select `type`,rating from 
(select `type`,rating,count(*), rank() over(partition by `type` order by count(*)desc) as ranking
from netflix_titles nt group by`type`,rating) as t1 where ranking =1   ;

#find the top 5 countries with the most content on netflix 

select country,count(show_id) as total_content from netflix_titles nt group by country,`type` order by total_content desc limit 5 ;


#list all movies release in a specific years 

select * from netflix_titles nt where `type` = 'movie' and release_year = 2020;

#identify the longest movies 

select max(duration) from netflix_titles nt ;

select * from netflix_titles nt where `type` = 'movie' and duration = (select max(duration) from netflix_titles nt);


#List all tv show with more than 5 seasons

select * from netflix_titles nt ;

select `type`,duration,title from netflix_titles nt where duration >'5 seasons' and `type` = 'TV Show';

# count the nuber of content iteam in each genre 

select show_id,listed_in,SUBSTRING_INDEX(listed_in , ',',1	)
from netflix_titles nt ;


SELECT count(listed_in) as total_content  ,
SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', 1), ',', -1) AS category1,
SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', 2), ',', -1) AS category2,
SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', 3), ',', -1) AS category3
FROM netflix_titles nt group by listed_in order by count(listed_in) desc ;

#find each year and  number of content release by india on netflix.return top 5year with highest  content release 


select release_year,count(`type`),country from netflix_titles nt group by release_year,country
having country = 'india' order by count(`type`) desc limit 5 ;


#all the movies are documantaries 

select * from netflix_titles nt where listed_in like '%documentaries%' ;

# find how many movies actor 'salman khan' appeared in last 10 years

select * from netflix_titles nt ;

select * from netflix_titles nt where `cast`  like '%salman khan%' and release_year > extract(year from current_date)-10 ;

#categorize the content based on the presences of the keywords 'kill' or 'violences' the description feild 

with New_table 
as
(
select * ,case 
	when description like '%kill%' or 
	description like '%violence%' then 'bad_flim'
	else 'good_flim'
end category
from netflix_titles nt 
)
select category,count(*) as table_content 
from New_table 
group by 1;

