/************************
THIS SQL ASSIGNMENT COVERS THE FOLLOWING SECTIONS:
6 JOIN
7 MORE JOIN OPERATIONS
8 USING NULL
9 COVID 19
10 SELF JOIN
************************/

/* Modify it to show the matchid and player name for all goals scored by Germany. 
To identify German players, check for: teamid = 'GER'*/

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';



/* From the previous query you can see that Lars Bender's scored a goal in game 1012. 

Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. 

We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012 */

SELECT id,stadium,team1,team2 FROM game
WHERE id = 1012;




/* You can combine the two steps into a single query with a JOIN.

SELECT *
  FROM game JOIN goal ON (id=matchid)
The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
ON (game.id=goal.matchid)

The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

Modify it to show the player, teamid, stadium and mdate for every German goal.

*/

SELECT player, teamid, stadium, mdate FROM goal JOIN game ON (id = matchid)
	WHERE teamid = 'GER';




/* Use the same JOIN as in the previous question.

Show the team1, team2 and player for every goal scored 
by a player called Mario player LIKE 'Mario%'*/

SELECT team1, team2, player FROM goal JOIN game ON (id = matchid)
	WHERE player like 'Mario%';




/* The table eteam gives details of every 

national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the 

first 10 minutes gtime<=10 */

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid = id)
  WHERE gtime <=10;




/* To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */

SELECT mdate, teamname
  FROM game JOIN eteam ON (team1 = eteam.id)
  WHERE coach LIKE 'Fernando Santos%';




/*List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */

SELECT player
  FROM game JOIN goal ON (matchid = id)
  WHERE stadium LIKE 'National Stadium, Warsaw%';




/* The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany. */

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid <> 'GER';



/* Show teamname and the total number of goals scored.
COUNT and GROUP BY */

SELECT teamname, COUNT(teamid) As 'goals'
  FROM goal JOIN eteam ON id=teamid
 GROUP BY teamname;



/* Show the stadium and the number of goals scored in each stadium. */

SELECT stadium, COUNT(matchid) FROM game
JOIN goal ON id = matchid
GROUP BY stadium;


/* For every match involving 'POL', show the matchid, date and the number of goals scored. */

SELECT matchid, mdate, COUNT(matchid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;



/* For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */

SELECT matchid, mdate, COUNT(matchid) FROM
	game JOIN goal ON (id = matchid)
	WHERE teamid = 'GER'
	GROUP BY matchid, mdate;



/* List every match with the goals scored by each team as shown. This will use 
"CASE WHEN" which has not been explained in any previous exercises.*/

SELECT mdate, 
team1, 
SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1, 
team2,
SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2;




/* List the films where the yr is 1962 [Show id, title] */

SELECT id, title
 FROM movie
 WHERE yr=1962;




/* Give year of 'Citizen Kane'. */

SELECT yr FROM movie where title = 'Citizen Kane';




/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
Order results by year.*/

SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;




/* What id number does the actor 'Glenn Close' have? */

SELECT id FROM actor
WHERE name = 'Glenn Close';




/* What is the id of the film 'Casablanca' */

SELECT id FROM movie
WHERE title = 'Casablanca';




/* Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question) */

SELECT name FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE movieid = 11768;




/* Obtain the cast list for the film 'Alien' */

SELECT actor.name FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Alien';




/* List the films in which 'Harrison Ford' has appeared */

SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';



/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/

SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';




/* List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role] */

SELECT movie.title FROM movie 
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;



/* List the films together with the leading star for all 1962 films. */

SELECT movie.title, actor.name FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.yr = 1962
AND casting.ord = 1;


/* Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made 
each year for any year in which he made more than 2 movies.*/

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;


/* List the film title and the leading actor for all of the films 'Julie Andrews' played in. */


SELECT DISTINCT m.title, a.name
FROM (SELECT movie.*
      FROM movie
      JOIN casting
      ON casting.movieid = movie.id
      JOIN actor
      ON actor.id = casting.actorid
      WHERE actor.name = 'Julie Andrews') AS m
JOIN (SELECT actor.*, casting.movieid AS movieid
      FROM actor
      JOIN casting
      ON casting.actorid = actor.id
      WHERE casting.ord = 1) as a
ON m.id = a.movieid
ORDER BY m.title;



/* List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */

SELECT movie.title, COUNT(actorid) As actors FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1978
GROUP BY title
ORDER BY actors DESC, title;



/* List all the people who have worked with 'Art Garfunkel'. */

SELECT distinct actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
where movie.id in (select movieid from casting join actor on id =actorid where 
actor.name = 'Art Garfunkel') and actor.name <> 'Art Garfunkel';



/* List the teachers who have NULL for their department.

Why we cannot use = */

SELECT name FROM teacher
WHERE dept IS null;



/* Note the INNER JOIN misses the teachers with no department and the departments with no teacher. */

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);



/* Use a different JOIN so that all teachers are listed. */

SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id);



/* Use a different JOIN so that all departments are listed. */

SELECT teacher.name, dept.name
 FROM dept LEFT JOIN teacher
           ON (teacher.dept=dept.id);



/* Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. 
Show teacher name and mobile number or '07986 444 2266' */

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher;



/* Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. 
Use the string 'None' where there is no department. */

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher;


/* Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. 
Use the string 'None' where there is no department.*/

SELECT teacher.name, COALESCE(dept.name, 'None') FROM
	teacher LEFT JOIN dept ON (dept = dept.id);



/* Use COUNT to show the number of 
teachers and the number of mobile phones.*/

SELECT COUNT(name), COUNT(mobile) FROM teacher;



/* Use COUNT and GROUP BY dept.name to show each department and the number of staff. 
Use a RIGHT JOIN to ensure that the Engineering department is listed.*/

SELECT dept.name, COUNT(teacher.name) FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;



/* Use CASE to show the name of each teacher followed by 'Sci' 
if the teacher is in dept 1 or 2 and 'Art' otherwise.*/

SELECT teacher.name,
CASE 
WHEN teacher.dept IN (1,2)
THEN 'Sci'
Else 'Art'
END
From teacher;


/* Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, 
show 'Art' if the teacher's dept is 3 and 'None' otherwise. */

SELECT teacher.name,
CASE 
WHEN teacher.dept IN (1,2)
THEN 'Sci'
WHEN teacher.dept IN (3)
THEN 'Art'
Else 'None'
END;



/* The example uses a WHERE clause to show the cases in 'Italy' in March.

Modify the query to show data from Spain */

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;



/* The LAG function is used to show data from the preceding row or the table. 

When lining up rows the data is partitioned by country name and ordered by the data whn. 

That means that only data from Italy is considered.

Modify the query to show confirmed for the day before.

Note on LAG with MySQL. */




/* How many stops are in the database. */

SELECT COUNT(id) FROM stops;




/* Find the id value for the stop 'Craiglockhart' */

SELECT id FROM stops
WHERE name = 'Craiglockhart';




/* Give the id and the name for the stops on the '4' 'LRT' service. */

SELECT id, name
FROM stops
JOIN route
ON stops.id = route.stop
WHERE num = '4' AND company = 'LRT';




/* The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes.*/

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;




/* Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. 
Change the query so that it shows the services from Craiglockhart to London Road.*/

SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON (a.num = b.num)
WHERE a.stop = 53
AND b.stop = 149;



/* The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. 
Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
If you are tired of these places try 'Fairmilehead' against 'Tollcross'*/

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';




/* Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') */

SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;



/* Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' */

SELECT a.company, a.num
FROM route a 
JOIN route b 
ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'Tollcross';



/* Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. 
Include the company and bus no. of the relevant services.*/

SELECT DISTINCT stopb.name, a.company, a.num
FROM route a 
JOIN route b 
ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart';


/* Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.*/

SELECT S.num, S.company, S.name, T.num, T.company 
FROM 
    (SELECT DISTINCT a.num, a.company, sb.name 
     FROM route a JOIN route b ON (a.num = b.num and a.company = b.company) 
                  JOIN stops sa ON sa.id = a.stop 
                  JOIN stops sb ON sb.id = b.stop 
     WHERE sa.name = 'Craiglockhart' AND sb.name <> 'Craiglockhart'
)S

JOIN

    (SELECT x.num, x.company, sy.name 
     FROM route x JOIN route y ON (x.num = y.num and x.company = y.company) 
                  JOIN stops sx ON sx.id = x.stop 
                  JOIN stops sy ON sy.id = y.stop 
     WHERE sx.name = 'Lochend' AND sy.name <> 'Lochend'
    )T

ON (S.name = T.name)
ORDER BY S.num, S.name, T.num




/* The example uses a WHERE clause to show the cases in 'Italy' in March.

Modify the query to show data from Spain */

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;



/* The LAG function is used to show data from the preceding row or the table. 

When lining up rows the data is partitioned by country name and ordered by the data whn. 

That means that only data from Italy is considered.

Modify the query to show confirmed for the day before.

Note on LAG with MySQL */

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;


/* The number of confirmed case is cumulative - but we can use LAG to recover the number of new cases reported for each day.

Show the number of new cases for each day, for Italy, for March. */




/* The data gathered are necessarily estimates and are inaccurate. 

However by taking a longer time span we can mitigate some of the effects.

You can filter the data to view only Monday's figures WHERE WEEKDAY(whn) = 0.

Show the number of new cases in Italy for each week - show Monday only. */

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'),tw.confirmed-lw.confirmed
FROM covid tw LEFT JOIN covid lw ON (
        DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
        AND tw.name=lw.name )
WHERE tw.name = 'Italy' AND WEEKDAY(tw.whn)=0
ORDER BY tw.whn;



/* You can JOIN a table using DATE arithmetic. This will give different results if data is missing.

Show the number of new cases in Italy for each week - show Monday only.

In the sample query we JOIN this week tw with last week lw using the DATE_ADD function. */

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
       confirmed - LAG(confirmed, 1) 
  OVER (PARTITION BY name ORDER BY whn) newcases
  FROM covid
 WHERE name = 'Italy'
   AND WEEKDAY(whn) = 0
 ORDER BY whn;



 /* The query shown shows the number of confirmed cases together with the world ranking for cases.

United States has the highest number, Spain is number 2...

Notice that while Spain has the second highest confirmed cases, Italy has the second highest number of deaths due to the virus.

Include the ranking for the number of deaths in the table. */

SELECT name,confirmed,RANK() OVER (ORDER BY confirmed DESC) rc,
       deaths,RANK() OVER (ORDER BY deaths DESC)
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;



/* The query shown includes a JOIN t the world table so we can access the total population of each country and calculate infection rates (in cases per 100,000).

Show the infect rate ranking for each country. Only include countries with a population of at least 10 million. */

SELECT world.name,
       ROUND(100000*confirmed/population,0),
       RANK() OVER (ORDER BY confirmed/population) AS rank
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC;



/* For each country that has had at last 1000 new cases in a single day, show the date of the peak number of new cases. */


