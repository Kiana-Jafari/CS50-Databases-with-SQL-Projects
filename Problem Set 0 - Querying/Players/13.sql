/*
    Write a SQL query to find the titles of episodes that have aired during the holiday season, usually in December in the United States.
*/

SELECT DISTINCT title, air_date
FROM episodes
WHERE air_date LIKE '%-12-%';
