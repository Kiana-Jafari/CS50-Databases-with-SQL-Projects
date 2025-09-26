
-- *** The Lost Letter ***

/*
    Clerk, my name’s Anneke. I live over at 900 Somerville Avenue.
    Not long ago, I sent out a special letter. It’s meant for my friend Varsha.
    She’s starting a new chapter of her life at 2 Finnegan Street, uptown.
    (That address, let me tell you: it was a bit tricky to get right the first time.)
    The letter is a congratulatory note—a cheery little paper hug from me to her,
    to celebrate this big move of hers. Can you check if it’s made its way to her yet?
*/

-- Check whether the two addresses exist.

SELECT *
FROM addresses
WHERE address IN ('900 Somerville Avenue', '2 Finnegan Street');

/*
+-----+-----------------------+-------------+
| id  |        address        |    type     |
+-----+-----------------------+-------------+
| 432 | 900 Somerville Avenue | Residential |
+-----+-----------------------+-------------+
*/

-- There's no address called 'Finnegan'. Let's check if we can find something similar to the street name.

SELECT *
FROM addresses
WHERE address LIKE '2 F%';

/*
+------+-------------------+-------------+
|  id  |      address      |    type     |
+------+-------------------+-------------+
| 34   | 2 Federal Street  | Business    |
| 854  | 2 Finnigan Street | Residential |
| 1584 | 2 Friend Street   | Business    |
| 1967 | 2 Fenway Plaza    | Residential |
+------+-------------------+-------------+
*/

-- As expected, there's a typo in the name of the street.
-- Instead of the 'Finnegan', it has been written and delivered to 'Finnigan'.
-- Let's check the type, and id of the address that the package has been sent to.

SELECT *
FROM addresses
WHERE address IN ('900 Somerville Avenue', '2 Finnigan Street');

/*
+-----+-----------------------+-------------+
| id  |        address        |    type     |
+-----+-----------------------+-------------+
| 432 | 900 Somerville Avenue | Residential |
| 854 | 2 Finnigan Street     | Residential |
+-----+-----------------------+-------------+
*/

-- Both addresses have a same type of 'Residential'. Let's check the status of the package.
-- (i.e. Whether the letter has been sent or not.)

-- Check the package features that is a congratulatory letter sent from Anneke to Varsha.

SELECT *
FROM packages
WHERE contents LIKE '%Congratulatory%';

/*
+-----+-----------------------+-----------------+---------------+
| id  |       contents        | from_address_id | to_address_id |
+-----+-----------------------+-----------------+---------------+
| 384 | Congratulatory letter | 432             | 854           |
+-----+-----------------------+-----------------+---------------+
*/

SELECT *
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE contents LIKE '%Congratulatory%'
     );
/*
+----+-----------+------------+------------+--------+----------------------------+
| id | driver_id | package_id | address_id | action |         timestamp          |
+----+-----------+------------+------------+--------+----------------------------+
| 54 | 1         | 384        | 432        | Pick   | 2023-07-11 19:33:55.241794 |
| 94 | 1         | 384        | 854        | Drop   | 2023-07-11 23:07:04.432178 |
+----+-----------+------------+------------+--------+----------------------------+
*/

-- The letter has been picked up from Anneke's address, but it hasn't been delivered to Varsha's address yet.

-- *** The Devious Delivery ***

/*
    Good day to you, deliverer of the mail. You might remember that not too long ago I made my way over from the town of Fiftyville.
    I gave a certain box into your reliable hands and asked you to keep things low. My associate has been expecting the package for a while now.
    And yet, it appears to have grown wings and flown away. Ha! Any chance you could help clarify this mystery? Afraid there’s no “From” address.
    It’s the kind of parcel that would add a bit more… quack to someone’s bath times, if you catch my drift.
*/

-- Check whether there's null value in the from_address_id column of packages table.

SELECT *
FROM packages
WHERE from_address_id IS NULL;

/*
+------+---------------+-----------------+---------------+
|  id  |   contents    | from_address_id | to_address_id |
+------+---------------+-----------------+---------------+
| 5098 | Duck debugger | NULL            | 50            |
+------+---------------+-----------------+---------------+
*/

-- There's a package with id 5098 that has a null value in the from_address_id column.
-- Let's check the address type of the package with the id 5098.

SELECT type
FROM addresses
WHERE id = (
    SELECT address_id
    FROM scans
    WHERE package_id = 5098
    AND action = 'Drop'
);

/*
+----------------+
|      type      |
+----------------+
| Police Station |
+----------------+
*/

-- The address type is 'Police Station'. Based on what we saw in the previous query, the package with id 5098 is a 'Duck debugger'.
-- Let's check the status of the package.

SELECT *
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE from_address_id IS NULL
    );

/*
+-------+-----------+------------+------------+--------+----------------------------+
|  id   | driver_id | package_id | address_id | action |         timestamp          |
+-------+-----------+------------+------------+--------+----------------------------+
| 30123 | 10        | 5098       | 50         | Pick   | 2023-10-24 08:40:16.246648 |
| 30140 | 10        | 5098       | 348        | Drop   | 2023-10-24 10:08:55.610754 |
+-------+-----------+------------+------------+--------+----------------------------+
*/

-- *** The Forgotten Gift ***

/*
    Oh, excuse me, Clerk. I had sent a mystery gift, you see, to my wonderful granddaughter, off at 728 Maple Place.
    That was about two weeks ago. Now the delivery date has passed by seven whole days and I hear she still waits, her hands empty and heart filled with anticipation.
    I’m a bit worried wondering where my package has gone. I cannot for the life of me remember what’s inside, but I do know it’s filled to the brim with my love for her.
    Can we possibly track it down so it can fill her day with joy? I did send it from my home at 109 Tileston Street.
*/

-- Check whether the two addresses exist.

SELECT *
FROM addresses
WHERE address IN ('109 Tileston Street', '728 Maple Place');

/*
+------+---------------------+-------------+
|  id  |       address       |    type     |
+------+---------------------+-------------+
| 4983 | 728 Maple Place     | Residential |
| 9873 | 109 Tileston Street | Residential |
+------+---------------------+-------------+
*/

-- Let's check the contents of the package sent from '109 Tileston Street' to '728 Maple Place'.
-- We can check the package contents by using the from_address_id and to_address_id.

SELECT contents
FROM packages
WHERE to_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '728 Maple Place'
     );

/*
+----------+
| contents |
+----------+
| Flowers  |
+----------+
*/

SELECT contents
FROM packages
WHERE from_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '109 Tileston Street'
      );

/*
+----------+
| contents |
+----------+
| Flowers  |
+----------+
*/

-- Let's see who has the package.

SELECT name
FROM drivers
WHERE id = (
    SELECT driver_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE contents = 'Flowers' AND from_address_id = 9873 AND to_address_id = 4983
        )
    AND action = 'Pick'
    ORDER BY timestamp DESC
    );

/*
+-------+
| name  |
+-------+
| Mikel |
+-------+
*/
