/*
    In 2.sql, write a SQL query to find the side (e.g., right or left) Babe Ruth hit.
*/

SELECT "bats"
FROM players
WHERE "first_name" = 'Babe' AND "last_name" = 'Ruth';
