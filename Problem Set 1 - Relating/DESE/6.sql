-- DESE wants to assess which schools achieved a 100% graduation rate.
-- In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.

SELECT name
FROM schools
WHERE id IN (
    SELECT school_id
    FROM graduation_rates
    WHERE graduated = 100
);

/*
+--------------------------------------------------------+
|                          name                          |
+--------------------------------------------------------+
| Tahanto Regional High                                  |
| O'Bryant School of Math & Science                      |
| Cohasset High School                                   |
| Global Learning Charter Public School                  |
| Bromfield                                              |
| Pioneer Valley Regional                                |
| Sizer School: A North Central Charter Essential School |
| Upper Cape Cod Vocational Technical                    |
| Weston High                                            |
+--------------------------------------------------------+
*/
