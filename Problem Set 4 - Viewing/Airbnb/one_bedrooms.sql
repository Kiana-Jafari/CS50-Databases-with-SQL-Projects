/*
In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms.
This view should contain all listings that have exactly one bedroom.
Ensure the view contains the following columns:

    • id, which is the id of the listing from the listings table.
    • property_type, from the listings table.
    • host_name, from the listings table.
    • accommodates, from the listings table.
*/

CREATE VIEW "one_bedrooms" AS
SELECT "id", "property_type", "host_name", "accommodates"
FROM "listings"
WHERE "bedrooms" = 1;

/*
SELECT * FROM "one_bedrooms" LIMIT 5;
+-------+--------------------+-----------+--------------+
|  id   |   property_type    | host_name | accommodates |
+-------+--------------------+-----------+--------------+
| 3781  | Entire rental unit | Frank     | 2            |
| 5506  | Entire guest suite | Terry     | 2            |
| 8789  | Entire rental unit | Anne      | 2            |
| 29765 | Entire rental unit | Elizabeth | 2            |
| 45987 | Entire rental unit | Atef      | 3            |
+-------+--------------------+-----------+--------------+
*/

-- How many one-bedroom listings are there?

SELECT COUNT(*) AS "counts"
FROM "one_bedrooms";

/*
+--------+
| counts |
+--------+
| 1228   |
+--------+
*/

-- And how many can accommodate at least 4 guests?

SELECT COUNT(*) AS "counts"
FROM "one_bedrooms"
WHERE "accommodates" >= 4;

/*
+--------+
| counts |
+--------+
| 222    |
+--------+
*/
