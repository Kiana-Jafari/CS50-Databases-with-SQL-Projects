/*
    In 5.sql, write a SQL query to find the highest contrast value of prints by Hokusai.
    Name the column “Maximum Contrast”.
    Does Hokusai’s prints most contrasting print actually have much contrast?
*/

SELECT MAX(contrast) AS "Maximum Contrast"
FROM views
WHERE artist = 'Hokusai';
