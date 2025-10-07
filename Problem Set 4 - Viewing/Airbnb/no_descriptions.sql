-- In no_descriptions.sql, write a SQL statement to create a view named no_descriptions that includes all of the columns in the listings table except for description.

CREATE VIEW "no_descriptions" AS
SELECT "id", "property_type", "host_name", "accommodates", "bedrooms"
FROM "listings";

/*
SELECT * FROM "no_descriptions" LIMIT 5;
+-------+--------------------+-----------+--------------+----------+
|  id   |   property_type    | host_name | accommodates | bedrooms |
+-------+--------------------+-----------+--------------+----------+
| 3781  | Entire rental unit | Frank     | 2            | 1        |
| 5506  | Entire guest suite | Terry     | 2            | 1        |
| 6695  | Entire condo       | Terry     | 4            | NULL     |
| 8789  | Entire rental unit | Anne      | 2            | 1        |
| 10813 | Entire rental unit | Michelle  | 2            | NULL     |
+-------+--------------------+-----------+--------------+----------+
*/

-- How many listings are there in total?

SELECT COUNT(*) AS "counts"
FROM "no_descriptions";

/*
+--------+
| counts |
+--------+
| 3973   |
+--------+
*/
