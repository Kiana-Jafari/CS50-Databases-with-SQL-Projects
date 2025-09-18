-- In 2.sql, list the season number of, and title of, the first episode of every season.

SELECT season, title
FROM episodes 
WHERE episode_in_season = 1;
