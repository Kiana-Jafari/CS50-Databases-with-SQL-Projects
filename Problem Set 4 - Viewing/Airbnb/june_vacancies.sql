/*
In june_vacancies.sql, write a SQL statement to create a view named june_vacancies.
This view should contain all listings and the number of days in June of 2023 that they remained vacant.
Ensure the view contains the following columns:

    • id, which is the id of the listing from the listings table.
    • property_type, from the listings table.
    • host_name, from the listings table.
    • days_vacant, which is the number of days in June of 2023, that the given listing was marked as available.
*/

CREATE VIEW "june_vacancies" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT(*) AS "days_vacant"
FROM "listings" JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "availabilities"."date" LIKE '2023-06%'
AND "availabilities"."available" = 'TRUE'
GROUP BY "listings"."id";

/*
SELECT * FROM "june_vacancies" LIMIT 5;
+--------+-----------------------------------+-------------+-------------+
|   id   |           property_type           |  host_name  | days_vacant |
+--------+-----------------------------------+-------------+-------------+
| 10813  | Entire rental unit                | Michelle    | 9           |
| 10986  | Entire condo                      | Michelle    | 9           |
| 67774  | Entire condo                      | Anne        | 1           |
| 184893 | Private room in bed and breakfast | Dawn        | 9           |
| 210097 | Entire home                       | Maria Elena | 2           |
+--------+-----------------------------------+-------------+-------------+
*/

-- How many listings were available in June 2023?

SELECT COUNT(*) AS "counts"
FROM "june_vacancies";

/*
+--------+
| counts |
+--------+
| 1895   |
+--------+
*/
