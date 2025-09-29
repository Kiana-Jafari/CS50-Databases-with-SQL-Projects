-- The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing, and their number of home runs for each year they’ve been playing.
-- Order the results, first and foremost, by player’s IDs (least to greatest).
-- Order rows about the same player by year, in descending order.
-- Consider a corner case: suppose a player has multiple salaries or performances for a given year.
    -- Order them first by number of home runs, in descending order, followed by salary, in descending order.
-- Be careful to ensure that, for a single row, the salary’s year and the performance’s year match.

SELECT players.first_name, players.last_name, salaries.salary, performances.HR, salaries.year
FROM ((players
INNER JOIN salaries ON players.id = salaries.player_id)
INNER JOIN performances ON players.id = performances.player_id)
WHERE salaries.year = performances.year
ORDER BY players.id ASC, salaries.year DESC, performances.HR DESC, salaries.year DESC;
