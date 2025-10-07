/*
In most_populated.sql, write a SQL statement to create a view named most_populated.
This view should contain, in order from greatest to least, the most populated districts in Nepal.
Ensure the view contains each of the following columns:

    • district, which is the name of the district.
    • families, which is the total number of families in the district.
    • households, which is the total number of households in the district.
    • population, which is the total population of the district.
    • male, which is the total number of people identifying as male in the district.
    • female, which is the total number of people identifying as female in the district.
*/

CREATE VIEW "most_populated" AS
SELECT "district", SUM(families) AS "families", SUM("households") AS "households",
SUM("population") AS "population", SUM("male") AS "male", SUM("female") AS "female"
FROM "census"
GROUP BY "district"
ORDER BY "population" DESC;

/*
SELECT * FROM "most_populated" LIMIT 5;
+-----------+----------+------------+------------+---------+--------+
| district  | families | households | population |  male   | female |
+-----------+----------+------------+------------+---------+--------+
| Kathmandu | 537916   | 275806     | 1988606    | 1001798 | 986808 |
| Morang    | 274651   | 241415     | 1147186    | 557527  | 589659 |
| Rupandehi | 241432   | 195087     | 1117667    | 546297  | 571370 |
| Jhapa     | 246138   | 219989     | 994090     | 477496  | 516594 |
| Sunsari   | 216874   | 181777     | 932452     | 452087  | 480365 |
+-----------+----------+------------+------------+---------+--------+
*/

-- Which district has the highest population? And how many households are in that district? Kathmandu, 275806

SELECT "district", "households"
FROM "most_populated"
WHERE "population" = (
    SELECT MAX("population")
    FROM "most_populated"
    );

/*
+-----------+------------+
| district  | households |
+-----------+------------+
| Kathmandu | 275806     |
+-----------+------------+
*/
