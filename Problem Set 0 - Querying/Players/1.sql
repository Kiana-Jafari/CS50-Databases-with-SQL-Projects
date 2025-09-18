/*
    In 1.sql, write a SQL query to find the hometown (including city, state, and country) of Jackie Robinson.
*/

SELECT "birth_city", "birth_state", "birth_country"
FROM players
WHERE "first_name" = 'Jackie' AND "last_name" = 'Robinson';
