/*
    In 5.sql, write a SQL query to return the first and last names of all right-handed batters.
    Sort the results alphabetically by first name, then by last name.
*/

SELECT "first_name", "last_name"
FROM players
WHERE "bats" = 'R'
ORDER BY "first_name", "last_name";
