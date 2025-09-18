/*
    In 9.sql, write a SQL query to find the English title and artist of the print with the highest brightness.
*/

SELECT english_title, artist
FROM views
WHERE brightness = (
    SELECT MAX(brightness)
    FROM views
    );
