-- A parent wants to send their child to a district with many other students.
-- In 8.sql, write a SQL query to display the names of all school districts and the number of pupils enrolled in each.

SELECT districts.name, expenditures.pupils
FROM districts JOIN expenditures ON districts.id = expenditures.district_id
GROUP BY name;
