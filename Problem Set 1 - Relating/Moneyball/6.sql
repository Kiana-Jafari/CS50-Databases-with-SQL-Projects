-- Which teams might be the biggest competition for the A’s this year?
-- In 6.sql, write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
-- Call the column representing total hits by players in 2001 “total hits”.
-- Sort by total hits, highest to lowest.
-- Your query should return two columns, one for the teams’ names and one for their total hits in 2001.

SELECT teams.name, SUM(performances.H) AS "total hits"
FROM teams JOIN performances ON teams.id = performances.team_id
WHERE performances.year = 2001
GROUP BY teams.name
ORDER BY SUM(performances.H) DESC
LIMIT 5;

/*
+-------------------+------------+
|       name        | total hits |
+-------------------+------------+
| Colorado Rockies  | 1663       |
| Seattle Mariners  | 1637       |
| Texas Rangers     | 1566       |
| Cleveland Indians | 1559       |
| Minnesota Twins   | 1514       |
+-------------------+------------+
*/
