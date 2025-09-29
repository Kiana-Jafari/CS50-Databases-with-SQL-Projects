-- You need to make a recommendation about which player (or players) to avoid recruiting.
-- In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball.
-- Your query should return a table with two columns, one for the player’s first name and one for their last name.

SELECT players.first_name, players.last_name
FROM players JOIN salaries ON players.id = salaries.player_id
WHERE salaries.salary = (
    SELECT MAX(salary)
    FROM salaries
);

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Alex       | Rodriguez |
+------------+-----------+
*/


-- Curious about the number of hits of this high-paid player in 2001?

SELECT performances.H AS "total hits in 2001"
FROM players JOIN performances ON players.id = performances.player_id
WHERE players.first_name = 'Alex'
AND players.last_name = 'Rodriguez'
AND performances.year = 2001;

/*
+--------------------+
| total hits in 2001 |
+--------------------+
| 201                |
+--------------------+
*/

-- What was the maximum number of hits in 2001, and by whom?

SELECT players.first_name, players.last_name, MAX(performances.H) AS "maximum number of hits in 2001"
FROM players JOIN performances ON players.id = performances.player_id
WHERE performances.year = 2001
AND performances.H = (
    SELECT MAX(H)
    FROM performances
    WHERE performances.year = 2001
    );
/*
+------------+-----------+--------------------------------+
| first_name | last_name | maximum number of hits in 2001 |
+------------+-----------+--------------------------------+
| Ichiro     | Suzuki    | 242                            |
+------------+-----------+--------------------------------+
*/
*/
