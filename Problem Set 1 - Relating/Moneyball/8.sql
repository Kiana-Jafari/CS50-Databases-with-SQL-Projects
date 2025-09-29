-- How much would the A’s need to pay to get the best home run hitter this past season?
-- In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
-- Your query should return a table with one column, the salary of the player.

SELECT salaries.salary
FROM ((players
INNER JOIN salaries ON players.id = salaries.player_id)
INNER JOIN performances ON players.id = performances.player_id)
WHERE salaries.year = 2001
AND performances.HR = (
    SELECT MAX(HR)
    FROM performances
    WHERE year = 2001
)
ORDER BY performances.HR DESC
LIMIT 1;

/*
+----------+
|  salary  |
+----------+
| 10300000 |
+----------+
*/
