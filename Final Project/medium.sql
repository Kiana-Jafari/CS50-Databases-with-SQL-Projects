/*
Step 1: Data Creation

    Create a table called 'medium_data'.
    Modify the type affinity of columns based on the CSV file.
*/

CREATE TABLE "medium_data" (
    "id" INTEGER,
    "url" TEXT,
    "title" TEXT,
    "subtitle" TEXT,
    "claps" INTEGER,
    "responses" INTEGER,
    "reading_time" INTEGER,
    "publication" TEXT CHECK("publication" IN ('Towards Data Science', 'UX Collective', 'The Startup', 'The Writing Cooperative', 'Data Driven Investor', 'Better Humans', 'Better Marketing')),
    "date" DATE,
    PRIMARY KEY("id" AUTOINCREMENT)
);

-- Add the data from the CSV file to the 'medium_data' column. Please note that the 'medium_data' column exists in a database called 'medium_articles'.

.import --csv data.csv medium_data --skip 1

-- Retrieve the first five records except for the 'url' and 'title'.

SELECT "id", "publication", "claps", "responses", "reading_time", "date"
FROM "medium_data"
LIMIT 5;

/*
+----+----------------------+-------+-----------+--------------+------------+
| id |     publication      | claps | responses | reading_time |    date    |
+----+----------------------+-------+-----------+--------------+------------+
| 1  | Towards Data Science | 850   | 8         | 8            | 2019-05-30 |
| 2  | Towards Data Science | 1100  | 11        | 9            | 2019-05-30 |
| 3  | Towards Data Science | 767   | 1         | 5            | 2019-05-30 |
| 4  | Towards Data Science | 354   | 0         | 4            | 2019-05-30 |
| 5  | Towards Data Science | 211   | 3         | 4            | 2019-05-30 |
+----+----------------------+-------+-----------+--------------+------------+
*/

/*
Step 2: Data Cleaning:

    Before running any queries, let's fix these issues:

        1. Some values in the "publication" column might have extra spaces.
            Remove the spaces from the column and save the new values.
        2. "responses" column has a value of 'Read'. Identify which publications or titles have "Read" in responses?
            Count how many “Read” entries exist per publication.
            Compare their reading_time and claps with others.
        3. Replace "Read" with NULL → exclude from averages.
*/

UPDATE "medium_data"
SET "publication" = trim("publication");

SELECT COUNT(*) AS "counts"
FROM "medium_data"
WHERE "responses" = 'Read';

/*
+--------+
| counts |
+--------+
| 2      |
+--------+
*/

SELECT "id", "publication", "claps", "responses", "reading_time", "date"
FROM "medium_data"
WHERE "responses" = 'Read';

/*
+------+----------------------+-------+-----------+--------------+------------+
|  id  |     publication      | claps | responses | reading_time |    date    |
+------+----------------------+-------+-----------+--------------+------------+
| 3978 | Data Driven Investor | 73    | Read      | 3            | 2019-05-24 |
| 6393 | UX Collective        | 74    | Read      | 5            | 2019-12-05 |
+------+----------------------+-------+-----------+--------------+------------+
*/

SELECT "title"
FROM "medium_data"
WHERE "responses" = 'Read';

/*
+-----------------------------------------------------------------------------+
|                                    title                                    |
+-----------------------------------------------------------------------------+
| What do you think of the Open Group’s Data Scientist Certification program? |
| UX doesn’t discriminate, it targets behaviours                              |
+-----------------------------------------------------------------------------+
*/

-- As we can see, the two stories with the 'Read' responses are likely discussion/opinion-oriented, or pulicy clarification.
-- So "Read" isn’t a numeric metric — it’s a flag that the metric type differs.

UPDATE "medium_data"
SET "responses" = NULL
WHERE "responses" = 'Read';

/*
Step 3: Data Analysis

Since we have engagement metrics (claps, responses) and metadata (date, publication, reading_time), we can do the following analysis:

    1. Publication-level performance
        A. Avg claps per publication
        B. Avg responses per publication
        C. Distribution of reading times per publication
        D. Which publications generate longest reads vs. most engagement
*/

SELECT "publication", ROUND(AVG("claps"), 2) AS "average_claps"
FROM "medium_data"
GROUP BY "publication"
ORDER BY ROUND(AVG("claps"), 2) DESC;

/*
+-------------------------+---------------+
|       publication       | average_claps |
+-------------------------+---------------+
| Better Humans           | 1827.79       |
| Better Marketing        | 829.35        |
| UX Collective           | 380.92        |
| The Writing Cooperative | 372.74        |
| The Startup             | 303.4         |
| Towards Data Science    | 283.63        |
| Data Driven Investor    | 95.03         |
+-------------------------+---------------+
*/

SELECT "publication", ROUND(AVG("responses"), 2) AS "average_responses"
FROM "medium_data"
GROUP BY "publication"
ORDER BY ROUND(AVG("responses"), 2) DESC;

/*
+-------------------------+-------------------+
|       publication       | average_responses |
+-------------------------+-------------------+
| Better Humans           | 8.54              |
| Better Marketing        | 4.62              |
| The Writing Cooperative | 3.16              |
| The Startup             | 1.79              |
| Towards Data Science    | 1.73              |
| UX Collective           | 1.47              |
| Data Driven Investor    | 0.37              |
+-------------------------+-------------------+
*/

-- Describe how long readers typically spend on articles in each publication.

SELECT "publication", ROUND(AVG("reading_time"), 2) AS "average_reading_time"
FROM "medium_data"
GROUP BY "publication"
ORDER BY ROUND(AVG("reading_time"), 2) DESC;

/*
+-------------------------+----------------------+
|       publication       | average_reading_time |
+-------------------------+----------------------+
| Better Humans           | 13.36                |
| Towards Data Science    | 7.28                 |
| Better Marketing        | 6.41                 |
| UX Collective           | 6.03                 |
| The Startup             | 5.91                 |
| Data Driven Investor    | 5.22                 |
| The Writing Cooperative | 4.97                 |
+-------------------------+----------------------+
*/

-- Q/A: Based on the result-sets above, which publication has the longest reads ratio? `Better Humans`
-- It's worth mentioning that the "Better Humans" publication not only has the longest reads ratio, but also the maximum average number of claps and responses.

-- 2. Time-based trends
    -- Identify which month(s) historically yield best engagement by creating a column called "engagement_score".

ALTER TABLE "medium_data"
ADD COLUMN "engagement_score" REAL;

UPDATE "medium_data"
SET "engagement_score" = 0.8 * "claps" + 0.2 * "responses";

SELECT "publication", "claps", "responses", "reading_time", "engagement_score", "date"
FROM "medium_data"
LIMIT 5;

/*
+----------------------+-------+-----------+--------------+------------------+------------+
|     publication      | claps | responses | reading_time | engagement_score |    date    |
+----------------------+-------+-----------+--------------+------------------+------------+
| Towards Data Science | 850   | 8         | 8            | 681.6            | 2019-05-30 |
| Towards Data Science | 1100  | 11        | 9            | 882.2            | 2019-05-30 |
| Towards Data Science | 767   | 1         | 5            | 613.8            | 2019-05-30 |
| Towards Data Science | 354   | 0         | 4            | 283.2            | 2019-05-30 |
| Towards Data Science | 211   | 3         | 4            | 169.4            | 2019-05-30 |
+----------------------+-------+-----------+--------------+------------------+------------+
*/

SELECT strftime('%Y-%m', "date") AS "month",
    ROUND(AVG("engagement_score"), 2) AS "engagement_score"
FROM "medium_data"
GROUP BY "month"
ORDER BY ROUND(AVG("engagement_score"), 2) DESC;

/*
+---------+------------------+
|  month  | engagement_score |
+---------+------------------+
| 2019-01 | 398.73           |
| 2019-04 | 397.39           |
| 2019-03 | 287.38           |
| 2019-08 | 284.84           |
| 2019-05 | 257.83           |
| 2019-09 | 257.24           |
| 2019-10 | 240.9            |
| 2019-11 | 218.79           |
| 2019-07 | 211.41           |
| 2019-02 | 204.94           |
| 2019-06 | 204.11           |
| 2019-12 | 202.33           |
+---------+------------------+
*/

-- The most engagement score was for the first month of the 2019. Some factors like holiday could possibly explain the reason behind this popularity.

-- What is the overall engagement score of each publication?

SELECT "publication", ROUND(AVG("engagement_score"), 2) AS "engagement_score"
FROM "medium_data"
GROUP BY "publication"
ORDER BY ROUND(AVG("engagement_score"), 2) DESC;

/*
+-------------------------+------------------+
|       publication       | engagement_score |
+-------------------------+------------------+
| Better Humans           | 1463.94          |
| Better Marketing        | 664.4            |
| UX Collective           | 305.03           |
| The Writing Cooperative | 298.83           |
| The Startup             | 243.08           |
| Towards Data Science    | 227.25           |
| Data Driven Investor    | 76.1             |
+-------------------------+------------------+
*/

-- 3. Content insight

    -- A. Top-performing publication(s) and title(s) (i.e. most claps, highest response ratio).
    -- B. Top 3 most active publications.

-- What are the number of claps and responses of the most popular stories in each publication? i.e. the stories with the maximum number of claps and responses.
-- Sort the publication names based on the maximum number of claps.

SELECT "publication", MAX("claps") AS "max_claps", MAX("responses") AS "max_responses"
FROM "medium_data"
GROUP BY "publication"
ORDER BY MAX("claps") DESC;

/*
+-------------------------+-----------+---------------+
|       publication       | max_claps | max_responses |
+-------------------------+-----------+---------------+
| The Startup             | 38000     | 170           |
| Better Marketing        | 23000     | 120           |
| The Writing Cooperative | 12600     | 117           |
| UX Collective           | 10500     | 86            |
| Better Humans           | 9700      | 28            |
| Towards Data Science    | 8000      | 32            |
| Data Driven Investor    | 4100      | 35            |
+-------------------------+-----------+---------------+
*/

-- What about the first month of 2019?

SELECT "publication", MAX("claps") AS "max_claps", MAX("responses") AS "max_responses"
FROM "medium_data"
WHERE "date" LIKE '2019-01%'
GROUP BY "publication"
ORDER BY MAX("claps") DESC;

/*
+-------------------------+-----------+---------------+
|       publication       | max_claps | max_responses |
+-------------------------+-----------+---------------+
| The Writing Cooperative | 6200      | 63            |
| The Startup             | 2000      | 21            |
| Towards Data Science    | 1500      | 16            |
| UX Collective           | 346       | 3             |
| Data Driven Investor    | 345       | 2             |
+-------------------------+-----------+---------------+
*/

-- Get the title of the most popular story with the maximum number of claps and responses associated with the publication "The Startup".

/*
EXPLAIN QUERY PLAN
   ...> SELECT "id", "title"
   ...> FROM "medium_data"
   ...> WHERE "claps" = (
   ...>     SELECT MAX("claps")
   ...>     FROM "medium_data"
   ...>     )
   ...> AND "responses" = (
   ...>     SELECT MAX("responses")
   ...>     FROM "medium_data"
   ...>     );
QUERY PLAN
|--SCAN medium_data
|--SCALAR SUBQUERY 1
|  `--SEARCH medium_data
`--SCALAR SUBQUERY 2
   `--SEARCH medium_data
*/

CREATE INDEX "story_title"
ON "medium_data"("title", "responses", "claps");

/*
EXPLAIN QUERY PLAN
   ...> SELECT "id", "title"
   ...> FROM "medium_data"
   ...> WHERE "claps" = (
   ...>     SELECT MAX("claps")
   ...>     FROM "medium_data"
   ...>     )
   ...> AND "responses" = (
   ...>     SELECT MAX("responses")
   ...>     FROM "medium_data"
   ...>     );
QUERY PLAN
|--SCAN medium_data USING COVERING INDEX story_title
|--SCALAR SUBQUERY 1
|  `--SEARCH medium_data USING COVERING INDEX story_title
`--SCALAR SUBQUERY 2
   `--SEARCH medium_data USING COVERING INDEX story_title
*/

SELECT "id", "title"
FROM "medium_data"
WHERE "claps" = (
    SELECT MAX("claps")
    FROM "medium_data"
    )
AND "responses" = (
    SELECT MAX("responses")
    FROM "medium_data"
    );

/*
+------+-------------------------------------------------------------+
|  id  |                            title                            |
+------+-------------------------------------------------------------+
| 4553 | I Have 15 ideas To Change Your Life. Do you Have 5 Minutes? |
+------+-------------------------------------------------------------+
*/

SELECT "publication", COUNT(*) AS "total_stories"
FROM "medium_data"
GROUP BY "publication"
ORDER BY COUNT(*) DESC
LIMIT 3;

/*
+----------------------+---------------+
|     publication      | total_stories |
+----------------------+---------------+
| The Startup          | 3041          |
| Towards Data Science | 1461          |
| Data Driven Investor | 777           |
+----------------------+---------------+
*/

-- Create a view called `monthly_summary` that includes the average responses per month.

CREATE VIEW "monthly_summary" AS
SELECT strftime('%Y-%m', "date") AS "month",
    ROUND(AVG("responses"), 2) AS "avg_responses"
FROM "medium_data"
GROUP BY "month";

SELECT * FROM "monthly_summary"
ORDER BY "avg_responses" DESC;

/*
+---------+---------------+
|  month  | avg_responses |
+---------+---------------+
| 2019-01 | 4.16          |
| 2019-04 | 2.99          |
| 2019-03 | 2.53          |
| 2019-08 | 2.09          |
| 2019-02 | 2.0           |
| 2019-05 | 1.95          |
| 2019-09 | 1.66          |
| 2019-06 | 1.53          |
| 2019-11 | 1.47          |
| 2019-10 | 1.44          |
| 2019-12 | 1.34          |
| 2019-07 | 1.31          |
+---------+---------------+
*/

-- Again, as we can see, the most average responses belong to the first month of 2019. This indicates that readers might have had mor time during the new year, thus, it would be more efficient for the publications/writers to write their stories in the January of each year.
