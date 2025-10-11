-- Users
    -- The heart of LinkedIn’s platform is its people.
    -- Your database should be able to represent the following information about LinkedIn’s users:
    -- Their first and last name
    -- Their username
    -- Their password

CREATE TABLE users (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);


-- Schools and Universities
    -- LinkedIn also allows for official school or university accounts, such as that for Harvard, so alumni can identify their affiliation.
    -- Ensure that LinkedIn’s database can store the following information about each school:
    -- The name of the school
    -- The type of school (e.g., “Elementary School”, “Middle School”, “High School”, “Lower School”, “Upper School”, “College”, “University”, etc.)
    -- The school’s location
    -- The year in which the school was founded

CREATE TABLE schools (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University')),
    "location" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    PRIMARY KEY("id")
);


-- Companies
    -- LinkedIn allows companies to create their own pages, like the one for LinkedIn itself, so employees can identify their past or current employment with the company.
    -- Ensure that LinkedIn’s database can store the following information for each company:
    -- The name of the company
    -- The company’s industry (e.g., “Education”, “Technology, “Finance”, etc.)
    -- The company’s location

CREATE TABLE companies (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL CHECK("industry" IN ('Education', 'Technology', 'Finance')),
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);


-- Connections
    -- And finally, the essence of LinkedIn is its ability to facilitate connections between people.
    -- Ensure LinkedIn’s database can support each of the following connections:
    -- Connections with People
    -- Connections with Schools
        -- The start date of their affiliation (i.e., when they started to attend the school)
        -- The end date of their affiliation (i.e., when they graduated), if applicable
        -- The type of degree earned/pursued (e.g., “BA”, “MA”, “PhD”, etc.)
    -- Connections with Companies
        -- The start date of their affiliation (i.e., the date they began work with the company)
        -- The end date of their affiliation (i.e., when left the company), if applicable
        -- The title they held while affiliated with the company

CREATE TABLE connections (
    "id" INTEGER,
    "user_id" INTEGER,
    "school_id" INTEGER,
    "company_id" INTEGER,
    "start_date" NUMERIC,
    "end_date" NUMERIC,
    "degree" TEXT CHECK("degree" IN ('BA', 'MA', 'PhD')),
    "job_title" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES users("id"),
    FOREIGN KEY("school_id") REFERENCES schools("id"),
    FOREIGN KEY("company_id") REFERENCES companies("id")
);


/*
Sample Data

Your database should be able to represent…

1. A user, Alan Garber, whose username is “alan” and password is “password”.

INSERT INTO users ("id", "first_name", "last_name", "username", "password")
VALUES (1, 'Alan', 'Garber', 'alan', 'password');

SELECT * FROM users;
+----+------------+-----------+----------+----------+
| id | first_name | last_name | username | password |
+----+------------+-----------+----------+----------+
| 1  | Alan       | Garber    | alan     | password |
+----+------------+-----------+----------+----------+

2. A user, Reid Hoffman whose username is “reid” and password is “password”.

INSERT INTO users ("id", "first_name", "last_name", "username", "password")
VALUES (2, 'Reid', 'Hoffman', 'reid', 'password');

SELECT * FROM users;
+----+------------+-----------+----------+----------+
| id | first_name | last_name | username | password |
+----+------------+-----------+----------+----------+
| 1  | Alan       | Garber    | alan     | password |
| 2  | Reid       | Hoffman   | reid     | password |
+----+------------+-----------+----------+----------+

3. A school, Harvard University, which is a university located in Cambridge, Massachusetts, founded in 1636.

INSERT INTO schools
VALUES (1, 'Harvard', 'University', 'Cambridge, Massachusetts', 1636);

SELECT * FROM schools;
+----+---------+------------+--------------------------+------+
| id |  name   |    type    |         location         | year |
+----+---------+------------+--------------------------+------+
| 1  | Harvard | University | Cambridge, Massachusetts | 1636 |
+----+---------+------------+--------------------------+------+

4. A company, LinkedIn, which is a technology company headquartered in Sunnyvale, California.

INSERT INTO companies
VALUES (1, 'LinkedIn', 'Technology', 'Sunnyvale, California');

SELECT * FROM companies;
+----+----------+------------+-----------------------+
| id |   name   |  industry  |       location        |
+----+----------+------------+-----------------------+
| 1  | LinkedIn | Technology | Sunnyvale, California |
+----+----------+------------+-----------------------+

5. Alan Garber’s undergraduate education at Harvard, pursuing a BA from September 1st, 1973 to June 1st, 1976.

INSERT INTO connections ("id", "user_id", "school_id", "start_date", "end_date", "degree")
VALUES (1, 1, 1, '09/01/1973', '06/01/1976', 'BA');

SELECT * FROM connections;
+----+---------+-----------+------------+------------+------------+--------+-----------+
| id | user_id | school_id | company_id | start_date |  end_date  | degree | job_title |
+----+---------+-----------+------------+------------+------------+--------+-----------+
| 1  | 1       | 1         | NULL       | 09/01/1973 | 06/01/1976 | BA     | NULL      |
+----+---------+-----------+------------+------------+------------+--------+-----------+

6. Reid Hoffman’s employment with LinkedIn as its CEO and Chairman, from January 1st, 2003 to February 1st, 2007.

INSERT INTO connections ("id", "user_id", "company_id", "start_date", "end_date", "job_title")
VALUES (2, 2, 1, '01/01/2003', '02/01/2007', 'CEO');

SELECT * FROM connections;
+----+---------+-----------+------------+------------+------------+--------+-----------+
| id | user_id | school_id | company_id | start_date |  end_date  | degree | job_title |
+----+---------+-----------+------------+------------+------------+--------+-----------+
| 1  | 1       | 1         | NULL       | 09/01/1973 | 06/01/1976 | BA     | NULL      |
| 2  | 2       | NULL      | 1          | 01/01/2003 | 02/01/2007 | NULL   | CEO       |
+----+---------+-----------+------------+------------+------------+--------+-----------+
*/
