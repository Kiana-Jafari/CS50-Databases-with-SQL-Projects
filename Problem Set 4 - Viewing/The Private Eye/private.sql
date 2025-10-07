-- 1. Create a table called `positions` that has three columns as following:
    -- `sentence_id`: References the `id` column in the `sentences` table.
    -- `start_index`: The character number, within that sentence, at which the message begins.
    -- `length` : The message length in characters (i.e., how many characters to read from the first, including spaces and punctuation).

CREATE TABLE "positions" (
    "sentence_id" INTEGER,
    "start_index" INTEGER NOT NULL,
    "length" INTEGER NOT NULL,
    PRIMARY KEY("sentence_id"),
    FOREIGN KEY("sentence_id") REFERENCES "sentences"("id")
);


-- 2. Insert the values to the new-created table, positions.

INSERT INTO "positions"
VALUES
    (14, 98, 4),
    (114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5);

/*
SELECT * FROM "positions";
+-------------+-------------+--------+
| sentence_id | start_index | length |
+-------------+-------------+--------+
| 14          | 98          | 4      |
| 114         | 3           | 5      |
| 618         | 72          | 9      |
| 630         | 7           | 3      |
| 932         | 12          | 5      |
| 2230        | 50          | 7      |
| 2346        | 44          | 10     |
| 3041        | 14          | 5      |
+-------------+-------------+--------+

SELECT * FROM "sentences" LIMIT 5;
+----+------------------------------------------------------------------------------------------------------------+
| id |                                                  sentence                                                  |
+----+------------------------------------------------------------------------------------------------------------+
| 1  | To Sherlock Holmes she is always _the_ woman.                                                              |
| 2  | I have seldom heard him mention her under any other name.                                                  |
| 3  | In his eyes she eclipses and predominates the whole of her sex.                                            |
| 4  | It was not that he felt any emotion akin to love for Irene Adler.                                          |
| 5  | All emotions, and that one particularly, were abhorrent to his cold, precise, but admirably balanced mind. |
+----+------------------------------------------------------------------------------------------------------------+
*/


-- 3. Write a SQL sub-query that joins the two tables using the matching ids, and splits each sentence with its associated start index and sentence length.
    -- Also, create a view of the result-set. The view has a structure as follows:
    -- It should be named `message`
    -- It should have a single column, `phrase`

CREATE VIEW "message" AS
SELECT substr("sentences"."sentence", "positions"."start_index", "positions"."length") AS "phrase"
FROM "sentences" JOIN "positions" ON "sentences"."id" = "positions"."sentence_id";

/*
SELECT * FROM "message";
+------------+
|   phrase   |
+------------+
| find       |
| me in      |
| the place  |
| you        |
| least      |
| expect.    |
| behind the |
| books      |
+------------+
*/

-- Option 2. Using CTE

WITH "message" AS (
    SELECT "sentence", "start_index", "length"
    FROM "sentences" JOIN "positions" ON "sentences"."id" = "positions"."sentence_id"
)
SELECT substr("sentence", "start_index", "length")  AS "phrase"
FROM "message";

/*
+------------+
|   phrase   |
+------------+
| find       |
| me in      |
| the place  |
| you        |
| least      |
| expect.    |
| behind the |
| books      |
+------------+
*/
