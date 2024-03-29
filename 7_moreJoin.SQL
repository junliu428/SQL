-- # 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962;

-- # 2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
WHERE title = 'Citizen Kane';

-- # 3. List all of the Star Trek movies, include the id, title and yr
-- # (all of these movies include the words Star Trek in the
-- # title). Order results by year.
SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%';

-- # 4. What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
WHERE name = 'Glenn Close';

-- # 5. What is the id of the film 'Casablanca'
SELECT id FROM movie
WHERE title = 'Casablanca';

-- # 6. Obtain the cast list for 'Casablanca'. Use the id value that
-- # you obtained in the previous question.
SELECT name 
FROM actor
JOIN casting 
ON actor.id = casting.actorid
WHERE casting.movieid = 11768;

-- # 7. Obtain the cast list for the film 'Alien'.
SELECT name FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE movie.title='Alien';

-- # 8. List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie
JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE name='Harrison Ford';

-- # 9. List the films where 'Harrison Ford' has appeared - but not in
-- # the star role. [Note: the ord field of casting gives the position
-- # of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie
JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE name='Harrison Ford' and casting.ord <> 1;

-- # 10. List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie
JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1;

-- # 11. Which were the busiest years for 'John Travolta', show the
-- # year and the number of movies he made each year for any year in
-- # which he made at least 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=casting.movieid
        JOIN actor ON casting.actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- # 12. List the film title and the leading actor for all of 'Julie
-- # Andrews' films.
SELECT title, name FROM movie
  JOIN casting ON movie.id = casting.movieid AND ord=1
    JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (
SELECT movieid FROM casting
WHERE actorid IN
  (SELECT id FROM actor
  WHERE name='Julie Andrews'));

-- # 13. Obtain a list of actors in who have had at least 30 starring
-- # roles.
SELECT name FROM actor
  JOIN casting ON id=actorid WHERE ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 30;

-- # 14. List the films released in the year 1978 ordered by the 
-- # number of actors in the cast, then by title.
SELECT title, COUNT(*) AS number FROM movie
JOIN casting ON id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(*) DESC, title;

-- # 15. List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name from actor
JOIN casting ON id=actorid
WHERE movieid IN( 
SELECT movieid FROM casting
JOIN actor ON id=actorid
AND name = 'Art Garfunkel') AND name <> 'Art Garfunkel'
GROUP BY name;