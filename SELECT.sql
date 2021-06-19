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