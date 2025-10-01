-- Passengers
    -- When it comes to our passengers, we just need to have the essentials in line:
    -- the first name, last name, and age. That’s all we need to know—nothing more.

CREATE TABLE passengers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    PRIMARY KEY("id")
    );

-- Check-Ins
    -- When passengers arrive at ATL, they’ll often “check in” to their flights.
    -- That’s them telling us they’re here and all set to board.
    -- We’d like to keep a tidy log of such moments. And what would we need to log, you ask?
    -- Well, here’s what we need: The exact date and time at which our passenger checked in
    -- The flight they are checking in for, of course. Can’t lose track of where they’re headed, now can we?

CREATE TABLE check_ins (
    "id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "date" NUMERIC NOT NULL,
    "time" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES passengers("id"),
    FOREIGN KEY("flight_id") REFERENCES flights("id")
    );

-- Airlines
    -- ATL’s a hub for many domestic and international airlines: names like Delta, British Airways, Air France, Korean Air, and Turkish Airlines. The list goes on.
    -- So here’s what we track: The name of the airline
    -- The “concourse” or, shall I say, the section of our airport where the airline operates.
    -- We have 7 concourses: A, B, C, D, E, F, and T.

CREATE TABLE airlines (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T')),
    PRIMARY KEY("id")
    );

-- Flights
    -- We serve as many as 1,000 flights daily. To ensure that our passengers are never left wondering, we need to give them all the critical details about their flight.
    -- Here’s what we’d like to store: The flight number. For example, “900”. Just know that we sometimes re-use flight numbers.
    -- The airline operating the flight. You can keep it simple and assume one flight is operated by one airline.
    -- The code of the airport they’re departing from. For example, “ATL” or “BOS”.
    -- The code of the airport they’re heading to
    -- The expected departure date and time (to the minute, of course!)
    -- The expected arrival date and time, to the very same accuracy

CREATE TABLE flights (
    "id" INTEGER,
    "airline_id" INTEGER,
    "depart_code" TEXT NOT NULL CHECK("depart_code" IN ('ATL', 'BOS')),
    "head_code" TEXT NOT NULL CHECK("head_code" IN ('ATL', 'BOS')),
    "departure_date" NUMERIC NOT NULL,
    "arrival_date" NUMERIC NOT NULL,
    "departure_time" NUMERIC NOT NULL,
    "arrival_time" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES airlines("id")
    );

/*
Sample Data

Your database should be able to represent…

A passenger, Amelia Earhart, who is 39 years old
An airline, Delta, which operates out of concourses A, B, C, D, and T
A flight, Delta Flight 300, which is expected to depart from ATL on August 3rd, 2023 at 6:46 PM and arrive at BOS on August 3rd, 2023 at 9:09 PM
A check-in for Amelia Earhart, for Delta Flight 300, on August 3rd, 2023 at 3:03 PM

INSERT INTO passengers
VALUES (12, 'Amelia', 'Earhart', 39);

SELECT * FROM passengers;
+----+------------+-----------+-----+
| id | first_name | last_name | age |
+----+------------+-----------+-----+
| 12 | Amelia     | Earhart   | 39  |
+----+------------+-----------+-----+

INSERT INTO airlines
VALUES (9, 'Delta', 'T');

SELECT * FROM airlines;
+----+-------+-----------+
| id | name  | concourse |
+----+-------+-----------+
| 9  | Delta | T         |
+----+-------+-----------+

INSERT INTO flights
VALUES (23, 9, 'ATL', 'BOS', '08/03/2023', '08/03/2023', '6:46 PM', '9:09 PM');

SELECT * FROM flights;
+----+------------+-------------+-----------+----------------+--------------+----------------+--------------+
| id | airline_id | depart_code | head_code | departure_date | arrival_date | departure_time | arrival_time |
+----+------------+-------------+-----------+----------------+--------------+----------------+--------------+
| 23 | 9          | ATL         | BOS       | 08/03/2023     | 08/03/2023   | 6:46 PM        | 9:09 PM      |
+----+------------+-------------+-----------+----------------+--------------+----------------+--------------+

INSERT INTO check_ins
VALUES (65, 12, 23, '08/03/2023', '3:03 PM');

SELECT * FROM check_ins;
+----+--------------+-----------+------------+---------+
| id | passenger_id | flight_id |    date    |  time   |
+----+--------------+-----------+------------+---------+
| 65 | 12           | 23        | 08/03/2023 | 3:03 PM |
+----+--------------+-----------+------------+---------+
*/
