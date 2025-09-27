-- Your colleague is preparing a map of all public schools in Massachusetts.
-- In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.

SELECT name, city
FROM schools
WHERE type = 'Public School' AND state = 'MA';
