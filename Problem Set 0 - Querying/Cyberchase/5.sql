-- In 5.sql, find the title of the holiday episode that aired on December 31st, 2004.

SELECT title
FROM episodes
WHERE air_date = '2004-12-31';
