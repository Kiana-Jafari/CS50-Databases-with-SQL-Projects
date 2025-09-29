-- You need a player that can get hits. Who might be the most underrated?
-- In 11.sql, write a SQL query to find the 10 least expensive players per hit in 2001.
-- Your query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
-- Sort the table by the “dollars per hit” column, least to most expensive.
-- If two players have the same “dollars per hit”, order by first name, followed by last name, in alphabetical order.
-- Ensure that the salary’s year and the performance’s year match.

SELECT players.first_name, players.last_name, (salaries.salary / performances.H) AS "dollars per hit"
FROM ((players
INNER JOIN salaries ON players.id = salaries.player_id)
INNER JOIN performances ON players.id = performances.player_id)
WHERE performances.H <> 0 AND (salaries.year = 2001 AND performances.year = 2001)
ORDER BY "dollars per hit" ASC, players.first_name ASC, players.last_name ASC
LIMIT 10;

/*
+------------+--------------+-----------------+
| first_name |  last_name   | dollars per hit |
+------------+--------------+-----------------+
| Albert     | Pujols       | 1030            |
| Juan       | Pierre       | 1064            |
| Jimmy      | Rollins      | 1111            |
| David      | Eckstein     | 1204            |
| Doug       | Mientkiewicz | 1295            |
| Luis       | Rivas        | 1333            |
| Terrence   | Long         | 1352            |
| Paul       | Lo Duca      | 1564            |
| Torii      | Hunter       | 1564            |
| Aramis     | Ramirez      | 1574            |
+------------+--------------+-----------------+
*/
