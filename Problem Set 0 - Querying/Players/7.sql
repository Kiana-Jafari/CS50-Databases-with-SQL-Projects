/*
    In 7.sql, write a SQL query to count the number of players who bat (or batted) right-handed and throw (or threw) left-handed, or vice versa.
*/

SELECT COUNT(*) AS counts
FROM players
WHERE ("bats" = 'R' AND "throws" = 'L')
OR ("bats" = 'L' AND "throws" = 'R');
