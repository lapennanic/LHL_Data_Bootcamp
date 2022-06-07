/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAMILIAR WITH THE DATABASE AND TABLES HERE
.tables
.schema

--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/
SELECT movie_id, name
FROM movie_distributors
JOIN distributors 
ON distributors.distributor_id=movie_distributors.distributor_id
WHERE name LIKE '%Universal Pictures%';


/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/
SELECT distributors.name, year
FROM distributors
JOIN movie_distributors
    ON distributors.distributor_id=movie_distributors.distributor_id
JOIN movies
    ON movies.movie_id=movie_distributors.movie_id
WHERE year = 2006;



/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/
SELECT a.title
FROM movies a, movies b
WHERE a.movie_id=b.movie_id 
    AND a.title =(SELECT b.title) AND a.year =(SELECT b.year)
    AND a.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/

SELECT name, title
FROM movies AS m
JOIN directors AS d 
    ON d.movie_id=m.movie_id
JOIN people AS p 
    ON p.person_id=d.person_id
JOIN roles AS r
    ON m.movie_id=d.movie_id
WHERE role LIKE '%actor%'
GROUP BY name, title;

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/

SELECT m.title, at.title AS AKA_Title
FROM movies AS m
LEFT JOIN aka_titles AS at ON m.movie_id=at.movie_id
WHERE year = 2011;


/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

SELECT title, p.name AS composer_name
FROM movies AS m
LEFT JOIN composers AS c ON m.movie_id=c.movie_id
JOIN people AS p ON p.person_id=c.person_id
WHERE year = 1976 OR year = 1977
GROUP BY title;


/* TASK VII
Find the most popular movie genres.
*/

SELECT COUNT(m.movie_id) AS movie_count, label
FROM movies AS m
JOIN movie_genres AS mg ON m.movie_id=mg.movie_id
JOIN genres AS g ON g.genre_id=mg.genre_id
GROUP BY label
ORDER BY movie_count DESC;

/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/

SELECT p.name, rating
FROM movies AS m
JOIN cinematographers AS c ON m.movie_id=c.movie_id
JOIN people AS p ON c.person_id=p.person_id
ORDER BY rating DESC
LIMIT 10;


/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

SELECT c.name, rating
FROM movies AS m
JOIN movie_countries AS mc ON m.movie_id=mc.movie_id
JOIN countries AS c ON mc.country_id=c.country_id
GROUP BY c.name
HAVING rating > 8.5
ORDER BY rating DESC;



/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/

SELECT title, year, rating, c.name AS country
FROM movies AS m
JOIN movie_countries AS mc ON m.movie_id=mc.movie_id
JOIN countries AS c ON mc.country_id=c.country_id
WHERE rating = (SELECT max(rating) FROM movies m2 WHERE m.title=m2.title)
ORDER BY rating DESC;


/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
