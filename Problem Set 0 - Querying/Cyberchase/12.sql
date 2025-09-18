-- In 12.sql, count the number of unique episode titles.

SELECT COUNT(DISTINCT title) AS "number of unique episodes"
FROM episodes;
