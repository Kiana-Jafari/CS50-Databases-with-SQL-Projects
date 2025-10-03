-- 1. Alter the password of the website’s administrative account, admin, to instead be “oops!”.

UPDATE "users"
SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username" = 'admin';

/*

FROM:
+----+----------+----------------------------------+
| id | username |             password             |
+----+----------+----------------------------------+
| 1  | admin    | e10adc3949ba59abbe56e057f20f883e |
+----+----------+----------------------------------+

TO:
+----+----------+----------------------------------+
| id | username |             password             |
+----+----------+----------------------------------+
| 1  | admin    | 982c0381c279d139fd221fce974916e7 |
+----+----------+----------------------------------+

*/

-- 2. Erase any logs of the above password change recorded by the database.

DELETE FROM "user_logs"
WHERE "new_username" = 'admin';

/*
+----+--------+--------------+--------------+--------------+----------------------------------+
| id |  type  | old_username | new_username | old_password |           new_password           |
+----+--------+--------------+--------------+--------------+----------------------------------+
| 2  | insert | NULL         | emily33      | NULL         | 44bf025d27eea66336e5c1133c3827f7 |
| 3  | insert | NULL         | zad28        | NULL         | 185f20cc5599d33a1a94eb426112c78a |
| 4  | insert | NULL         | mario17      | NULL         | ccce73b2ef30ecf08c9cf0e802fa9149 |
| 5  | insert | NULL         | ezra2        | NULL         | dbbe590bcc018ea53ca04caf89e0a98c |
| 6  | insert | NULL         | varsha15     | NULL         | 9ce87254bdeb236140b9f16382e88589 |
+----+--------+--------------+--------------+--------------+----------------------------------+
*/

-- Add false data to throw others off your trail.
-- In particular, to frame emily33, make it only appear—in the user_logs table—
-- as if the admin account has had its password changed to emily33’s password.

INSERT INTO "user_logs" ("type", "old_username", "new_username", "new_password")
SELECT 'update', 'admin', 'admin', (
    SELECT "password"
    FROM "users"
    WHERE "username" = 'emily33'
);

/*
+----+--------+--------------+--------------+--------------+----------------------------------+
| id |  type  | old_username | new_username | old_password |           new_password           |
+----+--------+--------------+--------------+--------------+----------------------------------+
| 51 | update | admin        | admin        | NULL         | 44bf025d27eea66336e5c1133c3827f7 |
+----+--------+--------------+--------------+--------------+----------------------------------+
*/
