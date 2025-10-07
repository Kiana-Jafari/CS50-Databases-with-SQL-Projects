/*
In available.sql, write a SQL statement to create a view named available.
This view should contain all dates that are available at all listings.
Ensure the view contains the following columns:

    • id, which is the id of the listing from the listings table.
    • property_type, from the listings table.
    • host_name, from the listings table.
    • date, from the availabilities table, which is the date of the availability.
*/

CREATE VIEW "available" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", "availabilities"."date"
FROM "listings" JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "availabilities"."available" = 'TRUE';

/*
SELECT * FROM "available" LIMIT 5;
+------+--------------------+-----------+------------+
|  id  |   property_type    | host_name |    date    |
+------+--------------------+-----------+------------+
| 3781 | Entire rental unit | Frank     | 2023-07-14 |
| 3781 | Entire rental unit | Frank     | 2023-07-15 |
| 3781 | Entire rental unit | Frank     | 2023-07-16 |
| 3781 | Entire rental unit | Frank     | 2023-07-17 |
| 3781 | Entire rental unit | Frank     | 2023-07-18 |
+------+--------------------+-----------+------------+
*/

-- How many listings have availability for December 31st, 2023 (i.e., “2023-12-31”)?

SELECT COUNT(*) AS "counts"
FROM "available"
WHERE "date" = '2023-12-31';

/*
+--------+
| counts |
+--------+
| 2251   |
+--------+
*/

-- How many of those are available on any type of boat?

SELECT COUNT(*) AS "counts"
FROM "available"
WHERE "date" = '2023-12-31' AND "property_type" LIKE '%Boat%';

/*
+--------+
| counts |
+--------+
| 7      |
+--------+
*/
