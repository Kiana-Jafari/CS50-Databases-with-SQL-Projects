-- Find a student’s historical course enrollments, based on their ID:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "courses"."title", "courses"."semester"
   ...> FROM "enrollments"
   ...> JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
   ...> JOIN "students" ON "enrollments"."student_id" = "students"."id"
   ...> WHERE "students"."id" = 3;
QUERY PLAN
|--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
|--SCAN enrollments
`--SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
Run Time: real 0.001 user 0.000000 sys 0.000168
*/

CREATE INDEX "enrollments_index"
ON "enrollments"("student_id", "course_id");

/*
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT "courses"."title", "courses"."semester"
   ...> FROM "enrollments"
   ...> JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
   ...> JOIN "students" ON "enrollments"."student_id" = "students"."id"
   ...> WHERE "students"."id" = 3;
QUERY PLAN
|--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
|--SEARCH enrollments USING COVERING INDEX enrollments_index (student_id=?)
`--SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
Run Time: real 0.000 user 0.000151 sys 0.000016
*/

-- Find all students who enrolled in Computer Science 50 in Fall 2023:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "id", "name"
   ...> FROM "students"
   ...> WHERE "id" IN (
   ...>     SELECT "student_id"
   ...>     FROM "enrollments"
   ...>     WHERE "course_id" = (
   ...>         SELECT "id"
   ...>         FROM "courses"
   ...>         WHERE "courses"."department" = 'Computer Science'
   ...>         AND "courses"."number" = 50
   ...>         AND "courses"."semester" = 'Fall 2023'
   ...>     )
   ...> );
QUERY PLAN
|--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
`--LIST SUBQUERY 2
   |--SCAN enrollments
   |--SCALAR SUBQUERY 1
   |  `--SCAN courses
   `--CREATE BLOOM FILTER
Run Time: real 0.000 user 0.000173 sys 0.000018
*/

CREATE INDEX "enrollments_by_course"
ON "enrollments"("course_id", "student_id");

CREATE INDEX "courses_index"
ON "courses"("department", "number");

CREATE INDEX "courses_semester_index"
ON "courses"("semester");

/*
EXPLAIN QUERY PLAN
   ...> SELECT "id", "name"
   ...> FROM "students"
   ...> WHERE "id" IN (
   ...>     SELECT "student_id"
   ...>     FROM "enrollments"
   ...>     WHERE "course_id" = (
   ...>         SELECT "id"
   ...>         FROM "courses"
   ...>         WHERE "courses"."department" = 'Computer Science'
   ...>         AND "courses"."number" = 50
   ...>         AND "courses"."semester" = 'Fall 2023'
   ...>     )
   ...> );
QUERY PLAN
|--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
`--LIST SUBQUERY 2
   |--SEARCH enrollments USING COVERING INDEX enrollments_by_course (course_id=?)
   |--SCALAR SUBQUERY 1
   |  `--SEARCH courses USING INDEX courses_index (department=? AND number=?)
   `--CREATE BLOOM FILTER
Run Time: real 0.000 user 0.000000 sys 0.000192
*/

-- Sort courses by most- to least-enrolled in Fall 2023:

CREATE INDEX "courses_title_index"
ON "courses"("title");

/*
/EXPLAIN QUERY PLAN
   ...> SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
   ...> FROM "courses"
   ...> JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id"
   ...> WHERE "courses"."semester" = 'Fall 2023'
   ...> GROUP BY "courses"."id"
   ...> ORDER BY "enrollment" DESC;
QUERY PLAN
|--SEARCH courses USING INDEX courses_semester_index (semester=?)
|--SEARCH enrollments USING COVERING INDEX enrollments_by_course (course_id=?)
`--USE TEMP B-TREE FOR ORDER BY
*/

-- Find all computer science courses taught in Spring 2024:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
   ...> FROM "courses"
   ...> WHERE "courses"."department" = 'Computer Science'
   ...> AND "courses"."semester" = 'Spring 2024';
QUERY PLAN
`--SEARCH courses USING INDEX courses_semester_index (semester=?)
*/

-- Find the requirement satisfied by “Advanced Databases” in Fall 2023:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "requirements"."name"
   ...> FROM "requirements"
   ...> WHERE "requirements"."id" = (
   ...>     SELECT "requirement_id"
   ...>     FROM "satisfies"
   ...>     WHERE "course_id" = (
   ...>         SELECT "id"
   ...>         FROM "courses"
   ...>         WHERE "title" = 'Advanced Databases'
   ...>         AND "semester" = 'Fall 2023'
   ...>     )
   ...> );
QUERY PLAN
|--SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
`--SCALAR SUBQUERY 2
   |--SCAN satisfies
   `--SCALAR SUBQUERY 1
      `--SEARCH courses USING INDEX courses_title_index (title=?)
*/

CREATE INDEX "satisfies_index"
ON "satisfies"("course_id", "requirement_id");

/*
EXPLAIN QUERY PLAN
   ...> SELECT "requirements"."name"
   ...> FROM "requirements"
   ...> WHERE "requirements"."id" = (
   ...>     SELECT "requirement_id"
   ...>     FROM "satisfies"
   ...>     WHERE "course_id" = (
   ...>         SELECT "id"
   ...>         FROM "courses"
   ...>         WHERE "title" = 'Advanced Databases'
   ...>         AND "semester" = 'Fall 2023'
   ...>     )
   ...> );
QUERY PLAN
|--SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
`--SCALAR SUBQUERY 2
   |--SEARCH satisfies USING COVERING INDEX satisfies_index (course_id=?)
   `--SCALAR SUBQUERY 1
      `--SEARCH courses USING INDEX courses_title_index (title=?)
Run Time: real 0.000 user 0.000000 sys 0.000169
*/

-- Find how many courses in each requirement a student has satisfied:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "requirements"."name", COUNT(*) AS "courses"
   ...> FROM "requirements"
   ...> JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id"
   ...> WHERE "satisfies"."course_id" IN (
   ...>     SELECT "course_id"
   ...>     FROM "enrollments"
   ...>     WHERE "enrollments"."student_id" = 8
   ...> )
   ...> GROUP BY "requirements"."name";
QUERY PLAN
|--SEARCH satisfies USING COVERING INDEX satisfies_index (course_id=?)
|--LIST SUBQUERY 1
|  |--SEARCH enrollments USING COVERING INDEX enrollments_index (student_id=?)
|  `--CREATE BLOOM FILTER
|--SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
`--USE TEMP B-TREE FOR GROUP BY
Run Time: real 0.000 user 0.000098 sys 0.000100
*/

-- Search for a course by title and semester:

/*
EXPLAIN QUERY PLAN
   ...> SELECT "department", "number", "title"
   ...> FROM "courses"
   ...> WHERE "title" LIKE "History%"
   ...> AND "semester" = 'Fall 2023';
QUERY PLAN
`--SEARCH courses USING INDEX courses_semester_index (semester=?)
Run Time: real 0.000 user 0.000148 sys 0.000000
*/
