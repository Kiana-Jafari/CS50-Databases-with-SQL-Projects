-- Your team is working on archiving old data. In 2.sql, write a SQL query to find the names of districts that are no longer operational.
-- NOTE: Districts that are no longer operational have “(non-op)” at the end of their name.

SELECT name
FROM districts
WHERE name LIKE '%(non-op)';
