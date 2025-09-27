-- Which schools have a dropout rate higher than the average? List 5 of them.

SELECT name
FROM schools
WHERE id IN (
   SELECT school_id
   FROM graduation_rates
   WHERE dropped > (
      SELECT AVG(dropped)
      FROM graduation_rates
      )
   ORDER BY dropped
   )
LIMIT 5;

/*
+---------------------------------+
|              name               |
+---------------------------------+
| Amesbury Innovation High School |
| Athol High                      |
| Attleboro Community Academy     |
| Monument Mt Regional High       |
| Boston Adult Tech Academy       |
+---------------------------------+
*/
