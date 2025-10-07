/*
In rural.sql, write a SQL statement to create a view named rural.
This view should contain all census records relating to a rural municipality (identified by including “rural” in their name).
Ensure the view contains all of the columns from the census table.
*/

CREATE VIEW "rural" AS
SELECT *
FROM "census"
WHERE "locality" LIKE '%Rural Municipality%';

-- How many rural districts are there?

SELECT COUNT(*) AS "counts"
FROM "rural";

/*
+--------+
| counts |
+--------+
| 461    |
+--------+
*/

-- How many families live in rural districts?

SELECT SUM("families") AS "total_families"
FROM "rural";

/*
+----------------+
| total_families |
+----------------+
| 2229834        |
+----------------+
*/
