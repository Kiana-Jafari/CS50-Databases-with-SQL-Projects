-- Your general manager asks you whether the team should trade a current player for Cal Ripken Jr., a star player who’s likely nearing his retirement.
-- In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.
-- Sort by year in descending order.
-- Your query should return a table with two columns, one for year and one for salary.

SELECT year, salary
FROM salaries
WHERE player_id = (
    SELECT id
    FROM players
    WHERE first_name = 'Cal'
    AND last_name = 'Ripken'
)
GROUP BY year
ORDER BY year DESC;
