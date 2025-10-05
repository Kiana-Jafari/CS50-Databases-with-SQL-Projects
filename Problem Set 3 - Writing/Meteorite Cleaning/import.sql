-- In import.sql, write a series of SQL (and SQLite) statements to import and clean the data from meteorites.csv into a table, meteorites, in a database called meteorites.db.


CREATE TABLE "test" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

.import --csv --skip 1 meteorites.csv test

SELECT * FROM "test" LIMIT 5;

/*
+----------+-----+----------+-------------+----------+-----------+--------+-----------+----------+
|   name   | id  | nametype |    class    |   mass   | discovery |  year  |    lat    |   long   |
+----------+-----+----------+-------------+----------+-----------+--------+-----------+----------+
| Aachen   | 1   | Valid    | L5          | 21.0     | Fell      | 1880.0 | 50.775    | 6.08333  |
| Aarhus   | 2   | Valid    | H6          | 720.0    | Fell      | 1951.0 | 56.18333  | 10.23333 |
| Abee     | 6   | Valid    | EH4         | 107000.0 | Fell      | 1952.0 | 54.21667  | -113.0   |
| Acapulco | 10  | Valid    | Acapulcoite | 1914.0   | Fell      | 1976.0 | 16.88333  | -99.9    |
| Achiras  | 370 | Valid    | L6          | 780.0    | Fell      | 1902.0 | -33.16667 | -64.95   |
+----------+-----+----------+-------------+----------+-----------+--------+-----------+----------+
*/

-- To consider the data in the meteorites table clean, you should ensure…

-- 1. Any empty values in meteorites.csv are represented by NULL in the meteorites table.
    -- Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.

UPDATE "test"
SET "mass" = NULL,
    "year" = NULL,
    "lat" = NULL,
    "long" = NULL
WHERE "mass" = '' OR "year" = '' OR "lat" = '' OR "long" = '';


-- 2. All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
    -- Keep in mind that the mass, lat, and long columns have decimal values.


UPDATE "test"
SET "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);


SELECT "mass", "lat", "long"
FROM "test"
LIMIT 5;

/*
+----------+--------+--------+
|   mass   |  lat   |  long  |
+----------+--------+--------+
| 21.0     | 50.77  | 6.08   |
| 720.0    | 56.18  | 10.23  |
| 107000.0 | 54.22  | -113.0 |
| 1914.0   | 16.88  | -99.9  |
| 780.0    | -33.17 | -64.95 |
+----------+--------+--------+
*/


-- 3. All meteorites with the nametype “Relict” are not included in the meteorites table.

-- What nametypes do we have?

SELECT DISTINCT "nametype", COUNT(*) AS "counts"
from "test"
GROUP BY "nametype";

/*
+----------+--------+
| nametype | counts |
+----------+--------+
| Relict   | 75     |
| Valid    | 45641  |
+----------+--------+
*/


DELETE FROM "test"
WHERE "nametype" = 'Relict';


-- 4. The meteorites are sorted by year, oldest to newest, and then—
    -- if any two meteorites landed in the same year—by name, in alphabetical order.


SELECT *
FROM "test"
ORDER BY "year" ASC, "name" ASC
LIMIT 5;

-- 5. You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
    -- The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.

CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id" AUTOINCREMENT)
);


INSERT INTO "meteorites" ("name", "nametype", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "nametype", "class", "mass", "discovery", "year", "lat", "long"
FROM "test"
ORDER BY "year" ASC, "name" ASC;


DROP TABLE "test";

/*
SELECT * FROM meteorites LIMIT 5;
+----+-------------------+----------+---------+------+-----------+------+------+------+
| id |       name        | nametype |  class  | mass | discovery | year | lat  | long |
+----+-------------------+----------+---------+------+-----------+------+------+------+
| 1  | Adelaide          | Valid    | C2-ung  | NULL | Found     | NULL | NULL | NULL |
| 2  | Aire-sur-la-Lys   | Valid    | Unknown | NULL | Fell      | NULL | NULL | NULL |
| 3  | Allan Hills 03541 | Valid    | H5      | NULL | Found     | NULL | NULL | NULL |
| 4  | Allan Hills 03542 | Valid    | L6      | NULL | Found     | NULL | NULL | NULL |
| 5  | Angers            | Valid    | L6      | NULL | Fell      | NULL | NULL | NULL |
+----+-------------------+----------+---------+------+-----------+------+------+------+
*/
