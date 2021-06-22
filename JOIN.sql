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

