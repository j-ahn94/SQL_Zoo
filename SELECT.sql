/************************
THIS SQL ASSIGNMENT COVERS THE FOLLOWING SECTIONS:
0 Basics
1 Names
2 World
3 Nobel
4 SELECT within SELECT
5 SUM and COUNT
************************/

/* Find the country that start with Y */

SELECT name FROM world
    WHERE name LIKE 'Y%'



/* Find the countries that end with y */

SELECT name FROM world
    WHERE name LIKE '%y'



/* Find the coutnries that contain the letter x */

SELECT name FROM world
    WHERE name LIKE '%x%'



/* Find the countries that end with land */

SELECT name FROM world
    WHERE name LIKE '%land'



/* Find the countries that start with C and end with ia */

SELECT name FROM world
    WHERE name LIKE 'C%' and '%ia'



/* Find the country that has oo in the name */

SELECT name FROM world
    WHERE name LIKE '%oo%'



/* Find the countries that have three or more a in the name */

SELECT name FROM world
    WHERE name LIKE '%a%a%a%'



/* Find the countries that have 't' as the second character */

SELECT name FROM world
    WHERE name LIKE '_t%'



/* Find the countries that have two "o" characters separated by two others */

SELECT name FROM world
    WHERE name LIKE '%o__o%'



/* Find the countries that have exactly four character */

SELECT name FROM world
    WHERE name LIKE '____'



/* Find the country where the name is the capital city */

SELECT name, capital FROM world
    WHERE capital = name



/* Find the country where the name is the capital city */

SELECT name FROM world
    WHERE name LIKE capital




/* Find the country where the capital is the country plus "City" */

SELECT name FROM world
    WHERE capital LIKE concat(name, '%City')



/* Find the capital and the name where the capital includes the name of the country */

SELECT capital, name FROM world
    WHERE capital LIKE concat('%', name, '%')



/* Find the capital and the name where the capital is an extension of name of the country */

SELECT capital, name FROM world
    WHERE capital LIKE concat('%', name, '%')
    AND capital <> name /* <> means 'not equal to' */



/* Show the name and the extension where the capital is an extension of name of the country */

SELECT name, REPLACE(capital, name, '') as extension FROM world
    WHERE capital LIKE concat(name, '_%')
    AND capital <> name



/* Observe the result of running this SQL command to show the name, continent and population of all countries */

SELECT name, continent, population FROM world



/* Show the name for the countries that have a population of at least 200 million (there are eight zeroes). */

SELECT name from world
    WHERE population >= 200000000



/* Give the name and the per capita GDP for those countries with a population of at least 200 million */

SELECT name, gdp/population from world
    WHERE population >= 200000000



/* Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions */

SELECT name, population/1000000 from world
    WHERE continent = 'South America'



/* Show the name and population for France, Germany, Italy */

SELECT name, population from world
    WHERE name IN ('France', 'Germany', 'Italy')



/* Show the countries which have a name that includes the word 'United' */

SELECT name from world
    WHERE name like '%United%'



/* Show the countries that are big by are or big by population. Show name, population and area */

SELECT name, population, area from world
    WHERE area > 3000000 OR population > 250000000



/* Show the countries that are big by area (more than 3 mil) or big by population (more than 250 mil) but not both.
Show name, population and area */

SELECT name, population, area from world
    WHERE area > 3000000 XOR population > 250000000



/* Show the name and population in millions and the GDP in billions for the countries of the
continent 'South America'. Use the ROUND function to show the values to two decimal places */

SELECT name, ROUND(population/1000000,2) As population, ROUND (gdp/1000000000,2) As gdp FROM world

WHERE continent = 'South America'



/* Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000. */

SELECT name, ROUND (gdp/population, -3) as 'per-capita GDP' from world

WHERE gdp >= 1000000000000



/* Show the name and capital where the name and the capital have the same number of characters. */

SELECT name, capital from world

WHERE LENGTH(name) = LENGTH(capital)




/* Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word. */

SELECT name, capital FROM world

WHERE LEFT(name,1) = LEFT(capital,1)

AND name <> capital;



/* Find the country that has all the vowels and no spaces in its name.

You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'
*/

SELECT name FROM world

WHERE name NOT LIKE '% %' AND name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND 

name LIKE '%u%'



/* Change the query shown so that it displays Nobel prizes for 1950 */

SELECT yr, subject, winner FROM nobel

WHERE yr like 1950;



/* Show who won the 1962 prize for Literature */

SELECT winner FROM nobel

WHERE yr = 1962 AND subject = 'Literature';



/* Show the year and subject that won 'Albert Einstein' his prize */

SELECT yr, subject FROM nobel

WHERE winner = 'Albert Einstein';



/* Give the name of the 'Peace' winners since the year 2000, including 2000. */

SELECT winner FROM nobel

WHERE subject = 'Peace' AND yr >= 2000;



/* Show all details (yr, subject, winner) of the 
Literature prize winners for 1980 to 1989 inclusive. */

SELECT yr, subject, winner FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 and 1989;




/* Show all details of the presidential winners:

Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama */

SELECT * FROM nobel
WHERE winner IN('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');




/* Show the winners with first name John */

SELECT winner FROM nobel
WHERE winner LIKE 'John %';




/* Show the year, subject, and name of Physics winners 
for 1980 together with the Chemistry winners for 1984. */

SELECT year, subject, winner FROM nobel
WHERE subject = 'Physics' AND yr = 1980 OR subject = 'Chemistry' AND yr = 1984;




/* Show the year, subject, and name of
 winners for 1980 excluding Chemistry and Medicine */

SELECT year, subject, winner FROM nobel
WHERE yr = 1980 AND subject <> 'Chemistry' AND subject <> 'Medicine';




/* Show year, subject, and name of people who won a 'Medicine' prize in 
an early year (before 1910, not including 1910) together 
with winners of a 'Literature' prize in a later year (after 2004, including 2004) */

SELECT year, subject, winner FROM nobel
WHERE yr < 1910 AND subject = 'Medicine' OR yr >= 2004 AND subject = 'Literature';




/* Find all details of the prize won by PETER GRÜNBERG

Non-ASCII characters */

SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG';




/* Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes */

SELECT * FROM nobel
WHERE winner = 'EUGENE O''NEILL';




/* Knights in order

List the winners, year and subject where the winner starts with Sir. 
Show the the most recent first, then by name order. */

SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir%';




/* Show the 1984 winners and subject ordered by 
subject and winner name; but list Chemistry and Physics last. */

SELECT winner, subject FROM nobel
WHERE yr = 1984 ORDER BY subject IN('Chemistry', 'Physics'), subject, winner




/* List each country name where the population is larger than that of 'Russia'. */

SELECT name FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Russia');




/* Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP */

SELECT name FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world where name = 'United Kingdom');




/* List the name and continent of countries in the continents 
containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent FROM world
WHERE continent IN ('South America', 'Oceania')
ORDER BY name;



/* Which country has a population that is more 
than Canada but less than Poland? Show the name and the population.*/

SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'CANADA') 
AND population < (SELECT population FROM world WHERE name = 'POLAND')



/* Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

*/

SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100,0), '%') As 'percentage' FROM world
WHERE continent = 'Europe'




/* Which countries have a GDP greater than every country in Europe? 
[Give the name only.] (Some countries may have NULL gdp values) */

SELECT name FROM world
WHERE gdp > ALL(SELECT gdp FROM world
WHERE continent = 'Europe' AND gdp>0)



/* Find the largest country (by area) in each continent, show the continent, the name and the area:

The above example is known as a correlated or synchronized sub-query.

Using correlated subqueries */

SELECT continent, name, area FROM world
 WHERE area IN (SELECT MAX(area) FROM world 
GROUP BY continent);



/* List each continent and the name of the country 
that comes first alphabetically. */

SELECT continent, name FROM world a
WHERE name <= ALL(SELECT name FROM world b WHERE a.continent = b.continent);



/* Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries 
associated with these continents. Show name, continent and population. */

SELECT name, continent, population 
from world a
where 25000000 >= ALL(SELECT b.population 
from world b where a.continent = b.continent and population > 0);





/* Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries associated with these continents. 
Show name, continent and population.
Some countries have populations more than three times that of any of their neighbours 
(in the same continent). Give the countries and continents. */ 

SELECT name, continent FROM world a
WHERE a.population >= ALL(select b.population * 3 FROM world b
WHERE b.continent = a.continent AND population > 0 AND a.name != b.name );




/* Show the total population of the world.

world(name, continent, area, population, gdp) */

SELECT SUM(population) FROM world;





/* List all the continents - just once each. */

SELECT DISTINCT continent FROM world;



/* Give the total GDP of Africa */

SELECT SUM(gdp) FROM world
WHERE continent = 'Africa';



/* How many countries have an area of at least 1000000 */

SELECT COUNT(name) FROM world
WHERE area >= 1000000;



/* What is the total population of ('Estonia', 'Latvia', 'Lithuania') */

SELECT SUM(population) FROM world
WHERE name IN('Estonia', 'Latvia', 'Lithuania');



/* For each continent show the continent and number of countries. */

SELECT DISTINCT continent, COUNT(name) FROM world
GROUP BY continent;



/* For each continent show the continent and number of 
countries with populations of at least 10 million. */

SELECT DISTINCT continent, COUNT(name) FROM world
WHERE population >= 10000000
GROUP BY continent;



/* List the continents that have a total population of at least 100 million.*/

SELECT continents FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;