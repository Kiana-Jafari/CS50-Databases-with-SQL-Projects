-- In 7.sql, write a SQL query to list the titles and topics of all episodes teaching fractions.

SELECT title, topic
FROM episodes
WHERE topic LIKE '%fractions%';
