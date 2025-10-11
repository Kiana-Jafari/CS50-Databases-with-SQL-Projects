-- Users
    -- The heart of LinkedIn’s platform is its people.
    -- Your database should be able to represent the following information about LinkedIn’s users:
    -- Their first and last name
    -- Their username
    -- Their password
/*
Keep in mind that, if a company is following best practices, application passwords are “hashed.”
No need to worry about hashing passwords here, though it might be helpful to know that some hashing algorithms can produce strings up to 128 characters long.
*/

CREATE TABLE `users` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(64) NOT NULL,
    `last_name` VARCHAR(64) NOT NULL,
    `username` VARCHAR(64) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY(`id`)
);


-- Schools and Universities
    -- LinkedIn also allows for official school or university accounts, such as that for Harvard, so alumni can identify their affiliation.
    -- Ensure that LinkedIn’s database can store the following information about each school:
    -- The name of the school
    -- The type of school (e.g., “Elementary School”, “Middle School”, “High School”, “Lower School”, “Upper School”, “College”, “University”, etc.)
    -- The school’s location
    -- The year in which the school was founded
/*
You should assume that LinkedIn only allows schools to choose one of four types:
“Primary,” “Secondary,” “Higher Education”, and “University”
*/

CREATE TABLE `schools` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL,
    `type` ENUM('Primary', 'Secondary', 'Higher Education', 'University') NOT NULL,
    `location` VARCHAR(64) NOT NULL,
    `year` CHAR(4) NOT NULL,
    PRIMARY KEY(`id`)
);


-- Companies
    -- LinkedIn allows companies to create their own pages, like the one for LinkedIn itself, so employees can identify their past or current employment with the company.
    -- Ensure that LinkedIn’s database can store the following information for each company:
    -- The name of the company
    -- The company’s industry (e.g., “Education”, “Technology, “Finance”, etc.)
    -- The company’s location
/*
You should assume that LinkedIn only allows companies to choose from one of three industries:
“Technology,” “Education,” and “Business.”
*/

CREATE TABLE `companies` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL,
    `industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` VARCHAR(64) NOT NULL,
    PRIMARY KEY(`id`)
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

CREATE TABLE `connections` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `user_id` INT UNSIGNED,
    `school_id` INT UNSIGNED,
    `company_id` INT UNSIGNED,
    `start_date` DATE,
    `end_date` DATE,
    `degree` ENUM('BA', 'MA', 'PhD'),
    `job_title` VARCHAR(64),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);


/*
Sample Data

Your database should be able to represent…

1. A user, Claudine Gay, whose username is “claudine” and password is “password”.

INSERT INTO `users` (`id`, `first_name`, `last_name`, `username`, `password`)
VALUES (1, 'Claudine', 'Gay', 'claudine', 'password');

SELECT * FROM `users`;
+----+------------+-----------+----------+----------+
| id | first_name | last_name | username | password |
+----+------------+-----------+----------+----------+
|  1 | Claudine   | Gay       | claudine | password |
+----+------------+-----------+----------+----------+

2. A user, Reid Hoffman whose username is “reid” and password is “password”.

INSERT INTO `users` (`first_name`, `last_name`, `username`, `password`)
VALUES ('Reid', 'Hoffman', 'reid', 'password');

SELECT * FROM `users`;
+----+------------+-----------+----------+----------+
| id | first_name | last_name | username | password |
+----+------------+-----------+----------+----------+
|  1 | Claudine   | Gay       | claudine | password |
|  2 | Reid       | Hoffman   | reid     | password |
+----+------------+-----------+----------+----------+

3. A school, Harvard University, which is a university located in Cambridge, Massachusetts, founded in 1636.

INSERT INTO `schools`
VALUES (1, 'Harvard', 'University', 'Cambridge, Massachusetts', 1636);

SELECT * FROM `schools`;
+----+---------+------------+--------------------------+------+
| id |  name   |    type    |         location         | year |
+----+---------+------------+--------------------------+------+
| 1  | Harvard | University | Cambridge, Massachusetts | 1636 |
+----+---------+------------+--------------------------+------+

4. A company, LinkedIn, which is a technology company headquartered in Sunnyvale, California.

INSERT INTO `companies`
VALUES (1, 'LinkedIn', 'Technology', 'Sunnyvale, California');

SELECT * FROM `companies`;
+----+----------+------------+-----------------------+
| id |   name   |  industry  |       location        |
+----+----------+------------+-----------------------+
| 1  | LinkedIn | Technology | Sunnyvale, California |
+----+----------+------------+-----------------------+

5. Claudine Gay’s connection with Harvard, pursuing a PhD from January 1st, 1993, to December 31st, 1998.

INSERT INTO `connections` (`id`, `user_id`, `school_id`, `start_date`, `end_date`, `degree`)
VALUES (1, 1, 1, '1993-01-01', '1998-12-31', 'PhD');

SELECT * FROM `connections`;
+----+---------+-----------+------------+------------+------------+--------+-----------+
| id | user_id | school_id | company_id | start_date | end_date   | degree | job_title |
+----+---------+-----------+------------+------------+------------+--------+-----------+
|  1 |       1 |         1 |       NULL | 1993-01-01 | 1998-12-31 | PhD    | NULL      |
+----+---------+-----------+------------+------------+------------+--------+-----------+


6. Reid Hoffman’s connection with LinkedIn, with title “CEO and Chairman”, from January 1st, 2003 to February 1st, 2007

INSERT INTO `connections` (`user_id`, `company_id`, `start_date`, `end_date`, `job_title`)
VALUES (2, 1, '2003-01-01', '2007-02-01', 'CEO and Chairman');

SELECT * FROM `connections`;
+----+---------+-----------+------------+------------+------------+--------+------------------+
| id | user_id | school_id | company_id | start_date | end_date   | degree | job_title        |
+----+---------+-----------+------------+------------+------------+--------+------------------+
|  1 |       1 |         1 |       NULL | 1993-01-01 | 1998-12-31 | PhD    | NULL             |
|  2 |       2 |      NULL |          1 | 2003-01-01 | 2007-02-01 | NULL   | CEO and Chairman |
+----+---------+-----------+------------+------------+------------+--------+------------------+
*/
