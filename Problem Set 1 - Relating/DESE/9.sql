-- Another parent wants to send their child to a district with few other students.
-- In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. Report only the name(s).

SELECT districts.name
FROM districts JOIN expenditures ON districts.id = expenditures.district_id
GROUP BY name
ORDER BY pupils ASC
LIMIT 1;

/*
+-------+
| name  |
+-------+
| Savoy |
+-------+
*/

-- Curious about the number of pupils attending the public school district "Savoy"?

SELECT pupils
FROM expenditures
WHERE district_id = (
  SELECT id
  FROM districts
  WHERE name = 'Savoy'
  );

/*
+--------+
| pupils |
+--------+
| 64     |
+--------+
*/

-- You can also check this number with the output of the query below, which gives us the minimum number of pupils in the expenditures table.

SELECT MIN(pupils) "AS minimum_pupils"
FROM expenditures;

/*
+----------------+
| minimum_pupils |
+----------------+
| 64             |
+----------------+
*/
