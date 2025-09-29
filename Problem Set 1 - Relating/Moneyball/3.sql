-- Your team is going to need a great home run hitter. Ken Griffey Jr., a long-time Silver Slugger and Gold Glove award winner, might be a good prospect.
-- In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.
-- Sort by year in descending order.
-- Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
-- Your query should return a table with two columns, one for year and one for home runs.

SELECT performances.year, performances.HR
FROM players JOIN performances ON players.id = performances.player_id
WHERE players.first_name = 'Ken'
AND players.last_name = 'Griffey'
AND players.birth_year = 1969
GROUP BY performances.year
ORDER BY performances.year DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Using Sub-query will give you the same result:

SELECT year, HR
FROM performances
WHERE player_id = (
    SELECT id
    FROM players
    WHERE first_name = 'Ken'
    AND last_name = 'Griffey'
    AND birth_year = 1969
)
GROUP BY year
ORDER BY year DESC;
