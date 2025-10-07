/*
In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed.
This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed.
Ensure the view contains the following columns:

    • id, which is the id of the listing from the listings table.
    • property_type, from the listings table.
    • host_name, from the listings table.
    • reviews, which is the number of reviews the listing has received.
*/

CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT(*) AS "reviews"
FROM "listings" JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
GROUP BY "listings"."id"
ORDER BY COUNT(*) DESC
LIMIT 100;

/*
SELECT * FROM "frequently_reviewed" LIMIT 5;
+----------+----------------------+---------------------------------+---------+
|    id    |    property_type     |            host_name            | reviews |
+----------+----------------------+---------------------------------+---------+
| 4090224  | Entire home          | Tiffany                         | 860     |
| 18290558 | Private room in home | Boris & Susan                   | 786     |
| 815639   | Entire condo         | Jason                           | 773     |
| 916123   | Entire condo         | Jason                           | 767     |
| 18584891 | Private room in home | Roger Michael &Quot;Corey&Quot; | 733     |
+----------+----------------------+---------------------------------+---------+
*/

-- How many reviews does the most frequently reviewed property have? And who is the host of that property?

SELECT *
FROM "frequently_reviewed"
WHERE "reviews" = (
    SELECT MAX("reviews")
    FROM "frequently_reviewed"
);

/*
+---------+---------------+-----------+---------+
|   id    | property_type | host_name | reviews |
+---------+---------------+-----------+---------+
| 4090224 | Entire home   | Tiffany   | 860     |
+---------+---------------+-----------+---------+
*/
