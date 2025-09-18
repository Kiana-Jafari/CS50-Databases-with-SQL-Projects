-- In 8.sql, write a query that counts the number of episodes released in the last 6 years, from 2018 to 2023, inclusive.

SELECT COUNT(*) AS "number of episodes"
FROM episodes
WHERE air_date BETWEEN '2018-01-01' AND '2023-12-31';
