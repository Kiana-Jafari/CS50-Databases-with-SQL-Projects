/*
    In 3.sql, write a SQL query to find the ids of rows for which a value in the column debut is missing.
*/

SELECT "id"
FROM players
WHERE "debut" IS NULL;
